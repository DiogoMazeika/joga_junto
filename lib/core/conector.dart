/* // ignore_for_file: use_build_context_synchronously

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:dnd/core/controller.dart';
import 'package:mobile_hsp/core/auth/login/conexao/login.dart';
import 'package:mobile_hsp/core/entity/usuario.dart';
import 'package:mobile_hsp/widgets/platform_widget/platform_alert_dialog.dart';
import 'package:mobile_hsp/widgets/platform_widget/platform_circular_progress.dart';
import 'package:mobile_hsp/widgets/platform_widget/platform_widget.dart';

enum ConectorErros { erro500, sessao, statusInvalido, none, semWifi }

const String _link = "https://basehspmobile.hspsoftware.com.br/";

class Conector with _ConectionAlert {
  static Conector? _this;

  factory Conector() {
    _this ??= Conector._getInstance();
    _this!.alert = false;
    return _this ?? Conector();
  }

  final String linkDefault = "https://basehspmobile.hspsoftware.com.br/";

  Conector._getInstance();

  final CookieJar _cookieJar = CookieJar();

  final BaseOptions _options = BaseOptions(
    validateStatus: (int? status) {
      return true;
    },
    receiveDataWhenStatusError: true,
  );

  late Dio conexao;

  Dio _conexao() {
    conexao = Dio();
    conexao.interceptors.add(CookieManager(_cookieJar));
    conexao.options = _options;
    return conexao;
  }

  void close() {
    conexao.close();
  }

  Future<ConectorResponse> post(
    String path, {
    Map<String, dynamic>? data,
    int status = 200,
    bool user = false,
    required Controller controller,
    int count = 0,
    String link = _link,
  }) async {
    bool valida = true;

    Response? retorno;
    try {
      retorno = await _conexao().post(
        link + path,
        data: FormData.fromMap(data ?? {}, ListFormat.multiCompatible),
      );

      if (controller.on &&
          !user &&
          Usuario().loginInfo &&
          retorno.data is Map &&
          retorno.data["login_info"] == false) {
        valida = await LoginController(controller.context).sessaoAtualizada();
        if (valida) {
          return post(
            path,
            data: data,
            status: status,
            user: user,
            controller: controller,
          );
        }
      }
    } catch (e) {
      if (count == 0) {
        for (int i = 1; i < 3; i++) {
          count++;
          ConectorResponse resp = await post(
            path,
            data: data,
            status: status,
            user: user,
            controller: controller,
            count: count,
          );
          if (resp.erro != ConectorErros.semWifi) {
            return resp;
          }
        }
      } else if (count > 0 && count < 3) {
        return ConectorResponse(null);
      }
      return await showAlert(
            controller,
            () => post(
              path,
              data: data,
              status: status,
              user: user,
              controller: controller,
              count: count,
            ),
          ) ??
          ConectorResponse(retorno, login: valida);
    }

    ConectorResponse resp = ConectorResponse(retorno, login: valida);
    close();
    return resp;
  }

  Future<ConectorResponse> get(
    String path, {
    Map<String, dynamic>? queryData,
    int status = 200,
    required Controller controller,
    int count = 0,
    String link = _link,
  }) async {
    bool valida = true;
    Response? retorno;
    try {
      retorno = await _conexao().get(link + path, queryParameters: queryData);

      if (controller.on &&
          Usuario().loginInfo &&
          retorno.data is Map &&
          retorno.data["login_info"] == false) {
        valida = await LoginController(controller.context).sessaoAtualizada();
        if (valida) {
          return get(
            path,
            queryData: queryData,
            status: status,
            controller: controller,
          );
        }
      }
    } catch (e) {
      if (count == 0) {
        for (int i = 1; i < 3; i++) {
          count++;
          ConectorResponse resp = await get(
            path,
            queryData: queryData,
            status: status,
            controller: controller,
            count: count,
          );
          if (resp.erro != ConectorErros.semWifi) {
            return resp;
          }
        }
      } else if (count > 0 && count < 3) {
        return ConectorResponse(null);
      }
      return await showAlert(
            controller,
            () {
              return get(
                path,
                controller: controller,
                status: status,
                queryData: queryData,
                count: count,
              );
            },
          ) ??
          ConectorResponse(retorno, login: valida);
    }

    ConectorResponse resp = ConectorResponse(retorno, login: valida);
    close();
    return resp;
  }
}

class ConectorResponse<T> {
  ConectorResponse(Response? resposta,
      {this.erro = ConectorErros.none, bool login = true}) {
    data = resposta?.data;
    status = resposta?.statusCode;
    if (status != 200) erro = ConectorErros.statusInvalido;
    if (!login) erro = ConectorErros.sessao;
    if (status == 500) erro = ConectorErros.erro500;
    if (resposta == null) erro = ConectorErros.semWifi;
    // this.erro = erro;
  }

  ConectorResponse.normal();
  T? data;
  int? status;
  ConectorErros erro = ConectorErros.none;

  @override
  String toString() {
    return 'data: $data\nstatus: $status\nerro: $erro';
  }
}

mixin _ConectionAlert {
  bool alert = false;

  Future<ConectorResponse?> showAlert(
      Controller controller, Future<ConectorResponse> Function() func) async {
    if (alert || !controller.on) {
      return null;
    }
    alert = true;

    return ShowPlatform<ConectorResponse>().showDialogP(
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: _ConectionAlertWidget(
            alert: (bool alert) {
              this.alert = alert;
            },
            func: func,
          ),
        );
      },
      context: controller.context,
    );
  }
}

class _ConectionAlertWidget extends StatefulWidget {
  const _ConectionAlertWidget({
    Key? key,
    required this.alert,
    required this.func,
  }) : super(key: key);

  final ValueChanged<bool> alert;
  final Future<ConectorResponse> Function() func;
  @override
  __ConectionAlertWidgetState createState() => __ConectionAlertWidgetState();
}

class __ConectionAlertWidgetState extends State<_ConectionAlertWidget> {
  @override
  void initState() {
    super.initState();
  }

  int vl = 0;
  bool conectando = false;
  UniqueKey key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    if (!conectando) {
      actions.add(SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            if (vl != 0) return;
            Future.delayed(const Duration(seconds: 3)).then((value) {
              vl = 0;
            });
            setState(() {
              conectando = true;
            });
            vl = -1;
            ConectorResponse resp = await widget.func();
            if (resp.erro != ConectorErros.semWifi) {
              widget.alert(false);
              Navigator.of(context).pop(resp);
            } else {
              setState(() {
                conectando = false;
                key = UniqueKey();
              });
            }
          },
          child: const Text("Tentar Novamente"),
        ),
      ));
    }
    return PlatformAlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      buttonPadding: const EdgeInsets.only(bottom: 10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(conectando ? "Estabelecendo conexão" : "Falha na conexão."),
          conectando
              ? const PlatformCircularProgress()
              : const Text(
                  "Verifique se seu dispositivo está conectado a internet.",
                ),
        ],
      ),
      actions: actions,
    );
  }
}
 */