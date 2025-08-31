import 'package:flutter/material.dart'; import '../api.dart';
class AssistantScreen extends StatefulWidget{ final Api api; const AssistantScreen({super.key, required this.api}); @override State<AssistantScreen> createState()=>_AsstState(); }
class _AsstState extends State<AssistantScreen>{ final prompt=TextEditingController(text:'Find coffee near me with promos this week'); String? reply; bool loading=false; List merchants=[];
  @override Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: const Text('Assistant')),
      body: Padding(padding: const EdgeInsets.all(16), child: ListView(children:[
        Row(children:[ ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/talaa_logo.png', height: 32, width: 32, fit: BoxFit.cover)), const SizedBox(width: 8),
          Text('Ask me for savings, rails, and nearby merchants.', style: Theme.of(context).textTheme.bodyMedium) ]),
        const SizedBox(height: 12),
        TextFormField(controller: prompt, decoration: const InputDecoration(labelText:'Ask me anything')),
        const SizedBox(height: 12),
        Row(children:[
          Expanded(child: ElevatedButton(onPressed: loading? null : () async { setState(()=>loading=true); try{ final r=await widget.api.aiHelp(prompt.text.trim()); setState(()=>reply=r['reply']); } catch(e){ setState(()=>reply='Error: $e'); } setState(()=>loading=false); }, child: Text(loading? 'Thinking…':'Ask'))),
          const SizedBox(width: 8),
          ElevatedButton(onPressed: () async { final list = await widget.api.merchants('coffee promos'); setState(()=>merchants=list); }, child: const Text('Discover merchants')),
        ]),
        const SizedBox(height: 12),
        if(reply!=null) Card(child: Padding(padding: const EdgeInsets.all(16), child: Text(reply!))),
        if(merchants.isNotEmpty) ...[ const SizedBox(height: 8), Text('Nearby merchants', style: Theme.of(context).textTheme.titleMedium),
          ...merchants.map((m)=>Card(child: ListTile(leading: const Icon(Icons.storefront), title: Text(m['name']), subtitle: Text(m['promo']??'')))) ]
      ])),
    );
  }
}
