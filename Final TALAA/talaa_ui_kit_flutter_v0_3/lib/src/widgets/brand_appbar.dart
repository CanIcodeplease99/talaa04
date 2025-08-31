import 'package:flutter/material.dart';
class BrandAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title; final String? subtitle;
  const BrandAppBar({super.key, required this.title, this.subtitle});
  @override Size get preferredSize => const Size.fromHeight(64);
  @override Widget build(BuildContext context){
    return AppBar(
      title: Row(children:[
        ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset('assets/talaa_logo.png', height: 28, width: 28, fit: BoxFit.cover)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          if(subtitle!=null) Text(subtitle!, style: Theme.of(context).textTheme.labelSmall),
        ])
      ]),
      centerTitle: false,
    );
  }
}
