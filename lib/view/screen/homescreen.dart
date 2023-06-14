import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
                    builder: (context) => const AddNoteScreen(),
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
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
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
    );
  }
}
