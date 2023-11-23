/* import 'package:flutter/cupertino.dart';
import 'package:dnd/core/busca.dart';
import 'package:dnd/core/conector.dart';

abstract class Controller {
  Controller(this._context);
  final BuildContext _context;
  final Conector _conector = Conector();
  final List<Busca> buscas = [];
  bool _on = true;

  bool get on => _on;

  void dispose() {
    _on = false;
    for (Busca busca in buscas) {
      busca.dispose();
    }
  }

  Conector get conexao => _conector;
  BuildContext get context => _context;

  Future validaConexao() async {
    ConectorResponse resp = await conexao.get('login/teste', controller: this);
    return resp.erro == ConectorErros.semWifi;
  }

  @protected
  Future<ConectorResponse> get(
    String url, {
    Map<String, dynamic>? queryData,
    Busca? busca,
    int status = 200,
    String? link,
  }) async {
    if (busca != null) {
      buscas.add(busca);
    }
    ConectorResponse resposta = await conexao.get(
      url,
      controller: this,
      queryData: queryData,
      status: status,
      link: link ?? conexao.linkDefault,
    );
    buscas.remove(busca);
    return resposta;
  }

  @protected
  Future<ConectorResponse> post(
    String url, {
    Map<String, dynamic>? data,
    Busca? busca,
    int status = 200,
    bool user = false,
    String? link,
  }) async {
    if (busca != null) {
      buscas.add(busca);
    }
    ConectorResponse resposta = await conexao.post(
      url,
      controller: this,
      data: data,
      user: user,
      status: status,
      link: link ?? conexao.linkDefault,
    );
    buscas.remove(busca);
    return resposta;
  }
}
 */