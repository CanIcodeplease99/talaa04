import 'package:flutter/material.dart';
class MetricTile extends StatelessWidget{ final String label; final String value; final IconData icon; const MetricTile({super.key, required this.label, required this.value, required this.icon});
  @override Widget build(BuildContext context){ return Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black12)),
    child: Row(children:[ Icon(icon, color: const Color(0xFF2B5BFF)), const SizedBox(width:12), Column(crossAxisAlignment: CrossAxisAlignment.start, children:[ Text(label, style: Theme.of(context).textTheme.labelMedium), Text(value, style: Theme.of(context).textTheme.titleLarge) ]) ]));
  }
}
