import 'package:sqflite/sqflite.dart'as sql;


class SqlHelper{

  static Future<sql.Database>openOrCreateDb()async{
    return await sql.openDatabase('notes',
    version: 1,
    onCreate: (database,int) async{
 await createTable(database);
    });


  }

  static createTable(sql.Database database) async{
    await database.execute(
        "CREATE TABLE MyNotes(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT,description TEXT)");
  }

}