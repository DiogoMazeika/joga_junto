import 'dart:math';
import 'package:flutter/material.dart';
import 'package:joga_junto/core/busca.dart';
import 'package:joga_junto/default/default_values.dart';
import 'package:joga_junto/src/main_screen/controller.dart';
import 'package:provider/provider.dart';
import 'package:joga_junto/objetos/notificacao.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Controller controller = Controller();
  @override
  Widget build(BuildContext context) {
    SingleNotifier appState = Provider.of<SingleNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Joinville Joga Junto"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: GestureDetector(
              child: const Icon(Icons.search),
              onTap: () {
                print('buscar');
              },
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: LayoutBuilder(builder: (contextB, box) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _ListLocais(
                    controller: controller,
                    box: box,
                    navigate: (int? id) {
                      if (id != null) {
                        Navigator.pushNamed(
                          context,
                          '/local',
                          arguments: <String, dynamic>{'id': id},
                        );
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: (box.maxWidth * 30) / 100,
                      child: menuInferiorButton(
                        'Minha Comunidade',
                        () {
                          // Navigator.pushNamed(context, '/comunidade');
                        },
                      ),
                    ),
                    Image.asset(
                      'assets/omniball.png',
                      width: (box.maxWidth * 18) / 100,
                    ),
                    SizedBox(
                      width: (box.maxWidth * 30) / 100,
                      child: menuInferiorButton(
                        'Esportes',
                        () {
                          print('aqui');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      drawer: LayoutBuilder(builder: (ctx, box) {
        return Drawer(
          width: (box.maxWidth * 65) / 100,
          child: menuLateral(context),
        );
      }),
    );
  }

  Widget menuLateral(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        children: [
          menuLateralButton(
            Icons.person_outline,
            'Perfil',
            () {
              // Navigator.pushNamed(context, '/perfil');
            },
          ),
          menuLateralButton(
            Icons.settings_outlined,
            'Configurações',
            () {
              // Navigator.pushNamed(context, '/config');
            },
          ),
          Expanded(
            child: menuLateralButton(
              Icons.logout_rounded,
              'Sair',
              () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget menuLateralButton(IconData icone, String txt, Function onClick) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Icon(
                icone,
                size: 40,
                color: txt == 'Sair' ? const Color(0XFFFF3B3B) : mainCor,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                txt,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: txt == 'Sair' ? const Color(0XFFFF3B3B) : mainCor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuInferiorButton(String txt, Function onClick) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Center(
        child: Text(
          txt,
          style: const TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _ListLocais extends StatefulWidget {
  const _ListLocais(
      {Key? key,
      required this.box,
      required this.navigate,
      required this.controller})
      : super(key: key);

  final Controller controller;
  final BoxConstraints box;
  final Function navigate;

  @override
  State<_ListLocais> createState() => _ListLocaisState();
}

class _ListLocaisState extends State<_ListLocais> {
  late Busca<List> locais;

  @override
  void initState() {
    super.initState();
    _initVars();
  }

  void _initVars() {
    locais = Busca(
        dados: [],
        requisicao: () async {
          return await widget.controller.getLocais();
        })
      ..addListener(_update)
      ..buscar();
  }

  void _update() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    locais.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0XFFF4F3F3),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: locais.dados.length,
        itemBuilder: (contextList, i) {
          Map local = {};
          if (i < locais.dados.length) {
            local = locais.dados[i];
          }
          return cardLocal(local, widget.box);
        },
      ),
    );
  }

  Widget cardLocal(Map local, BoxConstraints box) {
    int id = int.tryParse(local['id']?.toString() ?? '') ?? -1;
    String img = local['img']?.toString() ?? '-';
    String nome = local['nome']?.toString() ?? '-';
    String onde = local['onde']?.toString() ?? '-';
    List esportes = [];

    if (local['esportes_quadras'] is List) {
      esportes = local['esportes_quadras'];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 15,
      ),
      child: GestureDetector(
        onTap: () {
          widget.navigate(id);
        },
        child: SizedBox(
          height: 122,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Color(0XFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Color(0XFF000000),
                  spreadRadius: .33,
                  blurRadius: 2,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(22),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: mainCor, width: 5),
                        borderRadius: BorderRadius.circular(
                          100,
                        ),
                      ),
                      child: Image.asset(
                        'assets/warning.png', // img
                        width: (box.maxWidth * 15) / 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text(
                            nome,
                            style: const TextStyle(
                              fontSize: 28,
                              color: Color(0XFF595959),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: mainCor,
                            ),
                            Text(onde),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 9,
                            top: 6,
                          ),
                          child: Text(esportes.length.toString()),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (box.maxWidth * 30) / 100,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: localEsportes(esportes),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget localEsportes(List itens) {
    return ListView.builder(
      itemCount: min(2, (itens.length / 2).ceil()),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        String? item;
        String? itemProx;
        if (i * 2 % 2 == 0 && i * 2 < itens.length) {
          item = itens[i * 2];

          if ((i * 2 + 1) >= 3 && i * 2 + 1 < itens.length) {
            itemProx = '...';
          } else if (i * 2 + 1 < itens.length) {
            itemProx = itens[i * 2 + 1];
          }
        }

        return i * 2 % 2 > 0
            ? const Text("")
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (item != null) Icon(iconsMap[item]),
                  if (itemProx != null) Icon(iconsMap[itemProx]),
                ],
              );
      },
    );
  }
}
