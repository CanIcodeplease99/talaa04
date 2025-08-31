import 'package:flutter/material.dart'; import 'package:talaa_ui_kit/talaa_ui_kit.dart'; import '../api.dart';
class DiscoverScreen extends StatelessWidget{ final Api api; DiscoverScreen({super.key, required this.api}); final tiles=const[ _Tile(Icons.phone_iphone,'Airtime & Data'), _Tile(Icons.receipt_long,'Pay Bills'), _Tile(Icons.storefront,'Merchants'), _Tile(Icons.event,'Events & Tickets'), _Tile(Icons.loyalty,'Rewards'), _Tile(Icons.savings,'Savings (soon)') ];
  @override Widget build(BuildContext context){
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children:[ Text('Discover', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 12),
      GridView.count(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), children: tiles.map((t)=>_DiscoverCard(tile:t)).toList()) ]));
  }
}
class _DiscoverCard extends StatelessWidget{ final _Tile tile; const _DiscoverCard({required this.tile});
  @override Widget build(BuildContext context){
    return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Theme.of(context).cardColor, border: Border.all(color: Colors.black12)),
      child: InkWell(borderRadius: BorderRadius.circular(16), onTap: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${tile.label} coming soon'))); },
        child: Center(child: Column(mainAxisSize: MainAxisSize.min, children:[ Icon(tile.icon, color: const Color(0xFF2B5BFF), size: 28), const SizedBox(height:6), Text(tile.label, textAlign: TextAlign.center) ]))));
  }
}
class _Tile{ final IconData icon; final String label; const _Tile(this.icon,this.label); }
