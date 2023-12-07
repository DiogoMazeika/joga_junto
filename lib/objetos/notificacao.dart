import 'package:flutter/material.dart';

class SingleNotifier extends ChangeNotifier {
  SingleNotifier();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  int? _currentId;
  int? get currentId => _currentId;

  void updateCountry(int? value) {
    if (value != _currentIndex) {
      _currentIndex = value!;
      notifyListeners();
    }
  }

  void login(int id) {
    if (id != _currentIndex) {
      _currentId = id;
      notifyListeners();
    }
  }
}
