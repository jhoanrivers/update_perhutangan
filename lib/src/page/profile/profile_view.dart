

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/model/account.dart';
import 'package:updateperutangan/src/page/login/login_page.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_bloc.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_event.dart';
import 'package:updateperutangan/src/page/profile/bloc/profile_state.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {



  ProfileBloc profileBloc;
  Account user = new Account();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(UserFetchData());
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc,ProfileState>(
      listener: (context, state){
        if(state is LoadingState){
          Center(
            child: CircularProgressIndicator(),
          );
        }


      },
      child: BlocBuilder<ProfileBloc,ProfileState>(
        builder: (context, state){

          if(state is FailedFetchData){
            return Center(
              child: Text('gerg'),
            );
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Profile',
              style: BaseStyle.ts18WhiteBold,),
              iconTheme: IconThemeData(
                color: Colors.white
              ),
              backgroundColor: Colors.deepOrangeAccent,
            ),
            endDrawer: Drawer(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                      child: state is SuccessFetchData
                        ? Text(state.dataUser.account.name,
                      style: BaseStyle.ts14PrimaryBold,)
                        : Text('')
                    ),
                    Divider(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      child: GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.settings),
                            SizedBox(
                              width: 20,
                            ),
                            Text('Edit')
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => LoginPage()), (route)=> false);
                      },
                      child:  Container(
                        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.exit_to_app),
                            SizedBox(
                              width: 20,
                            ),
                            Text('Logout')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),


            body: Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CachedNetworkImage(
                        imageUrl: 'https://vignette.wikia.nocookie.net/kiminonawa/images/6/62/Kimi-no-Na-wa.-Visual.jpg/revision/latest/scale-to-width-down/340?cb=20160927170951',
                        imageBuilder: (context, imageProvider) => Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Id',
                          style: BaseStyle.ts14PrimaryLabel,),
                        Container(
                            width: 160,
                            child: state is SuccessFetchData
                                ? Text(state.dataUser.account.id.toString(),
                              style: BaseStyle.ts14PrimaryName,)
                                : Text('-')
                        )
                      ],
                    ),
                    Divider(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Username',
                        style: BaseStyle.ts14PrimaryLabel,),
                        Container(
                          width: 160,
                          child: state is SuccessFetchData
                              ? Text(state.dataUser.account.username,
                          style: BaseStyle.ts14PrimaryName,)
                              : Text('-')
                        )
                      ],
                    ),
                    Divider(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Name',
                        style: BaseStyle.ts14PrimaryLabel,),
                        Container(
                          width: 160,
                          child: state is SuccessFetchData
                              ? Text(state.dataUser.account.name,
                          style: BaseStyle.ts14PrimaryName,)
                              : Text('-')
                        )
                      ],
                    ),
                    Divider(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Gopay',
                        style: BaseStyle.ts14PrimaryLabel,),
                        Container(
                          width: 160,
                          child: state is SuccessFetchData
                              ? Text(state.dataUser.account.gopay,
                          style: BaseStyle.ts14PrimaryName,)
                              : Text('-')
                        )
                      ],
                    ),
                    Divider(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('OVO',
                        style: BaseStyle.ts14PrimaryLabel,),
                        Container(
                          width: 160,
                          child: state is SuccessFetchData
                              ? Text(state.dataUser.account.ovo,
                            style: BaseStyle.ts14PrimaryName,)
                              : Text('-'),
                        )

                      ],
                    ),
                    Divider(),
                  ],

                ),

              )

            )

          );

        },
      ),
    );


  }
}
