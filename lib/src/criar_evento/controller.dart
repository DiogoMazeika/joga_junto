import 'package:dio/dio.dart';
import 'package:joga_junto/abstract/abstract_controller.dart';

class Controller extends ControllerMain {
  Future<Map> getQuadra(int id) async {
    Response dados = await get('quadra/quadra', data: {'id': id});

    if (dados.data is Map &&
        dados.data['status'] == '200' &&
        dados.data['data'] is Map) {
      return dados.data['data'];
    }

    return {
      'esportes': [
        {
          'label': 'Baseball',
          'icone': 'baseball',
        },
        {
          'label': 'Volei',
          'icone': 'volei',
        },
        {
          'label': 'Futebol',
          'icone': 'futebol',
        },
      ],
    };
  }

  Future<bool> criarEvento(
    String nome,
    String selectedEsporte,
    String dia,
    String hora,
    int idLocal,
    int idQuadra,
  ) async {
    try {
      await post('quadra/quadra', data: {
        'nome': nome,
        'selected_esporte': selectedEsporte,
        'dia': dia,
        'hora': hora,
        'id_local': idLocal,
        'id_quadra': idQuadra,
      });

      return true;
    } catch (error) {
      return false;
    }
  }
}
