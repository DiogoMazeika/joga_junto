import 'package:flutter/material.dart';
import 'package:joga_junto/core/busca.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
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
                  Navigator.pushNamed(context, '/');
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
            const Center(
              child: Text('Nome:'),
            ),
            Center(
              child: Text(userDados.dados['nome']?.toString() ?? '-'),
            ),
            const Center(
              child: Text('CPF:'),
            ),
            Center(
              child: Text(userDados.dados['cpf']?.toString() ?? '-'),
            ),
            const Center(
              child: Text('Telefone celular:'),
            ),
            Center(
              child: Text(userDados.dados['telefone']?.toString() ?? '-'),
            ),
            const Center(
              child: Text('E-mail:'),
            ),
            Center(
              child: Text(userDados.dados['email']?.toString() ?? '-'),
            ),
            const Center(
              child: Text('Senha:'),
            ),
            Center(
              child: Text(userDados.dados['senha']?.toString() ?? '-'),
            ),
          ],
        ),
      ),
    );
  }
}
