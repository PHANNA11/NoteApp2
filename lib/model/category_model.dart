import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CategoryModel {
  late int id;
  late String name;
  late String hexColors;
  CategoryModel(
      {required this.id, required this.name, required this.hexColors});
}

List<CategoryModel> categorys = [
  CategoryModel(id: 1, name: 'Person', hexColors: '#1da2d8'),
  CategoryModel(id: 2, name: 'work', hexColors: '#fbae85')
];
