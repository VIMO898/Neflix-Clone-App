// import 'package:app/screens/search_screen.dart';
// import 'package:app/utils/navigator_shortcuts.dart';
// import 'package:flutter/material.dart';

// import '../widgets/home/home_drawer.dart';

// class BaseScaffold extends StatelessWidget {
//   final String title;
//   final PreferredSizeWidget? appBarBottom;
//   final Widget body;
//   const BaseScaffold({
//     super.key,
//     required this.title,
//     this.appBarBottom,
//     required this.body,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         actions: [
//           IconButton(onPressed: null, icon: const Icon(Icons.cast)),
//           IconButton(
//             onPressed: () {
//               NavHelper.push(context, SearchScreen());
//             },
//             icon: const Icon(Icons.search),
//           ),
//         ],
//         bottom: appBarBottom,
//       ),
//       body: body,
//       drawer: const HomeDrawer(),
//     );
//   }
// }
