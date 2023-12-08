import 'package:dio/dio.dart';
import 'package:joga_junto/abstract/abstract_controller.dart';

class Controller extends ControllerMain {
  Future<Map> getEvento(int id) async {
    Response dados = await get('evento/evento', data: {'id': id});

    if (dados.data is Map &&
        dados.data['status'] == '200' &&
        dados.data['data'] is Map) {
      return dados.data['data'];
    }

    return {
      'nome': 'Quadra 1',
      'endereco': 'Rua Blumenau',
      'valor': 'Gratuito',
      'equipamento': 'equipamento',
      'esportes': ['futebol'],
      'dias_disponiveis': [
        {
          'label': '22/10/2023',
          'horarios': [
            {'label': '10:00'},
            {'label': '11:00'},
          ]
        },
      ],
    };
  }

  Future<bool> entrarEvento(int id) async {
    try {
      await post('quadra/quadra', data: {'id': id});

      return true;
    } catch (error) {
      return false;
    }
  }
}
