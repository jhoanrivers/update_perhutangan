import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';
import 'package:updateperutangan/src/page/login/login_page.dart';
import 'package:updateperutangan/src/page/register/bloc/register_bloc.dart';
import 'package:updateperutangan/src/page/register/bloc/register_event.dart';
import 'package:updateperutangan/src/page/register/bloc/register_state.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';
import 'package:updateperutangan/src/utils/constant.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var usernameController = TextEditingController();
  var nameController = TextEditingController();
  var ovoController = TextEditingController();
  var gopayController = TextEditingController();
  var passwordController = TextEditingController();
  var gopayNameController = TextEditingController();
  var ovoNameController = TextEditingController();

  final _formkeyRegister = GlobalKey<FormState>();
  bool autoVal = false;
  bool obsecurePass = true;
  bool autoValConfirm = false;
  var fcm_token = '';



  bool isUsernameEnable = false;
  bool isNameEnable = false;
  bool isOvoEnable = false;
  bool isOvoNameEnable = false;
  bool isGopayEnable = false;
  bool isGopayNameEnable = false;


  RegisterBloc registerBloc;
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

//  final numericRegex = RegExp(r'^(?:[620]81)?[0-9]{9,12}');
  var regExpName = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    getTokenFirebaseMessaging();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    nameController.dispose();
    ovoController.dispose();
    gopayController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is LoadingRegister) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Registering Process"),
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (state is ErrorRegister) {
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Username already used'),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state is SuccessRegister) {
          Navigator.pop(context);
          showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              child: Container(
                height: 180,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 60,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      Constant.successSignUp,
                      style: BaseStyle.ts14PrimaryName,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          });

          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (BuildContext context, RegisterState state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  Constant.register,
                  style: BaseStyle.ts14PrimaryBold,
                ),
                centerTitle: true,
                iconTheme: IconThemeData(color: Colors.black54),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/newlogo.png',
                        height: 160,
                        fit: BoxFit.cover,),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _formkeyRegister,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide()),
                                    labelText: 'Username'),
                                autovalidate: autoVal,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Username Cannot be empty';
                                  }
                                  return null;
                                },
                                onChanged: isUsernameExist,
                                controller: usernameController,
                                keyboardType: TextInputType.text,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide()),
                                  labelText: 'Name',
                                ),
                                autovalidate: autoVal,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Name cannot be empty';
                                  }
                                  if (regExpName.hasMatch(value)) {
                                    return 'Name must be alphabetical';
                                  }
                                  return null;
                                },
                                onChanged: isNameExist,
                                controller: nameController,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide()),
                                    suffix: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          obsecurePass = !obsecurePass;
                                        });
                                      },
                                      child: obsecurePass
                                          ? Text('Show')
                                          : Text('Hide'),
                                    )),
                                obscureText: obsecurePass,
                                controller: passwordController,
                                autovalidate: autoVal,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Password can not be empty';
                                  }
                                  if (value.length < 6) {
                                    return 'Password at least contains 6 characters';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      autoValConfirm = true;
                                    });
                                  } else {
                                    setState(() {
                                      autoValConfirm = false;
                                    });
                                  }
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide())),
                                obscureText: obsecurePass,
                                autovalidate: autoValConfirm,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Password can not be empty';
                                  }
                                  if (value != passwordController.text) {
                                    return 'Confirm password must be similar with password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Gopay',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide()),
                                  counterText: ""
                                ),
                                maxLength: 13,
                                controller: gopayController,
                                keyboardType: TextInputType.number,
                                autovalidate: autoVal,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Gopay number cannot be empty';
                                  }
                                  if (gopayController.text.length < 9) {
                                    return 'Gopay number at least 9 digit';
                                  }
                                  if (gopayController.text.length > 13) {
                                    return 'Gopay number maximum 13 digit';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide()),
                                  labelText: 'Gopay Name',
                                ),
                                autovalidate: autoVal,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Gopay name can not be empty';
                                  }
                                  if (regExpName.hasMatch(value)) {
                                    return 'Gopay number can not be numberical';
                                  }
                                  return null;
                                },
                                controller: gopayNameController,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'OVO',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide()),
                                  counterText: ""

                                ),
                                controller: ovoController,
                                autovalidate: autoVal,
                                keyboardType: TextInputType.number,
                                maxLength: 13,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Ovo number cannot be empty';
                                  }
                                  if (ovoController.text.length < 9) {
                                    return 'Ovo number at least 9 digit';
                                  }
                                  if (ovoController.text.length > 13) {
                                    return 'Ovo number maximum 13 digit';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide()),
                                  labelText: 'OVO Name',
                                ),
                                autovalidate: autoVal,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'OVO name cannot be empty';
                                  }
                                  if (regExpName.hasMatch(value)) {
                                    return 'OVO name can not be numerical';
                                  }
                                  return null;
                                },
                                controller: ovoNameController,
                              ),
                              SizedBox(
                                height: 48,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            color: isUsernameEnable
                            ? Colors.green
                            : Colors.grey,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            onPressed: _onButtonRegisterPressed,
                            child: Text(
                              'Register',
                              style: BaseStyle.ts16WhiteBold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  void _onButtonRegisterPressed() {
    if (!_formkeyRegister.currentState.validate()) {
      setState(() {
        autoVal = true;
      });
    } else {
      registerBloc.add(RegisterButtonPressed(

        username: usernameController.text,
        name: nameController.text,
        password: passwordController.text,
        gopay: gopayController.text,
        ovo: ovoController.text,
        gopayName: gopayNameController.text,
        ovoName: ovoNameController.text,
        fcm_token: fcm_token
      ));
    }
  }

  void getTokenFirebaseMessaging() {
    firebaseMessaging.getToken().then((value) => fcm_token = value);
  }


  void isUsernameExist(String value) {
    if(value.isNotEmpty){
      setState(() {
        isUsernameEnable = true;
      });
    } else{
      setState(() {
        isUsernameEnable = false;
      });
    }
  }

  void isNameExist(String value) {
    if(value.isNotEmpty){
      setState(() {
        isNameEnable = true;
      });
    } else{
      setState(() {
        isNameEnable = false;
      });
    }
  }

  void isOvoExist(String value) {
    if(value.isNotEmpty){
      setState(() {
        isOvoEnable = true;
      });
    } else{
      setState(() {
        isOvoEnable = false;
      });
    }
  }

  void isOvoNameExist(String value) {
    if(value.isNotEmpty){
      setState(() {
        isOvoNameEnable = true;
      });
    } else{
      setState(() {
        isOvoNameEnable = false;
      });
    }
  }

  void isGopayExist(String value) {
    if(value.isNotEmpty){
      setState(() {
        isGopayEnable = true;
      });
    } else{
      setState(() {
        isGopayEnable = false;
      });
    }
  }

  void isGopayNameExist(String value) {
    if(value.isNotEmpty){
      setState(() {
        isGopayNameEnable = true;
      });
    } else{
      setState(() {
        isGopayNameEnable = false;
      });
    }
  }





}
