import 'package:flutter/material.dart';
import 'api.dart'; import 'screens/home.dart'; import 'package:talaa_ui_kit/talaa_ui_kit.dart';
void main()=>runApp(const TalaaApp());
class TalaaApp extends StatelessWidget{ const TalaaApp({super.key});
  @override Widget build(BuildContext context){
    final api = Api('http://localhost:8080');
    return MaterialApp(title:'Talaa', theme: TalaaTheme.light(), darkTheme: TalaaTheme.dark(), themeMode: ThemeMode.system, home: HomeRoot(api: api));
  }
}
