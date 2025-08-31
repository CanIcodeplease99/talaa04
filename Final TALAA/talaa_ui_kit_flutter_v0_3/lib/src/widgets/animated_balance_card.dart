import 'dart:math'; import 'package:flutter/material.dart'; import '../tokens/colors.dart';
class AnimatedBalanceCard extends StatefulWidget { final String title; final String amount; final String currency;
  const AnimatedBalanceCard({super.key, required this.title, required this.amount, required this.currency});
  @override State<AnimatedBalanceCard> createState()=>_AnimatedBalanceCardState(); }
class _AnimatedBalanceCardState extends State<AnimatedBalanceCard> with SingleTickerProviderStateMixin {
  late AnimationController _c; @override void initState(){ super.initState(); _c=AnimationController(vsync:this,duration:const Duration(seconds:6))..repeat(); } @override void dispose(){ _c.dispose(); super.dispose(); }
  @override Widget build(BuildContext context){ return AnimatedBuilder(animation:_c,builder:(_,__){
    final angle=_c.value*2*pi;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: LinearGradient(begin:Alignment.topLeft,end:Alignment.bottomRight, colors:[const Color(0xFF111426), TalaaColors.royalBlue.withOpacity(.18), TalaaColors.indigo.withOpacity(.18)])),
      child: Container(margin:const EdgeInsets.all(1.2),padding:const EdgeInsets.all(20),decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        gradient: SweepGradient(startAngle:angle,endAngle:angle+6.28318, colors:[TalaaColors.royalBlue.withOpacity(.10), Colors.transparent, TalaaColors.softViolet.withOpacity(.10), Colors.transparent, TalaaColors.royalBlue.withOpacity(.10)], stops: const [0,.25,.5,.75,1]),),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Text(widget.title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
          const SizedBox(height:8),
          Row(children:[ Text(widget.amount, style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)), const SizedBox(width:8),
            Container(padding: const EdgeInsets.symmetric(horizontal:10,vertical:6), decoration: BoxDecoration(color: const Color(0xFF1A1F2E), borderRadius: BorderRadius.circular(12)), child: Text(widget.currency, style: const TextStyle(color: Colors.white70))) ]),
          const SizedBox(height:8),
          Row(children:[ const Icon(Icons.lock, size:18, color: Colors.white70), const SizedBox(width:6), Text('Instant • Protected', style: const TextStyle(color: Colors.white70)) ]),
        ]),
      ),
    );
  }); }
}
