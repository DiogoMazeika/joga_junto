import 'package:dio/dio.dart';

class ControllerMain {
  ControllerMain({this.sessao});

  final Dio _dio = Dio();

  final String? sessao;

  // Substitua 'https://api.example.com' pela URL da sua API
  final String api = 'http://34.42.197.66:8080';

  Future<Response> get(String url,
      {Map<String, dynamic>? data = const {}}) async {
    Response response = await _dio.get('$api/$url', queryParameters: data);

    return response;
  }

  Future<Response> post(String url,
      {Map<String, dynamic>? data = const {}}) async {
    _dio.options.headers['cookie'] = 'sessionId=$sessao';
    Response response = await _dio.post(
      '$api/api/$url',
      queryParameters: data,
      // options: Options(headers: {'Content-Type': 'application/json'})
    );

    return response;
  }

/*   Future<void> fetchData() async {
    try {
      // Exemplo de uma requisição GET
      Response response =
          await _dio.get('$api/api/monsters/adult-black-dragon/');

      // Aqui você pode manipular a resposta da API conforme necessário
      print(response.data);
    } catch (error) {
      // Trate erros aqui, se necessário
      print('Error: $error');
    }
  }

  Future<void> postData(Map<String, dynamic> data) async {
    try {
      // Exemplo de uma requisição POST
      Response response = await _dio.post('$api/endpoint', data: data);

      // Aqui você pode manipular a resposta da API conforme necessário
      print('Response data: ${response.data}');
    } catch (error) {
      // Trate erros aqui, se necessário
      print('Error: $error');
    }
  }
 */
  // Adicione mais métodos conforme necessário para outros tipos de requisições (PUT, DELETE, etc.)
}
