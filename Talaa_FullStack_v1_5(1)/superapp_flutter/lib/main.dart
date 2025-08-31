import 'package:flutter/material.dart';
import 'screens/home.dart';
void main(){ runApp(const TalaaApp()); }
class TalaaApp extends StatelessWidget{
  const TalaaApp({super.key});
  @override Widget build(BuildContext c){
    final theme=ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2B5BFF), brightness: Brightness.light), useMaterial3:true);
    final dark=ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2B5BFF), brightness: Brightness.dark), useMaterial3:true);
    return MaterialApp(title:'Talaa', theme: theme, darkTheme: dark, home: const HomeScreen());
  }
}
