import 'package:joga_junto/src/criar_evento/criar_evento.dart';
import 'package:joga_junto/src/evento/evento.dart';
import 'package:joga_junto/src/home/home.dart';
import 'package:joga_junto/src/login/login.dart';
import 'package:joga_junto/src/login/nova_conta.dart';
import 'package:joga_junto/src/perfil/perfil.dart';
import 'package:joga_junto/src/config/config.dart';
import 'package:joga_junto/src/local/local.dart';
import 'package:joga_junto/src/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:joga_junto/src/quadra/quadra.dart';
import 'package:joga_junto/src/tela_padrao/tela_padrao.dart';

class Rotas {
  static Map<String, Widget Function(BuildContext)> rotas = {
    '/': (context) => const Home(),
    '/main': (context) => const MainScreen(),
    '/perfil': (context) => const Perfil(),
    '/config': (context) => const Config(),
    '/local': (context) => const Local(),
    '/evento': (context) => const Evento(),
    '/quadra': (context) => const Quadra(),
    '/criarEvento': (context) => const CriarEvento(),
    '/telaPadrao': (context) => const TelaPadrao(isPageView: false),
    '/login': (context) => const Login(),
    '/login/novaConta': (context) => const NovaConta(),
    // '/comunidade': (context) => const Comunidade:(),
    // 'jogo/itens': (context) => const Itens(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
  }
}
