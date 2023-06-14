import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:note_app/database/category_connection.dart';
import 'package:note_app/database/note_connection.dart';
import 'package:note_app/global/style/style_widget.dart';
import 'package:note_app/model/category_model.dart';
import 'package:note_app/model/note_model.dart';
import 'package:note_app/view/screen/add_note.dart';
import 'package:note_app/view/screen/drawer/drawer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> notes = [];
  getNote() async {
    await NoteDB().getNote().then((value) {
      setState(() {
        notes = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getNote();
    return Scaffold(
      endDrawer: const Drawer(
        child: DrawerScreen(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('O.D Note'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) => buildNoteCard(note: notes[index]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNoteScreen(
                      noteUpdate: null,
                    ),
                  ));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget buildNoteCard({NoteModel? note}) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            dismissible: null,
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15)),
                onPressed: (context) async {
                  await NoteDB()
                      .deleteNote(note!.id)
                      .whenComplete(() => getNote());
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                onPressed: (context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNoteScreen(
                          noteUpdate: note,
                        ),
                      ));
                  // showModalBottomSheet(
                  //   context: context,
                  //   builder: (context) =>
                  //       buildDialog(categoryList[index]),
                  // );
                },
                backgroundColor: const Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.edit_note_rounded,
                label: 'Edit',
              ),
            ],
          ),
          child: Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(blurRadius: 0.1, color: Colors.grey),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(note!.title, style: noteTitle),
                            Text(note.description, style: notebody),
                            Text(
                              DateFormat()
                                  .add_yMMMd()
                                  .add_Hm()
                                  .format(DateTime.now()),
                              style: notebody,
                            )
                          ]),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              note.category,
                              style: noteCategory,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                maxRadius: 8,
                                backgroundColor: HexColor(note.colorCode),
                              ),
                            )
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
