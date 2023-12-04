import 'package:flutter/material.dart';
import 'package:joga_junto/core/busca.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/main');
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
            const Center(
              child: Text('teste'),
            ),
          ],
        ),
      ),
    );
  }
}
