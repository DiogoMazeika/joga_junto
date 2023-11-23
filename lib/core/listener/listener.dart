import 'package:flutter/foundation.dart';
// import 'package:mobile_hsp/core/entity/notificacao.dart';

class ListenerCustom<T> {
  Map<String, Function> listeners = {};
  List<String> listenersExclu = [];

  void addListeners(String key, Function listeners) =>
      this.listeners[key] = (listeners);

  set addListenersExclu(String key) => listenersExclu.add(key);

  bool removeListener(String key) {
    return listeners.remove(key) != null;
  }

  bool removeListenerExclu(String key) {
    return listenersExclu.remove(key);
  }

  bool execucaoListener(String key, [T? value]) {
    if (listeners.containsKey(key)) {
      listeners[key]!();
      return true;
    }
    return false;
  }

  Function? getFuncListener(String key) {
    if (listeners.containsKey(key)) {
      return listeners[key];
    }
    return null;
  }

  void execucaoListeners([T? value]) {
    listeners.forEach((key, listener) {
      if (!listenersExclu.contains(key)) listener();
    });
  }

  void disponse() {
    listeners.clear();
  }
}

class Listener {
  List<Function> listeners = [];

  void addListeners(Function listener) => listeners.add(listener);

  bool removeListener(Function listener) {
    return listeners.remove(listener);
  }

  void execucaoListeners() {
    for (Function listener in listeners) {
      listener();
    }
  }

  void dispose() {
    listeners.clear();
  }
}

class ListenerNotifier<T> with ChangeNotifier, DiagnosticableTreeMixin {
  ListenerNotifier({required this.value, this.update}) {
    atualizarValor(value);
  }
  T value;
  Future<T> Function(T)? update;

  void atualizarValor(T value) async {
    this.value = value;
    this.value = (await update?.call(this.value) ?? value);
    notificar();
  }

  void notificar() {
    notifyListeners();
  }

  /// Makes `ListenerNotifier` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('listener', this));
  }
}

/* class ListenerNotification with ChangeNotifier, DiagnosticableTreeMixin {
  ListenerNotification({required this.value}) {
    // atualizarValor(value);
  }

  List<NotificacaoInfo> value;

  void atualizarValor(NotificacaoInfo value) async {
    this.value
      ..clear()
      ..add(value);
    notificar();
    Future.delayed(const Duration(
      seconds: 2,
      milliseconds: 500,
    )).then((v) => removeValor(value));
  }

  void removeValor(NotificacaoInfo value) async {
    if (this.value.remove(value)) notificar();
  }

  void notificar() {
    notifyListeners();
  }

  /// Makes `ListenerNotifier` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('listener', this));
  }
} */
