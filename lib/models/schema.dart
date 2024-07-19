import 'package:powersync/powersync.dart';
import 'package:powersync_attachments_helper/powersync_attachments_helper.dart';

const booksTable = 'books';

Schema schema = Schema([
  Table('booksTable',
      [Column.text('created_at'), Column.text('name'), Column.text('owner_id')])
]);
