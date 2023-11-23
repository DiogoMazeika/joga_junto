import 'package:joga_junto/home.dart';
import 'package:flutter/material.dart';

class PlatformApp extends StatelessWidget {
  const PlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'D&D', home: Home());
  }
}
