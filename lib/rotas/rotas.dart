import 'package:joga_junto/src/perfil/perfil.dart';
import 'package:joga_junto/src/config/config.dart';
import 'package:joga_junto/src/home/home.dart';
import 'package:flutter/material.dart';

class Rotas {
  static Map<String, Widget Function(BuildContext)> rotas = {
    '/': (context) => const TelaInicio(),
    '/perfil': (context) => const Perfil(),
    '/config': (context) => const Config(),
    // '/comunidade': (context) => const Comunidade:(),
    // 'jogo/itens': (context) => const Itens(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
  }
}
