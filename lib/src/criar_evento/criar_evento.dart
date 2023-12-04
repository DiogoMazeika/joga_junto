import 'package:flutter/material.dart';

class CriarEvento extends StatelessWidget {
  const CriarEvento({super.key});

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

    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 12,
          top: 67,
          right: 12,
          bottom: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Criação de evento"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Center(
                child: Text("Escolha um ícone e cor para o evento"),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'De um nome para o seu evento',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Center(
                child: Text("Escolha um esporte"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
