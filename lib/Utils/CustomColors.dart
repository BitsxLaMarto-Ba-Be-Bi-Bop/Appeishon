import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CustomColors {
  static const Color primary = Color(0xFF005d6c);
  static const Color textPrimary = Color(0xFFFFFFFF);
}

extension ColorExtension on Color {
  Color makeObcure() {
    final hsl = HSLColor.fromColor(this);
    final colorOscuro =
        hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));
    return colorOscuro.toColor();
  }
}
