import 'package:note_app/global/constant/data_fields.dart';
import 'package:note_app/global/style/style_widget.dart';

class NoteModel {
  late int id;
  late String title;
  late String description;
  late String colorCode;
  late String category;
  NoteModel(
      {required this.id,
      required this.title,
      required this.category,
      required this.colorCode,
      required this.description});
  Map<String, dynamic> toMap() {
    return {
      note_id: id,
      note_title: title,
      note_color: colorCode,
      note_description: description,
      categoryName: category
    };
  }

  NoteModel.fromMap(Map<String, dynamic> res)
      : id = res[note_id],
        title = res[note_title],
        colorCode = res[note_color],
        description = res[note_description],
        category = res[categoryName];
}
