import 'package:flutter/material.dart'; import '../tokens/colors.dart';
class InstantToggle extends StatelessWidget{ final bool instant; final ValueChanged<bool> onChanged; const InstantToggle({super.key, required this.instant, required this.onChanged});
  @override Widget build(BuildContext context){ return Row(children:[
    Expanded(child:_Chip(label:'Standard — Free',active:!instant,onTap:()=>onChanged(false),activeFill: Theme.of(context).brightness==Brightness.dark? const Color(0xFF1A1F2E) : Colors.white, activeText: Theme.of(context).brightness==Brightness.dark? Colors.white : const Color(0xFF0E1220))),
    const SizedBox(width:8),
    Expanded(child:_Chip(label:'Instant — Small fee',active:instant,onTap:()=>onChanged(true),activeFill:TalaaColors.royalBlue,activeText:Colors.white)),
  ]); } }
class _Chip extends StatelessWidget{ final String label; final bool active; final VoidCallback onTap; final Color activeFill; final Color activeText; const _Chip({required this.label, required this.active, required this.onTap, required this.activeFill, required this.activeText});
  @override Widget build(BuildContext context){ return AnimatedContainer(duration: const Duration(milliseconds: 240), decoration: BoxDecoration(color: active? activeFill : (Theme.of(context).brightness==Brightness.dark? const Color(0xFF1A1F2E) : const Color(0xFFEFF2F8)), borderRadius: BorderRadius.circular(16), border: Border.all(color: active? Colors.transparent : Colors.black12)), child: Material(type: MaterialType.transparency, child: InkWell(borderRadius: BorderRadius.circular(16), onTap: onTap, child: Padding(padding: const EdgeInsets.symmetric(horizontal:12, vertical:12), child: Center(child: Text(label, style: TextStyle(color: active? activeText : (Theme.of(context).brightness==Brightness.dark? Colors.white70 : const Color(0xFF0E1220).withOpacity(.7)), fontWeight: FontWeight.w600)))))); }
}
