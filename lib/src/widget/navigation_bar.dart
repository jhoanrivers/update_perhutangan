


import 'package:flutter/material.dart';
import 'package:updateperutangan/src/page/home/home_page.dart';
import 'package:updateperutangan/src/page/hutang/minus_view.dart';
import 'package:updateperutangan/src/page/piutang/piutang_page.dart';
import 'package:updateperutangan/src/page/piutang/piutang_view.dart';
import 'package:updateperutangan/src/page/profile/profile_page.dart';

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
      child: PiutangPage(),
    ),
    Center(
      child: PiutangView(),
    ),
    Center(
      child: ProfilePage(),
    )


  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_received),
            title: Text('Hutang')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_made,),
            title: Text('Piutang')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile')
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
         _selectedIndex == 1
             ? Colors.red
             : _selectedIndex == 2
                ? Colors.green
                : Colors.deepOrangeAccent,
        selectedLabelStyle: TextStyle(
          color: _selectedIndex == 1
              ? Colors.red
              : _selectedIndex == 2
                ? Colors.green
                : Colors.grey,
        ),
        onTap: _onTapItem,
        unselectedItemColor: Colors.grey,


      ),
    );
  }

  void _onTapItem(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
