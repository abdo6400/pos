abstract class LocalConsumer {
  // Initialize the database
  Future<void> init();

  // Insert data into a table
  Future<int> insert(String table, Map<String, dynamic> data);

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

  // Close the database
  Future<void> close();
}
