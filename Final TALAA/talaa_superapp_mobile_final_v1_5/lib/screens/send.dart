import 'package:flutter/material.dart'; import '../api.dart'; import 'success.dart'; import 'package:talaa_ui_kit/talaa_ui_kit.dart';
class SendFlow extends StatefulWidget{ final Api api; final List wallets; const SendFlow({super.key, required this.api, required this.wallets}); @override State<SendFlow> createState()=>_SendFlowState(); }
class _SendFlowState extends State<SendFlow>{ int step=0; String? walletId; String currency='GHS'; final to=TextEditingController(text:'@friend'); final amt=TextEditingController(text:'10.00'); bool instant=true; String? status;
  @override void initState(){ super.initState(); if(widget.wallets.isNotEmpty){ walletId=widget.wallets.first['id']; currency=widget.wallets.first['currency']; } }
  @override Widget build(BuildContext context){ return Scaffold(appBar: AppBar(title: const Text('Send money')), body: SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Column(children:[ if(step==0) _step1(context) else _step2(context), if(status!=null) Padding(padding: const EdgeInsets.only(top:12), child: Text(status!, style: const TextStyle(fontWeight: FontWeight.bold))), ])))); }
  Widget _step1(BuildContext context){ return Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
    DropdownButtonFormField<String>(value: walletId, items: widget.wallets.map<DropdownMenuItem<String>>((w)=>DropdownMenuItem(value:w['id'], child: Text('${w['currency']} Wallet'))).toList(),
      onChanged:(v){ setState(()=>{ walletId=v, currency=widget.wallets.firstWhere((w)=>w['id']==v)['currency'] }); }, decoration: const InputDecoration(labelText:'From Wallet')),
    const SizedBox(height: 12), TextFormField(controller: to, decoration: const InputDecoration(labelText:'To (@handle or phone)')), const SizedBox(height: 12),
    TextFormField(controller: amt, decoration: const InputDecoration(labelText:'Amount'), keyboardType: TextInputType.number),
    const Spacer(), ElevatedButton(onPressed: ()=>setState(()=>step=1), child: const Text('Continue')) ])); }
  Widget _step2(BuildContext context){ final amount=amt.text.trim(); final recipient=to.text.trim(); return Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
    Text('Confirm', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 8),
    Card(child: ListTile(leading: const Icon(Icons.person), title: Text(recipient), subtitle: Text('Amount: $amount $currency'))),
    const SizedBox(height: 12), Text('Speed', style: Theme.of(context).textTheme.titleMedium),
    const SizedBox(height: 8), InstantToggle(instant: instant, onChanged: (v)=>setState(()=>instant=v)), const Spacer(),
    ElevatedButton(onPressed: _send, child: const Text('Send now')) ])); }
  Future<void> _send() async { if(walletId==null) return; setState(()=>status='Sending...');
    try{ await widget.api.transfer(walletId!, to.text.trim(), amt.text.trim(), currency, boost: instant);
      if(!mounted) return; Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=>SendSuccessScreen(amount: amt.text.trim(), currency: currency, recipient: to.text.trim())));
    } catch(e){ setState(()=>status='Error: $e'); } }
}
