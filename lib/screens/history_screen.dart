import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp2/utils.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: searchHistory.isEmpty
          ? Center(child: const Text('Nothing yet, keep searching!'))
          : Column(
              mainAxisSize: MainAxisSize.max,
              children: searchHistory
                  .map((e) => ListTile(
                        onTap: () => Navigator.of(context).pop(e),
                        title: Text(e),
                      ))
                  .toList()),
    );
  }
}
