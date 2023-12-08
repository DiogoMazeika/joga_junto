import 'package:dio/dio.dart';
import 'package:joga_junto/abstract/abstract_controller.dart';

class Controller extends ControllerMain {
  Future<Map> getQuadra(int id) async {
    Response dados = await get('quadras/quadra', data: {'id': id});

    if (dados.data is Map &&
        dados.data['status'] == '200' &&
        dados.data['data'] is Map) {
      return dados.data['data'];
    }

    return {
      'nome': 'Quadra 1',
      'endereco': 'Rua Itaiopolis N° 903',
      'valor': 'Gratuito',
      'equipamento': 'equipamento',
      'esportes': [
        'baseball',
        'volei',
      ],
      'dias_disponiveis': [
        {
          'label': '22/10/2023',
          'horarios': [
            {'label': '10:00'},
            {'label': '11:00'},
            {'label': '12:00'},
            {'label': '13:00'},
            {'label': '14:00'},
          ]
        },
      ],
    };
  }
}
