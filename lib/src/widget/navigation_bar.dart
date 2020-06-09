


import 'package:flutter/material.dart';
import 'package:updateperutangan/src/page/home/home_page.dart';
import 'package:updateperutangan/src/page/minus/minus_view.dart';
import 'package:updateperutangan/src/page/plus/plus_view.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: HomePage(),
    ),
    Center(
      child: MinusView(),
    ),
    Center(
      child: PlusView(),
    )

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_received),
            title: Text('Minus')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_made),
            title: Text('Plus')
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onTapItem,


      ),
    );
  }

  void _onTapItem(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
