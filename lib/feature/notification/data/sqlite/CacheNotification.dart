import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'NotificationTable.dart';


class CacheNotification{

  static Database? _db ;


  Future<Database?> get db async {
    if(_db == null){
      _db = await _createDatabase();
      return _db;
    }else{
      return _db;
    }
  }

  static const tableNotification = '''
    CREATE TABLE notification_data (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      subtitle TEXT,
      time TEXT
    )
  ''';


  _createDatabase() async{
    //define the path to the database
    String path = join(await getDatabasesPath(), 'notification.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(tableNotification);
        });
  }


  Future<int> insertNotification(NotificationTable notificationTable) async {
    Database? myDb = await db;
    return myDb!.insert('notification_data', notificationTable.toJson());
  }



  Future<List<NotificationTable>?> getNotifications() async {
    Database? myDb = await db;
    List<Map<String, dynamic>> results = await myDb!.query('notification_data');
    if (results.isNotEmpty) {
      return List.generate(results.length, (i) {
        return NotificationTable.fromMap(results[i]);
      });
    }
    return null;
  }

}