import 'dart:io';
import 'package:note_app/global/constant/data_fields.dart';
import 'package:note_app/model/category_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CategoryDB {
  Future<Database> initializeDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'category.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $categoryTable($category_id INTEGER PRIMARY KEY, $category_name TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertCategory(CategoryModel category) async {
    var db = await initializeDatabase();
    await db.insert(categoryTable, category.toMap());
    print('add success');
  }

  Future<List<CategoryModel>> getCategory() async {
    var db = await initializeDatabase();
    List<Map<String, dynamic>> result = await db.query(categoryTable);
    return result.map((e) => CategoryModel.fromMap(e)).toList();
  }

  Future<void> deleteCategoty() async {}
  Future<void> updateCategory() async {}
}
