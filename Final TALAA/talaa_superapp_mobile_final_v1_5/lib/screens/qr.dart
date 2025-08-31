import 'package:flutter/material.dart'; import 'package:mobile_scanner/mobile_scanner.dart'; import '../api.dart';
class QrPayScreen extends StatefulWidget{ final Api api; final List wallets; const QrPayScreen({super.key, required this.api, required this.wallets}); @override State<QrPayScreen> createState()=>_QrState(); }
class _QrState extends State<QrPayScreen>{ String? walletId; String currency='GHS'; String status='';
  @override void initState(){ super.initState(); if(widget.wallets.isNotEmpty){ walletId=widget.wallets.first['id']; currency=widget.wallets.first['currency']; } }
  Future<void> _handle(String text) async{ Uri? u; try{ u=Uri.parse(text);}catch(_){}
    if(u==null || u.scheme!='talaa'){ setState(()=>status='Invalid QR'); return; }
    final q=u.queryParameters; final to=q['to']??'@friend'; final amt=q['amount']??'0.00'; final cur=q['currency']??currency; final boost=(q['boost']??'false')=='true';
    setState(()=>status='Sending to $to ...'); try{ await widget.api.transfer(walletId!, to, amt, cur, boost:boost); setState(()=>status='Sent ✅'); } catch(e){ setState(()=>status='Error: $e'); } }
  @override Widget build(BuildContext context){ return Scaffold(appBar: AppBar(title: const Text('Scan to Pay')), body: Column(children:[
    Expanded(child: MobileScanner(onDetect:(cap){ final b=cap.barcodes; if(b.isNotEmpty){ _handle(b.first.rawValue??''); } })),
    Padding(padding: const EdgeInsets.all(12), child: Text(status, style: const TextStyle(fontWeight: FontWeight.bold))) ])); }
}
