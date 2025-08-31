import 'package:flutter/material.dart';
import 'send.dart';
import 'send_intl.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});
  @override Widget build(BuildContext context){
    final apiBase = const String.fromEnvironment('API_BASE', defaultValue: 'http://localhost:3000');
    return Scaffold(
      appBar: AppBar(title: const Text('Talaa')),
      body: ListView(padding: const EdgeInsets.all(16), children:[
        const Text('Welcome back 👋', style: TextStyle(fontSize:22, fontWeight: FontWeight.bold)),
        const SizedBox(height:12),
        Card(child: ListTile(
          title: const Text('Send money'),
          subtitle: const Text('Instant feel • secure'),
          trailing: ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> SendScreen(apiBase: apiBase)));
          }, child: const Text('Open')),
        )),
        const SizedBox(height:12),
        Card(child: ListTile(
          title: const Text('International'),
          subtitle: const Text('USD/GBP → GHS with locked quote'),
          trailing: OutlinedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=> SendIntlScreen(apiBase: apiBase)));
          }, child: const Text('Open')),
        )),
      ]),
    );
  }
}
