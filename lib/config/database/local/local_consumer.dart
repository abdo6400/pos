abstract class LocalConsumer {
  // Initialize the database
  Future<void> init();

  // Insert data into a table
  Future<int> insert(String table, Map<String, dynamic> data);

  // Insert multiple rows into a table
  Future<void> insertMultiple(
      String table, List<Map<String, dynamic>> dataList);

  // Query all rows from a table
  Future<List<Map<String, dynamic>>> queryAll(String table);

  // Query rows with conditions
  Future<List<Map<String, dynamic>>> query(String table,
      {String? where, List<dynamic>? whereArgs});

  // Update rows in a table
  Future<int> update(String table, Map<String, dynamic> data,
      {String? where, List<dynamic>? whereArgs});

  // Delete rows from a table
  Future<int> delete(String table, {String? where, List<dynamic>? whereArgs});

  // Check if data is updated
  Future<void> setLastUpdateTime(String tableName, int timestamp);
  Future<int?> getLastUpdateTime(String tableName);
  Future<void> refreshDataIfNeeded(
      String table, List<Map<String, dynamic>> newData,
      {int intervalInHours = 24});
  // Close the database
  Future<void> close();
}
