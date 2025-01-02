import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'local_consumer.dart';
import 'tables.dart';

class SqlfliteConsumer extends LocalConsumer {
  static final SqlfliteConsumer _instance = SqlfliteConsumer._internal();
  factory SqlfliteConsumer() => _instance;
  static Database? _database;

  SqlfliteConsumer._internal();

  @override
  Future<void> init() async {
    if (_database != null) return;
    String path = join(await getDatabasesPath(), 'app_database.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async =>
      await Tables.createTables(db);

  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    await init();
    return await _database!.insert(table, data);
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    await init();
    return await _database!.query(table);
  }

  @override
  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    await init();
    return await _database!.query(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<int> update(String table, Map<String, dynamic> data,
      {String? where, List<dynamic>? whereArgs}) async {
    await init();
    return await _database!
        .update(table, data, where: where, whereArgs: whereArgs);
  }

  @override
  Future<int> delete(String table,
      {String? where, List<dynamic>? whereArgs}) async {
    await init();
    return await _database!.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> close() async {
    await _database?.close();
  }
}
