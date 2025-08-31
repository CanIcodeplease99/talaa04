import 'package:flutter/material.dart';
class ChatScreen extends StatefulWidget{ const ChatScreen({super.key, required this.api}); final dynamic api; @override State<ChatScreen> createState()=>_ChatState(); }
class _ChatState extends State<ChatScreen>{ final threads=[{'id':'t1','name':'@kori','last':'Lunch split • 25.00'},{'id':'t2','name':'@arita','last':'Refund • 18.00'}];
  @override Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: const Text('Chats')), body: ListView(children:[
      ...threads.map((t)=>ListTile(leading: const CircleAvatar(child: Icon(Icons.person)), title: Text(t['name']!), subtitle: Text(t['last']!), onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(_)=>ChatThread(thread:t)))))
    ]));
  }
}
class ChatThread extends StatefulWidget{ final Map thread; const ChatThread({super.key, required this.thread}); @override State<ChatThread> createState()=>_ThreadState(); }
class _ThreadState extends State<ChatThread>{ final msgs=[{'from':'me','text':'I covered tickets.'},{'from':'them','text':'Cool, I’ll send 25.'}]; final text=TextEditingController();
  @override Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text(widget.thread['name'])), body: Column(children:[
      Expanded(child: ListView(padding: const EdgeInsets.all(12), children: msgs.map((m){ final me=m['from']=='me'; return Align(alignment: me? Alignment.centerRight: Alignment.centerLeft, child: Container(margin: const EdgeInsets.symmetric(vertical:6), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: me? Colors.blueAccent : Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)), child: Text(m['text']!))); }).toList())),
      Padding(padding: const EdgeInsets.all(8), child: Row(children:[ Expanded(child: TextField(controller: text, decoration: const InputDecoration(hintText:'Message…'))), const SizedBox(width: 8),
        ElevatedButton(onPressed: (){ setState(()=>msgs.add({'from':'me','text':text.text})); text.clear(); }, child: const Icon(Icons.send)) ])),
      const SizedBox(height: 8),
      Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children:[
        OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.request_page), label: const Text('Request')),
        OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.payments), label: const Text('Pay 25')),
      ]))
    ]));
  }
}
