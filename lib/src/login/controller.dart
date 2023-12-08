import 'package:dio/dio.dart';
import 'package:joga_junto/abstract/abstract_controller.dart';

class Controller extends ControllerMain {
  Future<bool> criarConta(
    String nome,
    String cpf,
    String dataNasc,
    String tel,
    String email,
    String senha,
  ) async {
    try {
      await post(
        'login/criarConta',
        data: {
          'nome': nome,
          'cpf': cpf,
          'dataNasc': dataNasc,
          'telefone': tel,
          'email': email,
          'senha': senha,
        },
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<Map> entrar(
    String email,
    String senha,
  ) async {
    Response dados = await post(
      'login/entrar',
      data: {'l': email, 's': senha},
    );

    if (dados.data is Map) {
      return dados.data;
    }

    return {'ok': false};
  }
}
