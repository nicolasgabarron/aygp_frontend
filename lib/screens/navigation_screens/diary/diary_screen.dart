import 'package:aygp_frontend/services/diary_service.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Servicio de Diario.
    final diaryService = Provider.of<DiaryService>(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: 25,
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.pushNamed(context, 'diaryedit'),
          title: Text('Item $index'),
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
    );
  }
}
