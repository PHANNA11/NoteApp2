import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../category/category_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        buildCardWidget(context),
        const Divider(color: Colors.black, indent: 10),
        // buildCardWidget(context),
        // const Divider(color: Colors.black, indent: 10),
        // buildCardWidget(context),
      ],
    ));
  }

  Widget buildCardWidget(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CategoryScreen(),
              ));
        },
        leading: const CircleAvatar(
          maxRadius: 20,
          child: Center(
              child: Icon(
            Icons.category,
            size: 30,
          )),
        ),
        title: Text('Add Categoty'),
        trailing: Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }
}
