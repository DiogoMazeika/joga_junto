import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:joga_junto/objetos/notificacao.dart';
import 'package:joga_junto/src/primeira_vez/primeira_vez.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map args = (ModalRoute.of(context)?.settings.arguments ?? {}) as Map;
    // SingleNotifier appState = Provider.of<SingleNotifier>(context);

    final int? id = int.tryParse(args['id']?.toString() ?? '');

    if (id != null) {
      // appState.login(id);
      return Center();
    }

    return const PrimeiraVez();
  }
}
