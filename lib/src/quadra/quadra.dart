import 'package:flutter/material.dart';
import 'package:joga_junto/core/busca.dart';
import 'package:joga_junto/default/default_values.dart';
import 'package:joga_junto/src/quadra/controller.dart';

class Quadra extends StatefulWidget {
  const Quadra({super.key});

  @override
  State<Quadra> createState() => _QuadraState();
}

class _QuadraState extends State<Quadra> {
  final Controller controller = Controller();
  late int id;
  late Busca<Map> quadraData;

  Map? selectedDia;
  Map? selectedHora;
  List? horasDisp;

  @override
  void initState() {
    super.initState();
    _initVars();
  }

  void _initVars() {
    quadraData = Busca(
        dados: {},
        requisicao: () async {
          return await controller.getQuadra(id);
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

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    id = int.tryParse(args['id']?.toString() ?? '-1') ?? -1;
    final int idOrigem =
        int.tryParse(args['id_origem']?.toString() ?? '-1') ?? -1;
    final String origem = args['origem']?.toString() ?? 'main';

    String nome = quadraData.dados['nome']?.toString() ?? '-';
    String endereco =
        quadraData.dados['endereco']?.toString() ?? 'Não informado';
    String? valor = quadraData.dados['valor']?.toString();
    String equipamento = quadraData.dados['equipamento']?.toString() ?? '-';
    List esportes = [];
    List diasDisp = [];

    /* 'dias_disponiveis': [
              {
                'dia': '22/10/2023',
                'horarios': ['10:00', '11:00']
              },
            ], */

    if (quadraData.dados['esportes'] is List) {
      esportes = quadraData.dados['esportes'];
    }

    if (quadraData.dados['dias_disponiveis'] is List) {
      diasDisp = quadraData.dados['dias_disponiveis'];
    }

    return Scaffold(
      body: LayoutBuilder(builder: (context, box) {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/$origem',
                            arguments: <String, dynamic>{'id': idOrigem});
                      },
                      child: const Icon(Icons.arrow_back_ios, color: mainCor),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Center(
                      child: Text(
                        nome,
                        style: const TextStyle(
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Text(
                    'Endereço: $endereco',
                    style: const TextStyle(
                      color: mainCor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 80 * esportes.length / 2,
                child: _esportes(esportes),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Expanded(child: Center()),
                    const Text(
                      'Valor:',
                      style: TextStyle(
                        color: mainCor,
                      ),
                      // textAlign: TextAlign.end,
                    ),
                    const Expanded(child: Center()),
                    Text(
                      valor ?? 'Gratuito',
                      style: const TextStyle(
                        color: mainCor,
                      ),
                      // textAlign: TextAlign.start,
                    ),
                    const Expanded(child: Center()),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(child: Center()),
                  const Text(
                    'Equipamento:',
                    style: TextStyle(
                      color: mainCor,
                    ),
                    // textAlign: TextAlign.end,
                  ),
                  const Expanded(child: Center()),
                  Text(
                    equipamento,
                    style: const TextStyle(
                      color: mainCor,
                    ),
                    // textAlign: TextAlign.start,
                  ),
                  const Expanded(child: Center()),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Center(
                  child: Text('Dias Disponiveis'),
                ),
              ),
              Center(
                child: _SelectAgendamento(
                  opts: diasDisp,
                  valor: selectedDia,
                  onChange: (Map valor) {
                    setState(() {
                      selectedDia = valor;
                      horasDisp = valor['horarios'];
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: Text('Horários Disponiveis'),
                ),
              ),
              Center(
                child: _SelectAgendamento(
                  opts: horasDisp ?? [],
                  valor: selectedHora,
                  onChange: (Map valor) {
                    setState(() {
                      selectedHora = valor;
                    });
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedDia == null) {
                        _alertErro(context, 'dia');
                      } else if (selectedHora == null) {
                        _alertErro(context, 'horario');
                      } else {
                        Navigator.pushNamed(
                          context,
                          '/criarEvento',
                          arguments: <String, dynamic>{
                            'dia': selectedDia!['label'],
                            'hora': selectedHora!['label'],
                            'id_quadra': id,
                            'id_local': idOrigem,
                          },
                        );
                      }
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(((box.maxWidth * 65) / 100), 55),
                      ),
                    ),
                    child: const Text(
                      'Agendar',
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

  Widget _esportes(List itens) {
    return ListView.builder(
      itemCount: (itens.length / 2).ceil(),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) {
        String? item;
        String? itemProx;
        if (i * 2 % 2 == 0 && i * 2 < itens.length) {
          item = itens[i * 2]?.toString() ?? '...';

          if (i * 2 + 1 < itens.length) {
            itemProx = itens[i * 2 + 1]?.toString() ?? '...';
          }
        }

        return i * 2 % 2 > 0
            ? const Text("")
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (item != null)
                    Icon(
                      iconsMap[item],
                      color: mainCor,
                      size: 42,
                    ),
                  if (itemProx != null)
                    Icon(
                      iconsMap[itemProx],
                      color: mainCor,
                      size: 42,
                    ),
                ],
              );
      },
    );
  }

  void _alertErro(BuildContext context, String campo) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Insira o $campo para salvar'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _SelectAgendamento extends StatelessWidget {
  const _SelectAgendamento(
      {required this.opts, this.valor, required this.onChange});

  final List opts;
  final Map? valor;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: (valor ?? {})['label'],
      onChanged: (String? vl) {
        onChange(opts.firstWhere((ele) => ele['label'] == vl));
      },
      items: opts.map<DropdownMenuItem<String>>((vl) {
        return DropdownMenuItem(
          value: (vl ?? {})['label']?.toString() ?? '-',
          child: Text((vl ?? {})['label']?.toString() ?? '-'),
        );
      }).toList(),
    );
  }
}
