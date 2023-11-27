import 'package:flutter/material.dart';
import 'package:joga_junto/objetos/notificacao.dart';
import 'package:provider/provider.dart';
import 'package:joga_junto/rotas/rotas.dart';
import 'package:joga_junto/default/default_values.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SingleNotifier>(
        create: (_) => SingleNotifier(),
      )
    ],
    child: MaterialApp(
      title: 'JJJ 0.0.1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(mainCor.value, mainCorSwatch),
      ),
      initialRoute: '/',
      routes: Rotas.rotas,
      onGenerateRoute: Rotas.onGenerateRoute,
    ),
  ));
}
