import 'package:dio/dio.dart';
import 'package:joga_junto/abstract/abstract_controller.dart';

class Controller extends ControllerMain {
  Future<Map> getLocal(int id) async {
    Response dados = await get('local/local', data: {'id': id});

    if (dados.data is Map &&
        dados.data['status'] == '200' &&
        dados.data['data'] is Map) {
      return dados.data['data'];
    }

    return {
      'nome': 'Univille - Campus Joinville Bom Retiro',
      'eventos': [
        {
          'id': 1,
          'nome': 'eventasso',
          'horario': '10:15 - 14:00',
          'esportes': ['futebol', 'volei', 'basquete'],
          'confirmados': '100/100',
          'tipo': '4fun',
          'pago': 'true'
        }
      ],
      'quadras': [
        {
          'id': 1,
          'nome': 'Quadra 1',
          'horario': '14:15 - 23:59',
          'esportes': ['futebol', 'volei', 'basquete'],
          'pago': 'true'
        }
      ],
    };
  }
}
