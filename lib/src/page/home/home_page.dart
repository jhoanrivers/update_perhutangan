

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_page.dart';
import 'package:updateperutangan/src/page/home/bloc/home_bloc.dart';
import 'package:updateperutangan/src/page/home/home_view.dart';
import 'package:updateperutangan/src/page/request/request_page.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class HomePage extends StatefulWidget {
  const HomePage();


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return HomeView();
  }
}
