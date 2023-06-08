// import 'package:flutter/material.dart';

// class MenuItem {
//   final String text;
//   final IconData icon;

//   const MenuItem({
//     required this.text,
//     required this.icon,
//   });
// }

// class MenuItems {
//   static const List<MenuItem> firstItems = [like, share, download];
//   static const List<MenuItem> secondItems = [cancel];

//   static const like = MenuItem(text: 'Like', icon: Icons.favorite);
//   static const share = MenuItem(text: 'Share', icon: Icons.share);
//   static const download = MenuItem(text: 'Download', icon: Icons.download);
//   static const cancel = MenuItem(text: 'Cancel', icon: Icons.cancel);

//   static Widget buildItem(MenuItem item) {
//     return Row(
//       children: [
//         Icon(
//           item.icon,
//           color: Colors.white,
//           size: 22,
//         ),
//         const SizedBox(
//           width: 10,
//         ),
//         Text(
//           item.text,
//           style: const TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }

//   static onChanged(BuildContext context, MenuItem item) {
//     switch (item) {
//       case MenuItems.like:
//         //Do something
//         break;
//       case MenuItems.share:
//         //Do something
//         break;
//       case MenuItems.download:
//         //Do something
//         break;
//       case MenuItems.cancel:
//         //Do something
//         break;
//     }
//   }
// }
