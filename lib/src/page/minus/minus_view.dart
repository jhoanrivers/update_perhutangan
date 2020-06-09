

import 'package:flutter/material.dart';

class MinusView extends StatefulWidget {

  const MinusView();


  @override
  _MinusViewState createState() => _MinusViewState();
}

class _MinusViewState extends State<MinusView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Minus'),
      ),
    );
  }
}
