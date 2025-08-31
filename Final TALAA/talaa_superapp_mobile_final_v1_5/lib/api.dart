import 'dart:convert'; import 'package:http/http.dart' as http;
class Api {
  final String base; Api(this.base);
  Future<List<dynamic>> wallets() async{ final r=await http.get(Uri.parse('$base/v1/wallets')); if(r.statusCode==200) return List<dynamic>.from(jsonDecode(r.body)); throw Exception(r.body); }
  Future<Map<String,dynamic>> transfer(String id,String to,String amt,String cur,{bool boost=false}) async{
    final key=DateTime.now().microsecondsSinceEpoch.toString();
    final r=await http.post(Uri.parse('$base/v1/transfers'), headers:{'Content-Type':'application/json','Idempotency-Key':key},
      body: jsonEncode({'sender_wallet_id':id,'receiver':to,'amount':amt,'currency':cur,'boost':boost}));
    if(r.statusCode==201||r.statusCode==200) return Map<String,dynamic>.from(jsonDecode(r.body)); throw Exception(r.body);
  }
  Future<Map<String,dynamic>> split(String id,String cur,List<Map<String,String>> items,{bool boost=false}) async{
    final key=DateTime.now().microsecondsSinceEpoch.toString();
    final r=await http.post(Uri.parse('$base/v1/split'), headers:{'Content-Type':'application/json','Idempotency-Key':key},
      body: jsonEncode({'sender_wallet_id':id,'currency':cur,'items':items,'boost':boost}));
    if(r.statusCode==201||r.statusCode==200) return Map<String,dynamic>.from(jsonDecode(r.body)); throw Exception(r.body);
  }
  Future<Map<String,dynamic>> aiHelp(String prompt) async{
    final key=DateTime.now().microsecondsSinceEpoch.toString();
    final r=await http.post(Uri.parse('$base/v1/ai/assistant'), headers:{'Content-Type':'application/json','Idempotency-Key':key}, body: jsonEncode({'prompt':prompt}));
    if(r.statusCode==201||r.statusCode==200) return Map<String,dynamic>.from(jsonDecode(r.body)); throw Exception(r.body);
  }
  Future<List<dynamic>> merchants(String query) async{
    final r=await http.get(Uri.parse('$base/v1/merchants?query=${Uri.encodeQueryComponent(query)}'));
    if(r.statusCode==200) return List<dynamic>.from(jsonDecode(r.body)); throw Exception(r.body);
  }
}
