

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_bloc.dart';
import 'package:updateperutangan/src/page/hutang/hutang_view.dart';

class HutangPage extends StatelessWidget {
  const HutangPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HutangBloc(),
      child: HutangView(),
    );
  }
}
