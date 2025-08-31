import 'package:flutter/material.dart';
import 'colors.dart';
class TalaaTheme {
  static ThemeData dark() {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.dark, scaffoldBackgroundColor: TalaaColors.black, colorSchemeSeed: TalaaColors.royalBlue);
    return base.copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: TalaaColors.black, foregroundColor: Colors.white, centerTitle: true, elevation: 0),
      cardTheme: CardTheme(color: TalaaColors.charcoal, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: TalaaColors.softGrey,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: TalaaColors.royalBlue, width: 1.2), borderRadius: BorderRadius.circular(16)),
        labelStyle: const TextStyle(color: Colors.white70)),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        backgroundColor: TalaaColors.royalBlue, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0)),
    );
  }
  static ThemeData light() {
    final base = ThemeData(useMaterial3: true, brightness: Brightness.light, scaffoldBackgroundColor: TalaaColors.lightBg, colorSchemeSeed: TalaaColors.royalBlue);
    return base.copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: TalaaColors.lightBg, foregroundColor: TalaaColors.lightText, centerTitle: true, elevation: 0),
      cardTheme: CardTheme(color: TalaaColors.lightCard, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: TalaaColors.lightInput,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: TalaaColors.royalBlue, width: 1.2), borderRadius: BorderRadius.circular(16)),
        labelStyle: const TextStyle(color: Colors.black54)),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
        backgroundColor: TalaaColors.royalBlue, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0)),
    );
  }
}
