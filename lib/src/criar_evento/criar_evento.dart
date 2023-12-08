import 'package:joga_junto/core/busca.dart';
import 'package:joga_junto/default/default_values.dart';
import 'package:flutter/material.dart';

class CriarEvento extends StatefulWidget {
  const CriarEvento({super.key});

  @override
  State<CriarEvento> createState() => _CriarEventoState();
}

class _CriarEventoState extends State<CriarEvento> {
  late Busca<Map> quadraData;

  @override
  void initState() {
    super.initState();
    _initVars();
  }

  void _initVars() {
    quadraData = Busca(
        dados: {},
        requisicao: () async {
          return {
            'esportes': [
              {
                'label': 'Baseball',
                'icone': 'baseball',
              },
              {
                'label': 'Volei',
                'icone': 'volei',
              },
              {
                'label': 'Futebol',
                'icone': 'futebol',
              },
            ],
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
    quadraData.dispose();
  }

  String nome = "";
  int selectedEsporte = 0;
  String? erroNome;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int idLocal =
        int.tryParse(args['id_local']?.toString() ?? '-1') ?? -1;
    final String origem = args['origem']?.toString() ?? 'main';
    final int idQuadra =
        int.tryParse(args['id_quadra']?.toString() ?? '-1') ?? -1;

    final String dia = args['dia']?.toString() ?? "00:00";
    final String hora = args['hora']?.toString() ?? "00:00";

    List esportes = [];

    if (quadraData.dados['esportes'] is List) {
      esportes = quadraData.dados['esportes'];
    }

    return Scaffold(
      body: LayoutBuilder(builder: (contextBox, box) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 12,
            top: 67,
            right: 12,
            bottom: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/quadra',
                          arguments: <String, dynamic>{
                            'id': idQuadra,
                            'origem': 'local',
                            'id_origem': idLocal
                          },
                        );
                      },
                      child: const Icon(Icons.arrow_back_ios, color: mainCor),
                    ),
                  ),
                  const Expanded(
                    flex: 8,
                    child: Center(
                      child: Text(
                        'Criação de evento',
                        style: TextStyle(
                          color: Color(0XFF000000),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Expanded(child: Center()),
                ],
              ),
              /* const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Center(
                  child: Text("Escolha um ícone e cor para o evento"),
                ),
              ), */
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      hintText: 'De um nome para o seu evento',
                      errorText: erroNome,
                    ),
                    onChanged: (String vl) {
                      setState(() {
                        nome = vl;
                      });
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Center(
                  child: Text("Escolha um esporte"),
                ),
              ),
              SizedBox(
                height: 120,
                child: RotatedBox(
                  quarterTurns: -1,
                  child: ListWheelScrollView(
                    itemExtent: 80,
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        selectedEsporte = value;
                      });
                    },
                    children: [
                      for (int i = 0; i < esportes.length; i++)
                        _esporteOpt(esportes, i),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nome == "") {
                        setState(() {
                          erroNome = 'De um nome a seu evento';
                        });
                        return;
                      }
                      Navigator.pushNamed(context, '/$origem',
                          arguments: <String, dynamic>{'id': idQuadra});
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(((box.maxWidth * 65) / 100), 55),
                      ),
                    ),
                    child: const Text(
                      'Criar evento',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _esporteOpt(List esportes, int i) {
    Map esporte = {};
    if (i < esportes.length && esportes[i] is Map) {
      esporte = esportes[i];
    }
    return Padding(
      padding: const EdgeInsets.all(12),
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          children: [
            Icon(
              iconsMap[esporte['icone']],
              color: mainCor,
              size: 30,
            ),
            Text(esporte['label']?.toString() ?? '-'),
          ],
        ),
      ),
    );
  }
}
