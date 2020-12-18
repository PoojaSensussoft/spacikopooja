

import 'package:spacikopooja/sqlDB/DatabaseClass.dart';
import 'package:spacikopooja/sqlDB/dbhelper.dart';

class UsersProvider{
  static const String TABLE_NAME = "test_spaciko";

  Future<DatabaseClass> insert(DatabaseClass databaseClass) async{
    databaseClass.id = (await DBHelper.dbHelper.getDatabase().insert(TABLE_NAME, databaseClass.toMap())) as String;
    return databaseClass;
  }

  Future<DatabaseClass> get(int id) async {
    List<Map> maps = await DBHelper.dbHelper.getDatabase().query(TABLE_NAME,
        columns: [DatabaseClass.columnId, DatabaseClass.columnFName, DatabaseClass.columnEmail],
        where: '${DatabaseClass.columnId} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return DatabaseClass.fromMap(maps.first);
    }
    return null;
  }


  Future<List<DatabaseClass>> getAll() async {
    var res = await DBHelper.dbHelper.getDatabase().query(TABLE_NAME);
    List<DatabaseClass> list =
    res.isNotEmpty ? res.map((c) => DatabaseClass.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> delete(int id) async {
    return await DBHelper.dbHelper
        .getDatabase()
        .delete(TABLE_NAME, where: '${DatabaseClass.columnId} = ?', whereArgs: [id]);
  }

  Future<int> update(DatabaseClass user) async {
    return await DBHelper.dbHelper.getDatabase().update(
        TABLE_NAME, user.toMap(),
        where: '${DatabaseClass.columnId} = ?', whereArgs: [user.id]);
  }
}