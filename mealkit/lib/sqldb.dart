import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Userdetails
{
  static Database? _db;
  Future<Database?> get db async
  {
    _db ??= await intialDb();
    return _db;
  }


intialDb() async
{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'user.db');
    Database mydb = await openDatabase(path, onCreate:_onCreate, version: 3, onUpgrade: _onUpgrade);
    return mydb;
}

_onUpgrade(Database db, int oldversion, int newversion)
{
    print("UPGRADE_____________________________");
}
_onCreate(Database db, int version)async
{
  await db.execute('''
   CREATE TABLE "user_details"
   (
     "username" VARCHAR NOT NULL PRIMARY KEY,
     "contact" INTEGER NOT NULL
   )

  ''');
  print("Create database and table");
}

readData(String sql)async
{
  Database? mydb = await db;
  List<Map> response = await mydb!.rawQuery(sql);
  return response;
}

insertData(String sql, List<dynamic> values) async {
  Database? mydb = await db;
  
  // Execute the SQL statement with the provided values
  int response = await mydb!.rawInsert(sql, values);

  return response;
}

updateData(String sql)async
{
  Database? mydb = await db;
  int response = await mydb!.rawUpdate(sql);
  return response;
}

deleteData(String sql)async
{
  Database? mydb = await db;
  int response = await mydb!.rawDelete(sql);
  return response;
}
}













