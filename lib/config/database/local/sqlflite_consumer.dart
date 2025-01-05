import 'package:flutter/foundation.dart';
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
  Future<int?> getLastUpdateTime(String tableName) async {
    await init();
    List<Map<String, dynamic>> result = await _database!.query(
      Tables.lastUpdateTable,
      where: '${Tables.tableNameColumn} = ?',
      whereArgs: [tableName],
    );
    if (result.isNotEmpty) {
      return result.first[Tables.lastUpdateColumn] as int?;
    }
    return null; // Return null if no record exists
  }

  @override
  Future<void> refreshDataIfNeeded(
      String table, List<Map<String, dynamic>> newData,
      {int intervalInDays = 7}) async {
    await init();
    int? lastUpdateTime = await getLastUpdateTime(table);
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (lastUpdateTime == null ||
        (currentTime - lastUpdateTime) > intervalInDays * 24 * 60 * 60 * 1000) {
      await _database!.delete(table);
      await insertMultiple(table, newData);
      await setLastUpdateTime(table, currentTime);
      debugPrint('Data refreshed for table: $table');
    } else {
      debugPrint('No refresh needed for table: $table');
    }
  }

  @override
  Future<void> setLastUpdateTime(String tableName, int timestamp) async {
    await init();
    await _database!.insert(
      Tables.lastUpdateTable,
      {
        Tables.tableNameColumn: tableName,
        Tables.lastUpdateColumn: timestamp,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, // Update if already exists
    );
  }

  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    await init();
    return await _database!.insert(table, data);
  }

  @override
  Future<void> insertMultiple(
      String table, List<Map<String, dynamic>> dataList) async {
    await init();
    await _database!.transaction((txn) async {
      for (var data in dataList) {
        await txn.insert(table, data);
      }
    });
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
