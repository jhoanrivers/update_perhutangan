

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/page/home/home_page.dart';
import 'package:updateperutangan/src/page/login/bloc/login_bloc.dart';
import 'package:updateperutangan/src/page/login/bloc/login_event.dart';
import 'package:updateperutangan/src/page/login/bloc/login_state.dart';
import 'package:updateperutangan/src/page/register/register_page.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = BlocProvider.of<LoginBloc>(context);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if(state is ErrorLogin){
            Navigator.pop(context);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Login Failure'),
                backgroundColor: Colors.red,
              ),
            );
          }

          if(state is SuccessLogin){
            Navigator.pop(context);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage()), (route)=> false);
          }

          if(state is LoadingLogin){
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 20,),
                        Text("Login Process"),
                      ],
                    ),
                  ),
                );
              },
            );
          }



        },
        child: BlocBuilder<LoginBloc,LoginState>(
          builder: (BuildContext context, LoginState state) {

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                          height: 100,
                          width: 100,
                          child: Image.asset('assets/logo.png')
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Username'
                        ),
                        controller: usernameController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Password',
                            suffix: FlatButton(
                              onPressed: (){},
                              child: Text('Show'),
                            )
                        ),
                        controller: passwordController,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 80,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          color: Colors.blue,
                          onPressed: onButtonPressed,
                          child: Text('Login',
                            style: BaseStyle.ts18WhiteBold,),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? "),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));

                            },
                            child: Text('Sign Up',
                              style: BaseStyle.ts12BlueBold,),
                          )

                        ],
                      ),


                    ],
                  ),
                ),
              ),
            );

          },

        ),

      )




    );
  }

  void onButtonPressed() {
    loginBloc.add(
      LoginButtonPressed(
        username: usernameController.text,
        password: passwordController.text,
      )
    );

  }
}
