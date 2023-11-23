import 'package:flutter/material.dart';
// import 'package:rpg_andriod/banco/comandos.dart';
// import 'package:rpg_andriod/objetos/item.dart';
// import 'package:rpg_andriod/objetos/load.dart';

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
        // color: Colors.red,
        // margin: EdgeInsets.all(100),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Mapa aqui!!'),
          ],
        ),
      ),
      drawer: LayoutBuilder(builder: (context2, box) {
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
              // print("aqui");
              Navigator.pushNamed(context, '/perfil');
            },
          ),
          menuLateralButton(
            Icons.settings_outlined,
            'Configurações',
            () {},
          ),
        ],
      ),
    );
  }
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
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              txt,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
