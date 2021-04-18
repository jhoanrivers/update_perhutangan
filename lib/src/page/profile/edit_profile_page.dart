


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_bloc.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_event.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_state.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  ProfileBloc profileBloc;
  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  var nameController = TextEditingController();
  var ovoController = TextEditingController();
  var gopayController = TextEditingController();
  var passwordController = TextEditingController();
  var gopayNameController = TextEditingController();
  var ovoNameController = TextEditingController();
  var danaNameController = TextEditingController();
  var danaNumberController = TextEditingController();


  final _formkeyRegister = GlobalKey<FormState>();
  bool autoVal = false;
  bool obsecurePass = true;
  bool autoValConfirm = false;



  var regExpName = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileBloc = BlocProvider.of<ProfileBloc>(context);

    setDataUserInForm(profileBloc.dataUser);
  }


  void setDataUserInForm(Account dataUser) {

    nameController.text = dataUser.name;
    ovoController.text = dataUser.ovo;
    gopayController.text = dataUser.gopay ;
    passwordController.text = stringToBase64.decode(dataUser.password);
    gopayNameController.text = dataUser.gopayName;
    ovoNameController.text = dataUser.ovoName;
    danaNameController.text = dataUser.danaName;
    danaNumberController.text = dataUser.dana;

  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPopScope,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black54,
            onPressed: (){
              onWillPopScope();
            },
          ),
          backgroundColor: Colors.white,
          title: Text('Edit Profile', style: BaseStyle.ts16Black,),
        ),
        body: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if(state is LoadingEditData){
              showDialog(
                context: context,
                barrierDismissible: false,
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
                          Text("Editing Profile"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            if (state is LoginAgainAfterEditData) {
              Navigator.pop(context);
              showDialog(
                context: context,
                barrierDismissible: false,
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
                          Text("Please wait for a while"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }



            if (state is SuccessEditProfile) {
              profileBloc.add(UserFetchData());
              Navigator.pop(context);
              Navigator.pop(context);
            }

          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return SingleChildScrollView(
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
                                    labelText: 'Gopay Number',
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
                                    labelText: 'OVO Number',
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
                                    return 'OVO name can not be empty';
                                  }
                                  if (regExpName.hasMatch(value)) {
                                    return 'OVO number can not be numberical';
                                  }
                                  return null;
                                },
                                controller: ovoNameController,
                              ),

                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Dana Number',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide()),
                                    counterText: ""

                                ),
                                controller: danaNumberController,
                                keyboardType: TextInputType.number,
                                maxLength: 13,
                              ),

                              SizedBox(
                                height: 24,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide()),
                                  labelText: 'Dana Name',
                                ),
                                controller: danaNameController,
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
                            color: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 14),
                            onPressed: _onButtonRegisterPressed,
                            child: Text(
                              'Edit Profile',
                              style: BaseStyle.ts16WhiteBold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }


  void _onButtonRegisterPressed() {
    if (!_formkeyRegister.currentState.validate()) {
      setState(() {
        autoVal = true;
      });
    } else {

      Account dataAccount = new Account(
        username: profileBloc.dataUser.username,
          name: nameController.text,
          password: passwordController.text,
          gopay: gopayController.text,
          ovo: ovoController.text,
          gopayName: gopayNameController.text,
          ovoName: ovoNameController.text,
          danaName: danaNameController.text,
          dana: danaNumberController.text,
      );

      profileBloc.add(EditProfileEvent(
        dataAccount: dataAccount
      ));
    }
  }


  Future<bool> onWillPopScope() async{
    Navigator.pop(context);
    return false;
  }


}
