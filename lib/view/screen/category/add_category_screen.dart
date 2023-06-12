import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_app/database/category_connection.dart';
import 'package:note_app/model/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController controller = TextEditingController();
  List<CategoryModel> categoryList = [];
  getCategoty() async {
    await CategoryDB().getCategory().then((value) {
      setState(() {
        categoryList = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Category')),
      body: Column(children: [
        Flexible(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'category name'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    elevation: 0,
                    heroTag: 'save',
                    backgroundColor: const Color.fromARGB(255, 214, 227, 231),
                    onPressed: () async {
                      if (controller.text.isNotEmpty) {
                        await CategoryDB()
                            .insertCategory(CategoryModel(
                                id: DateTime.now().microsecondsSinceEpoch,
                                name: controller.text))
                            .whenComplete(() => getCategoty());
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) => Card(
              elevation: 0,
              child: Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: null,
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: const Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.edit_note_rounded,
                      label: 'Edit',
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(categoryList[index].name),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
