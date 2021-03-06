import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:updateperutangan/src/ext/simple_bloc_delegate.dart';
import 'package:updateperutangan/src/page/detail_hutang/detail_bloc/detail_bloc.dart';
import 'package:updateperutangan/src/page/detail_piutang/detail_bloc/detail_bloc.dart';
import 'package:updateperutangan/src/page/home/bloc/home_bloc.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_bloc.dart';
import 'package:updateperutangan/src/page/login/bloc/login_bloc.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_bloc.dart';
import 'package:updateperutangan/src/page/piutang/create_putang_form.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_bloc.dart';
import 'package:updateperutangan/src/page/register/bloc/register_bloc.dart';
import 'package:updateperutangan/src/widget/splash_screen.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider<PiutangBloc>(
            create: (context) => PiutangBloc(),
          ),
          BlocProvider<HutangBloc>(
            create: (context) => HutangBloc(),
          ),
          BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(),
          ),
          BlocProvider<DetailBloc>(
            create: (context) => DetailBloc(),
          ),
          BlocProvider<DetailPiutangBloc>(
            create: (context) => DetailPiutangBloc(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
        ));
  }
}
