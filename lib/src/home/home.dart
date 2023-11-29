import 'dart:math';

import 'package:flutter/material.dart';
import 'package:joga_junto/core/busca.dart';
// import 'package:rpg_andriod/banco/comandos.dart';
// import 'package:rpg_andriod/objetos/item.dart';
// import 'package:rpg_andriod/objetos/load.dart';
import 'package:joga_junto/default/default_values.dart';

class TelaInicio extends StatelessWidget {
  const TelaInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* Comandos().buscaLoad().then((loads) {
      for (Load load in loads) {
        if (load.getId == 1) {
          // TO DO montar tela de continuar
          load = Load.setInstance(id: load.getId, nome: load.getNome);
          Comandos().buscaItensLoad().then((itens) {
            for (Item element in itens) {
              print(element.toMap());
            }
            return load.atualizaItens(itens);
          });
        }
      }
    }); */

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
        child: LayoutBuilder(builder: (context, box) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _ListLocais(box: box),
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
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          menuLateralButton(
            Icons.settings_outlined,
            'Configurações',
            () {
              Navigator.pushNamed(context, '/config');
            },
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
          children: [
            Expanded(
              child: Icon(
                icone,
                size: 40,
                color: mainCor,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                txt,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: mainCor,
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
        ),
      ),
    );
  }
}

class _ListLocais extends StatefulWidget {
  const _ListLocais({Key? key, required this.box}) : super(key: key);

  final BoxConstraints box;

  @override
  State<_ListLocais> createState() => _ListLocaisState();
}

class _ListLocaisState extends State<_ListLocais> {
  late Busca<Map> userDados;

  @override
  void initState() {
    super.initState();
    _initVars();
  }

  void _initVars() {
    userDados = Busca(
        dados: {},
        requisicao: () async {
          return {
            'nome': 'user',
            'cpf': '000.000.000-00',
            'telefone': '00 00000-0000',
            'email': 'jose@gmail.com',
            'senha': 'senha',
          };
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
    userDados.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0XFFF4F3F3),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (contextList, i) {
          return cardLocal(i, widget.box);
        },
      ),
    );
  }

  Widget cardLocal(int i, BoxConstraints box) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 15,
      ),
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
                      'assets/warning.png',
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
                          'Local n°$i',
                          style: const TextStyle(
                            fontSize: 28,
                            color: Color(0XFF595959),
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: mainCor,
                          ),
                          Text('Rua n sei'),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 9,
                          top: 6,
                        ),
                        child: Text('4 quadras'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: (box.maxWidth * 30) / 100,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: localEsportes(
                      [
                        Icons.sports_volleyball_outlined,
                        Icons.sports_baseball_outlined,
                        // sports_baseball_outlined
                        // sports_basketball_outlined
                        // sports_soccer_outlined
                        // sports_tennis_outlined
                        // sports_volleyball_outlined
                      ],
                    ),
                  ),
                )
              ],
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
        IconData? item;
        IconData? itemProx;
        if (i * 2 % 2 == 0 && i * 2 < itens.length) {
          item = itens[i * 2];

          if ((i * 2 + 1) >= 3 && i * 2 + 1 < itens.length) {
            itemProx = Icons.more_horiz;
          } else if (i * 2 + 1 < itens.length) {
            itemProx = itens[i * 2 + 1];
          }
        }
        return i * 2 % 2 > 0
            ? Text("")
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (item != null) Icon(item),
                  if (itemProx != null) Icon(itemProx),
                ],
              );
      },
    );
  }
}
