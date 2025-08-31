import 'package:flutter/material.dart';
import '../services/api.dart';

class SendIntlScreen extends StatefulWidget{
  final String apiBase;
  const SendIntlScreen({super.key, required this.apiBase});
  @override State<SendIntlScreen> createState()=>_SendIntlScreenState();
}

class _SendIntlScreenState extends State<SendIntlScreen>{
  final controller = TextEditingController(text: '100'); // USD default
  bool loading=false;
  double? rate, fee, received;
  DateTime? lockExpiry;
  String? clientSecret;

  Future<void> quote() async{
    final amt = double.tryParse(controller.text.trim()) ?? 0;
    if(amt<=0) return;
    setState(()=>loading=true);
    try{
      final api = TalaaApi(widget.apiBase);
      final q = await api.fxQuote(source: 'USD', amount: amt);
      setState((){
        rate = (q['rate'] as num).toDouble();
        fee  = (q['fee']  as num).toDouble();
        received = (q['received'] as num).toDouble();
        lockExpiry = DateTime.tryParse(q['lock_expires_at'] ?? '') ?? DateTime.now().add(const Duration(seconds: 60));
      });
    } finally { if(mounted) setState(()=>loading=false); }
  }

  Future<void> send() async{
    if(rate==null || fee==null || received==null) return;
    final amt = double.tryParse(controller.text.trim()) ?? 0;
    final api = TalaaApi(widget.apiBase);
    final res = await api.sendInternational(source: 'USD', amount: amt, rate: rate!, fee: fee!);
    if(!mounted) return;
    setState(()=> clientSecret = res['client_secret']?.toString());
    showDialog(context: context, builder: (_)=> AlertDialog(
      title: const Text('Confirm payment'),
      content: Text(clientSecret!=null
        ? 'Complete card authorization via Stripe SDK using client_secret:\n${clientSecret}'
        : 'Transfer queued.'),
      actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('OK'))],
    ));
  }

  @override Widget build(BuildContext context){
    final locked = lockExpiry!=null && DateTime.now().isBefore(lockExpiry!);
    return Scaffold(
      appBar: AppBar(title: const Text('International transfer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          const Text('Amount (USD)', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height:8),
          TextField(controller: controller, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText:'100.00')),
          const SizedBox(height:12),
          Row(children:[
            ElevatedButton(onPressed: loading?null:quote, child: const Text('Get quote')),
            const SizedBox(width:12),
            if(locked) Text('Rate locked', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
          ]),
          const SizedBox(height:16),
          if(rate!=null) ...[
            Text('Rate: $rate   •   Fee: $fee'),
            const SizedBox(height:4),
            Text('Recipient gets ≈ GHS ${received?.toStringAsFixed(2)}'),
            const SizedBox(height:16),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: locked? send : null, child: const Text('Send now'))),
            if(clientSecret!=null) Padding(
              padding: const EdgeInsets.only(top:12),
              child: Text('Next step: use flutter_stripe to confirm PaymentIntent with client_secret.', style: const TextStyle(fontSize:12)),
            )
          ]
        ]),
      ),
    );
  }
}
