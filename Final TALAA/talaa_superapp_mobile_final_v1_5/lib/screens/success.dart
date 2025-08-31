import 'package:flutter/material.dart';
class SendSuccessScreen extends StatelessWidget{ final String amount; final String currency; final String recipient;
  const SendSuccessScreen({super.key, required this.amount, required this.currency, required this.recipient});
  @override Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[
      const Icon(Icons.check_circle, size: 96, color: Colors.greenAccent),
      const SizedBox(height: 12), Text('Sent $amount $currency', style: Theme.of(context).textTheme.headlineSmall),
      Text('to $recipient', style: Theme.of(context).textTheme.bodyMedium), const SizedBox(height: 24),
      ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: const Text('Done'))
    ])));
  }
}
