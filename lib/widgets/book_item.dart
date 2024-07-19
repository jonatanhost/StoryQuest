import 'package:flutter/material.dart';

import '../pages/library.dart';
import '../models/books.dart';

class ListItemWidget extends StatelessWidget {
  ListItemWidget({
    required this.list,
  }) : super(key: ObjectKey(list));

  final Books list;

  @override
  Widget build(BuildContext context) {
    var navigator = Navigator.of(context);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.list),
            title: Text(list.name),
          ),
        ],
      ),
    );
  }
}
