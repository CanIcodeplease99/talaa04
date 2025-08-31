import 'package:flutter/material.dart'; import 'package:talaa_ui_kit/talaa_ui_kit.dart'; import '../api.dart';
class InsightsScreen extends StatelessWidget{ final Api api; const InsightsScreen({super.key, required this.api});
  @override Widget build(BuildContext context){
    return SafeArea(child: ListView(padding: const EdgeInsets.all(16), children:[
      Text('Spending Insights', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      Row(children:[ Expanded(child: MetricTile(label:'This week', value:'₵ 420', icon: Icons.calendar_today)), const SizedBox(width: 12), Expanded(child: MetricTile(label:'This month', value:'₵ 2,150', icon: Icons.date_range)) ]),
      const SizedBox(height: 12),
      Card(child: ListTile(leading: const Icon(Icons.pie_chart_outline), title: const Text('Categories'), subtitle: const Text('Transport 28% • Food 24% • Bills 18% • Shopping 14% • Other 16%'))),
      Card(child: ListTile(leading: const Icon(Icons.trending_up), title: const Text('Trends'), subtitle: const Text('Down 7% vs last month'))),
      Card(child: ListTile(leading: const Icon(Icons.savings), title: const Text('Savings Suggestions'), subtitle: const Text('Switch to Standard on weekend transfers, auto-top-up airtime on discount days'))),
    ]));
  }
}
