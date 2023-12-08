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
          'tel': tel,
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
      data: {'email': email, 'senha': senha},
    );

    if (dados.data is Map &&
        dados.data['status'] == '200' &&
        dados.data['data'] is Map) {
      return dados.data['data'];
    }

    return {'ok': false};
  }
}
