import "package:flutter/material.dart";
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/books.dart';
import '../widgets/book_item.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LibraryState();
  }
}

class _LibraryState extends State<Library> {
  List<Books> _data = [];
  bool hasSynced = false;
  StreamSubscription? _subscription;
  StreamSubscription? _syncStatusSubscription;

  _LibraryState();

  @override
  void initState() {
    super.initState();
    final stream = Books.watchLists();
    _subscription = stream.listen((data) {
      if (!context.mounted) {
        return;
      }
      setState(() {
        _data = data;
      });
    });
    _syncStatusSubscription = Books.watchSyncStatus().listen((status) {
      if (!context.mounted) {
        return;
      }
      setState(() {
        hasSynced = status.hasSynced ?? false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
    _syncStatusSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return !hasSynced
        ? const Text("Busy with sync...")
        : ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: _data.map((list) {
              return ListItemWidget(list: list);
            }).toList(),
          );
  }
}
