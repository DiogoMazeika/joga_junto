import 'package:dio/dio.dart';
import 'package:joga_junto/abstract/abstract_controller.dart';

class Controller extends ControllerMain {
  Future<List> getLocais() async {
    Response dados = await get('locais/locais');

    if (dados.data is Map &&
        dados.data['status'] == '200' &&
        dados.data['data'] is List) {
      return dados.data['data'];
    }

    return [
      {
        'id': 1,
        'img': 'img.png',
        'nome': 'nome teste',
        'onde': 'onde',
        'esportes_quadras': []
      },
    ];
  }
}
