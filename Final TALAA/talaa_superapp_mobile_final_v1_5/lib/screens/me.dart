import 'package:flutter/material.dart'; import '../api.dart'; import 'package:talaa_ui_kit/talaa_ui_kit.dart';
class MeScreen extends StatelessWidget{ final Api api; const MeScreen({super.key, required this.api});
  @override Widget build(BuildContext context){
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children:[
      Row(children:[ ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/talaa_logo.png', height: 32, width: 32, fit: BoxFit.cover)), const SizedBox(width:12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children:[ Text('Talaa', style: Theme.of(context).textTheme.titleMedium), const Text('@you', style: TextStyle(color: Colors.grey)) ]) ]),
      const SizedBox(height: 16),
      Card(child: ListTile(leading: const Icon(Icons.verified), title: const Text('VIP'), subtitle: const Text('Instant fees waived'),
        trailing: ElevatedButton(onPressed: () async { /* connect */ }, child: const Text('Activate')))),
      Card(child: ListTile(leading: const Icon(Icons.shield_moon), title: const Text('Guardian Protection'), subtitle: const Text('Smart risk checks are ON'))),
      Card(child: ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'), subtitle: const Text('PIN, biometrics, linked rails'))),
    ]));
  }
}
