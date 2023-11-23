import 'package:joga_junto/core/listener/listener.dart';

class Busca<T> {
  Busca({
    required this.dados,
    required this.requisicao,
  });
  T dados;
  bool _on = true;
  bool _load = false;
  bool busca = false;
  bool erro = false;
  int erros = 0;
  Info info = Info.ok;

  Future<T> Function() requisicao;
  final Listener _listener = Listener();

  bool get load => _load;
  set load(bool load) {
    _load = load;
    if (!load && _on) _listener.execucaoListeners();
  }

  bool get on => _on;

  void addListener(Function func) {
    _listener.addListeners(func);
  }

  bool removeListener(Function func) {
    return _listener.removeListener(func);
  }

  Future<void> buscar() {
    busca = false;
    return onBusca();
  }

  Future<void> onBusca() async {
    if (!busca) {
      busca = true;
      load = true;
      dados = await requisicao();
      load = false;
    }
  }

  void init() {
    _on = true;
    busca = false;
  }

  void dispose() {
    _listener.dispose();
    _on = false;
  }
}

enum Info {
  ok,
  erro,
  consulta,
  parametro,
  permissao,
}
