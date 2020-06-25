

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_bloc.dart';
import 'package:updateperutangan/src/page/piutang/piutang_view.dart';

class PiutangPage extends StatelessWidget {
  const PiutangPage();

  @override
  Widget build(BuildContext context) {
    return PiutangView();
  }
}
