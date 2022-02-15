import 'package:flutter/material.dart';
import 'package:khata/themes/light_theme.dart';

class AppColors {
  // static const primary = Color(0xFFF34647);
  // static const secondary = Color(0xFFB5BFD0);
  static const primary = Color(0xFFFFC520);
  static const secondary = Color(0xFFFE7240);
  static const text = Color(0xFF272D2F);
  static const textLight = Color(0xFF6A727D);
  static const black = Color(0xFF272D2F);
  static const white = Color(0xFFFFFFFF);
  static const lightGray = Color(0xFFD7D7D7);
  static const darkGray = Color(0xFF939DA0);
  static const background = Color(0xFFF5F5F5);
  static const backgroundLight = Color(0xFFF9F9F9);
  static const transparent = Color(0x00000000);
  static const green = Color(0xFF00A651);
  static const red = Color(0xFFF34647);
  static const errorRed = Color.fromARGB(255, 197, 15, 48);
  static const blue = Color(0xFF4169e1);
  static const orange = Color(0xFFE65100);
  static const yellow = Color(0xFFFFCA28);
}

// Ref: Font Weights: https://api.flutter.dev/flutter/dart-ui/FontWeight-class.html
// Ref: Font Weights for TextTheme: https://api.flutter.dev/flutter/material/TextTheme-class.html
class AppTheme {
  static final lightTheme = LightAppTheme.themeData;
}
