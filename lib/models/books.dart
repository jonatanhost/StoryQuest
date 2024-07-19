import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3.dart' as sqlite;

import '../powersync.dart';

/// TodoList represents a result row of a query on "lists".
///
/// This class is immutable - methods on this class do not modify the instance
/// directly. Instead, watch or re-query the data to get the updated list.
class Books {
  /// List id (UUID).
  final String id;

  /// Descriptive name.
  final String name;

  Books({
    required this.id,
    required this.name,
  });

  factory Books.fromRow(sqlite.Row row) {
    return Books(
      id: row['id'],
      name: row['name'],
    );
  }

  /// Watch all lists.
  static Stream<List<Books>> watchLists() {
    // This query is automatically re-run when data in "lists" or "todos" is modified.
    return db
        .watch('SELECT * FROM books ORDER BY created_at, id')
        .map((results) {
      return results.map(Books.fromRow).toList(growable: false);
    });
  }

  static Stream<SyncStatus> watchSyncStatus() {
    return db.statusStream;
  }
}
