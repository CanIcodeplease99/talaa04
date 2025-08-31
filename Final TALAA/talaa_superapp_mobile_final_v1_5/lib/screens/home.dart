import 'package:flutter/material.dart';
import '../api.dart'; import 'send.dart'; import 'qr.dart'; import 'split.dart'; import 'assistant.dart'; import 'discover.dart'; import 'me.dart'; import 'insights.dart'; import 'chat.dart';
import 'package:talaa_ui_kit/talaa_ui_kit.dart';

class HomeRoot extends StatefulWidget{ final Api api; const HomeRoot({super.key, required this.api}); @override State<HomeRoot> createState()=>_HomeRootState(); }
class _HomeRootState extends State<HomeRoot>{ int idx=0; List wallets=[]; bool loading=true;
  @override void initState(){ super.initState(); _load(); }
  Future<void> _load() async{ try{ final w=await widget.api.wallets(); setState(()=>{wallets=w,loading=false}); }catch(_){ setState(()=>loading=false);} }
  @override Widget build(BuildContext context){
    final pages=[ _Home(api:widget.api,wallets:wallets,loading:loading,reload:_load), _Pay(api:widget.api,wallets:wallets), AssistantScreen(api:widget.api), DiscoverScreen(api: widget.api), InsightsScreen(api: widget.api), MeScreen(api:widget.api) ];
    return Scaffold(
      appBar: const BrandAppBar(title:'Talaa'),
      body: pages[idx],
      bottomNavigationBar: NavigationBar(height:70, selectedIndex: idx, onDestinationSelected:(i)=>setState(()=>idx=i), destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label:'Home'),
        NavigationDestination(icon: Icon(Icons.qr_code_scanner), selectedIcon: Icon(Icons.qr_code), label:'Pay'),
        NavigationDestination(icon: Icon(Icons.smart_toy_outlined), selectedIcon: Icon(Icons.smart_toy), label:'Assistant'),
        NavigationDestination(icon: Icon(Icons.grid_view_outlined), selectedIcon: Icon(Icons.grid_view), label:'Discover'),
        NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights), label:'Insights'),
        NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label:'Me'),
      ]),
      floatingActionButton: FloatingActionButton.extended(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>ChatScreen(api: widget.api))), icon: const Icon(Icons.chat_bubble_outline), label: const Text('Chats')),
    ); } }

class _Home extends StatelessWidget{ final Api api; final List wallets; final bool loading; final Future<void> Function() reload;
  const _Home({required this.api, required this.wallets, required this.loading, required this.reload});
  @override Widget build(BuildContext context){
    final currency = wallets.isEmpty? 'GHS' : wallets.first['currency'];
    final balance = wallets.isEmpty? '0.00' : ((wallets.first['balance']/100).toStringAsFixed(2));
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children:[
      AnimatedBalanceCard(title:'Available balance', amount: balance, currency: currency),
      const SizedBox(height: 16),
      PulseButton(label:'Send', icon: Icons.send, onTap: () async { await Navigator.push(context, MaterialPageRoute(builder:(_)=>SendFlow(api: api, wallets: wallets))); await reload(); }),
      const SizedBox(height: 12),
      Row(children:[
        Expanded(child: QuickActionTile(icon: Icons.request_page, label: 'Request', onTap: ()=>ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Request flow coming soon'))))),
        const SizedBox(width: 8),
        Expanded(child: QuickActionTile(icon: Icons.groups, label: 'Split Bill', onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>SplitScreen(api: api, wallets: wallets))))),
        const SizedBox(width: 8),
        Expanded(child: QuickActionTile(icon: Icons.qr_code_scanner, label: 'QR Pay', onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>QrPayScreen(api: api, wallets: wallets))))),
      ]),
      const SizedBox(height: 16),
      Card(child: ListTile(leading: const Icon(Icons.shield), title: const Text('Smart Risk Rails'), subtitle: const Text('Auto-switches to healthy rails if a network is degraded'))),
    ]));
  }
}

class _Pay extends StatelessWidget{ final Api api; final List wallets; const _Pay({required this.api, required this.wallets});
  @override Widget build(BuildContext context){
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children:[
      Text('Pay', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      Card(child: ListTile(leading: const Icon(Icons.qr_code_scanner), title: const Text('Scan to pay'), onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>QrPayScreen(api: api, wallets: wallets))))),
      Card(child: ListTile(leading: const Icon(Icons.groups), title: const Text('Bill split'), onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>SplitScreen(api: api, wallets: wallets))))),
    ]));
  }
}
