import 'package:flutter/material.dart';

class HiveInsert extends StatefulWidget {
  const HiveInsert({Key? key}) : super(key: key);

  @override
  _HiveInsertState createState() => _HiveInsertState();
}

class _HiveInsertState extends State<HiveInsert> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
