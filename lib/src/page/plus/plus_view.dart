

import 'package:flutter/material.dart';

class PlusView extends StatefulWidget {

  const PlusView();

  @override
  _PlusViewState createState() => _PlusViewState();
}

class _PlusViewState extends State<PlusView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Pluss'),
      ),
    );
  }
}
