import 'package:flutter/material.dart'; import '../tokens/colors.dart';
class QuickActionTile extends StatelessWidget{ final IconData icon; final String label; final VoidCallback onTap; const QuickActionTile({super.key, required this.icon, required this.label, required this.onTap});
  @override Widget build(BuildContext context){ return InkWell(onTap:onTap, borderRadius: BorderRadius.circular(16), child: Container(height:56, decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black12)), child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children:[ Icon(icon, color: const Color(0xFF2B5BFF)), const SizedBox(width:8), Text(label) ]))); }
}
