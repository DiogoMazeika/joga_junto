import 'package:flutter/material.dart';

const Color mainCor = Color(0XFF435CA3);

Map<int, Color> mainCorSwatch = {
  50: mainCor.withOpacity(0.1),
  100: mainCor.withOpacity(0.2),
  200: mainCor.withOpacity(0.3),
  300: mainCor.withOpacity(0.4),
  400: mainCor.withOpacity(0.5),
  500: mainCor.withOpacity(0.6),
  600: mainCor.withOpacity(0.7),
  700: mainCor.withOpacity(0.8),
  800: mainCor.withOpacity(0.9),
  900: mainCor.withOpacity(1.0),
};

Map<String, IconData> iconsMap = {
  'baseball': Icons.sports_baseball_outlined,
  'basquete': Icons.sports_basketball_outlined,
  'futebol': Icons.sports_soccer_outlined,
  'tenis': Icons.sports_tennis_outlined,
  'volei': Icons.sports_volleyball_outlined,
  'tryhard': Icons.local_fire_department_rounded,
  '4fun': Icons.mood_rounded,
  'pago': Icons.payments,
  '...': Icons.more_horiz,
};
