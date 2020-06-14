

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_bloc.dart';
import 'package:updateperutangan/src/page/piutang/piutang_view.dart';

class PiutangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PiutangBloc(),
      child: PiutangView(),
    );
  }
}
