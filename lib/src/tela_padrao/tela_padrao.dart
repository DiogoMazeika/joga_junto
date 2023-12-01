import 'package:flutter/material.dart';

class TelaPadrao extends StatefulWidget {
  const TelaPadrao({Key? key}) : super(key: key);

  @override
  State<TelaPadrao> createState() => _TelaPadraoState();
}

class _TelaPadraoState extends State<TelaPadrao> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('aqui'),
      ],
    );
  }
}
