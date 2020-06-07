

import 'package:flutter/material.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var usernameController = TextEditingController();
  var nameController = TextEditingController();
  var ovoController = TextEditingController();
  var gojekController = TextEditingController();
  var waController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Register',
        style: BaseStyle.ts14PrimaryBold,),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black54
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/logo.png')
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Username'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Name'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'OVO'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Gopay'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Whatapp'
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password'
                  ),
                ),TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Confirm Password'
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    onPressed: (){},
                    child: Text('Register'),
                  ),
                )

              ],
            ),
          ),
        ),
      )



    );
  }
}
