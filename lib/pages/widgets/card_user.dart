import 'package:flutter/material.dart';
import 'package:pat_example_project/data/model/responses/list_user_response.dart';
import 'package:pat_example_project/pages/users/detail_screen.dart';
import 'package:pat_example_project/utils/string_ext.dart';

class CardUser extends StatefulWidget {
  const CardUser({super.key, required this.data});

  final Data data;

  @override
  State<CardUser> createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  void _navigateToDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailUserScreen(
                id: widget.data.id ?? '',
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: ClipOval(child: Image.network('${widget.data.picture}')),
            title: Text('${(widget.data.title)?.toTitleCase()}'),
            subtitle: Text('${widget.data.firstName} ${widget.data.lastName}'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text(''),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Visit'),
                onPressed: () => _navigateToDetail(),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
    ;
  }
}
