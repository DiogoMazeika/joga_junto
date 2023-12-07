import 'package:flutter/material.dart';
import 'package:joga_junto/core/busca.dart';
import 'package:joga_junto/default/default_values.dart';

class Local extends StatefulWidget {
  const Local({super.key});

  @override
  State<Local> createState() => _LocalState();
}

class _LocalState extends State<Local> {
  late Busca<Map> localData;
  late Busca<List> esportes;
  late Busca<List> filtros;

  int aba = 0;
  List<String> selectEsportes = [];
  List<String> selectFiltros = [];

  @override
  void initState() {
    super.initState();
    _initVars();
  }

  void _initVars() {
    localData = Busca(
        dados: {},
        requisicao: () async {
          return {
            'nome': 'Univille - Campus Joinville Bom Retiro',
            'eventos': [
              {
                'id': 1,
                'nome': 'aa',
                'horario': '10:15 - 14:00',
                'esportes': ['futebol', 'volei', 'basquete'],
                'confirmados': '100/100',
                'tipo': '4fun',
                'pago': 'true'
              }
            ],
            'quadras': [
              {
                'id': 1,
                'nome': 'aa',
                'horario': '14:15 - 23:59',
                'esportes': ['futebol', 'volei', 'basquete'],
                'pago': 'true'
              }
            ],
          };
        })
      ..addListener(_update)
      ..buscar();
    esportes = Busca(
        dados: [],
        requisicao: () async {
          return ['baseball', 'basquete', 'futebol', 'tenis', 'volei'];
        })
      ..addListener(_update)
      ..buscar();
    filtros = Busca(
        dados: [],
        requisicao: () async {
          return ['tryhard', '4fun', 'pago'];
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
    localData.dispose();
    esportes.dispose();
    filtros.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int id = int.tryParse(args['id']?.toString() ?? '-1') ?? -1;

    String nome = localData.dados['nome']?.toString() ?? '-';
    List eventos = [];
    List quadras = [];

    if (localData.dados['eventos'] is List) {
      eventos = localData.dados['eventos'];
    }
    if (localData.dados['quadras'] is List) {
      quadras = localData.dados['quadras'];
    }

    List esportesOpts = esportes.dados;
    List filtrosOpts = filtros.dados;

    return Scaffold(
      body: LayoutBuilder(builder: (context, box) {
        return ColoredBox(
          color: const Color(0XFFF4F3F3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColoredBox(
                color: mainCor,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    top: 67,
                    right: 12,
                    bottom: 12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/main');
                          },
                          child: const Icon(Icons.arrow_back_ios,
                              color: Color(0XFFFFFFFF)),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Center(
                          child: Text(
                            '$nome $id',
                            style: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Expanded(child: Center()),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _btnAba(box, 'Eventos', () {
                      setState(() {
                        aba = 0;
                      });
                    }, aba == 0),
                    _btnAba(
                      box,
                      'Quadras Disponiveis',
                      () {
                        setState(() {
                          aba = 1;
                        });
                      },
                      aba == 1,
                    ),
                  ],
                ),
              ),
              _btnList('Esportes', esportesOpts, selectEsportes, (String? opt) {
                setState(() {
                  if (selectEsportes.contains(opt)) {
                    selectEsportes.remove(opt);
                  } else if (opt != null) {
                    selectEsportes.add(opt);
                  }
                });
              }),
              _btnList('Filtros', filtrosOpts, selectFiltros, (String? opt) {
                setState(() {
                  if (selectFiltros.contains(opt)) {
                    selectFiltros.remove(opt);
                  } else if (opt != null) {
                    if (opt != 'pago') {
                      selectFiltros.removeWhere((item) => item != 'pago');
                    }
                    selectFiltros.add(opt);
                  }
                });
              }),
              Expanded(
                child: _ListQuadras(
                    quadrasAll: aba == 0 ? eventos : quadras,
                    openQuadra: (String sId) {
                      int? idQuadra = int.tryParse(sId);
                      if (idQuadra != null) {
                        Navigator.pushNamed(
                          context,
                          aba == 0 ? '/evento' : '/quadra',
                          arguments: <String, dynamic>{
                            'id': idQuadra,
                            'origem': 'local',
                            'id_origem': id
                          },
                        );
                      }
                    },
                    esportes: selectEsportes,
                    filtros: selectFiltros),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _btnAba(BoxConstraints box, String txt, Function onTap, bool ativo) {
    return ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          Size(
            ((box.maxWidth * 48) / 100) - 5,
            55,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          ativo ? mainCor : mainCor.withOpacity(0.25),
        ),
      ),
      child: Text(
        txt,
        style: TextStyle(
          color: ativo ? const Color(0XFFFFFFFF) : const Color(0XFF000000),
        ),
      ),
    );
  }

  Widget _btnList(
      String ttl, List opts, List<String> selected, Function iconAtion) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 69,
            child: Text('$ttl:'),
          ),
          for (int i = 0; i < opts.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: GestureDetector(
                onTap: () {
                  iconAtion(opts[i]);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: selected.contains(opts[i])
                        ? mainCor
                        : const Color(0XFFFFFFFF),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: const Color(0XFF0000000),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: Icon(
                      opts[i] is String ? iconsMap[opts[i]] : iconsMap['...'],
                      color: selected.contains(opts[i])
                          ? const Color(0XFFFFFFFF)
                          : const Color(0XFF000000),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ListQuadras extends StatelessWidget {
  const _ListQuadras(
      {required this.quadrasAll,
      required this.esportes,
      required this.filtros,
      required this.openQuadra});

  final List quadrasAll;
  final Function openQuadra;
  final List<String> esportes;
  final List<String> filtros;

  @override
  Widget build(BuildContext context) {
    List quadras = [...quadrasAll];

    print("filtros");
    print(filtros);
    print('----');

    if (esportes.isNotEmpty) {
      quadras.removeWhere((q) {
        return !(q['esportes'] is List &&
            q['esportes'].every((item) => esportes.contains(item)));
      });
    }

    if (filtros.isNotEmpty) {
      quadras.removeWhere((q) {
        if (filtros.contains('pago') && '${q['pago']}' != 'true') return true;
        // if (!filtros.contains('pago') && '${q['pago']}' == 'true') return true;
        if (filtros.contains('4fun') && q['tipo'] != '4fun') return true;
        if (filtros.contains('tryhard') && q['tipo'] != 'tryhard') return true;

        return false;
      });
    }

    print("quadrasAll");
    print(quadrasAll);

    return ListView.builder(
      itemCount: quadras.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        Map item = {};
        if (i < quadras.length && quadras[i] is Map) {
          item = quadras[i];
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          child: GestureDetector(
            onTap: () {
              openQuadra(item['id']?.toString() ?? '');
            },
            child: SizedBox(
              height: 90,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: mainCor,
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(11),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            item['nome']?.toString() ?? '-',
                            style: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                            ),
                          ),
                          const Expanded(
                            child: Center(),
                          ),
                          Text(
                            item['horario']?.toString() ?? '-',
                            style: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          for (int j = 0; j < 3; j++)
                            _quadraEsportes(
                              j,
                              item['esportes'] is List ? item['esportes'] : [],
                            ),
                          Expanded(
                            child: Center(
                              child: item['confirmados'] is String
                                  ? Text('${item['confirmados']} confirmados',
                                      style: const TextStyle(
                                        color: Color(0XFFFFFFFF),
                                        fontSize: 18,
                                      ))
                                  : null,
                            ),
                          ),
                          const Icon(null),
                          if ('${item['pago']}' != 'true') const Icon(null),
                          Icon(
                            iconsMap[item['tipo']],
                            color: const Color(0XFFFFFFFF),
                            size: 25,
                          ),
                          if ('${item['pago']}' == 'true')
                            Icon(
                              iconsMap['pago'],
                              color: const Color(0XFFFFFFFF),
                              size: 25,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _quadraEsportes(int i, List esportes) {
    if (i >= esportes.length) return const Icon(null);
    return Icon(
      iconsMap[i == 2 && esportes.length > 3 ? '...' : esportes[i]],
      color: const Color(0XFFFFFFFF),
      size: 25,
    );
  }
}
