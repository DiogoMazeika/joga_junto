import 'package:joga_junto/perfil/perfil.dart';
import 'package:joga_junto/home/home.dart';
import 'package:flutter/material.dart';

class Rotas {
  static Map<String, Widget Function(BuildContext)> rotas = {
    '/': (context) => const TelaInicio(),
    '/perfil': (context) => const Perfil(),
    // '/novo': (context) => const NovoJogo(),
    // '/continuar': (context) => const Continuar(),
    // '/jogo': (context) => const Jogo(),
    // '/jogo/persoMenu': (context) => const PersonagemMenu(),
    // '/jogo/batalha': (context) => const Battle(),
    // '/jogo/dungeon': (context) => const Dungeon(),
    // '/jogo/guild': (context) => const Guilda(),
    // 'jogo/itens': (context) => const Itens(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
  }
}
