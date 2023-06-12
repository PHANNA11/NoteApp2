import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:note_app/global/constant/data_fields.dart';

class CategoryModel {
  late int id;
  late String name;

  CategoryModel({required this.id, required this.name});
  Map<String, dynamic> toMap() {
    return {
      category_id: id,
      category_name: name,
    };
  }

  CategoryModel.fromMap(Map<String, dynamic> res)
      : id = res[category_id],
        name = res[category_name];
}

List<CategoryModel> categorys = [
  CategoryModel(id: 1, name: 'Person'),
  CategoryModel(id: 2, name: 'work')
];
