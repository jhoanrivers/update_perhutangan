

import 'package:flutter/material.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hutang Namanya',
        style: BaseStyle.tsAppBar,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20,16,16,16),
            width: double.infinity,
            color: Colors.black26,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                Text('Rp. 150.000',
                  style: BaseStyle.ts18WhiteBold,),
                SizedBox(
                  width: 10,
                ),
                Text('- 180000',
                  style: BaseStyle.ts14Red,)
              ],
            )


          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Nama Anggota',
                      style: BaseStyle.ts12PrimaryLabel,),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Jhoan River S',
                      style: BaseStyle.ts14PrimaryName,)
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Detail',
                        style: BaseStyle.ts12PrimaryLabel,),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 230,
                        child: ListView.builder(
                            itemBuilder: (context, index){
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Nama Detail list - x',),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text('16/juni/2020')
                                      ],
                                    ),
                                    Text('20.000')
                                  ],
                                )
                              );
                            },
                          itemCount: 4,
                          physics: NeverScrollableScrollPhysics(),

                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
                  color: Colors.greenAccent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Jumlah',
                        style: BaseStyle.ts14PrimaryBold,),
                      Text('180000',
                        style: BaseStyle.ts14PrimaryBold,)
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 120,
                        child: RaisedButton(
                          onPressed: (){},
                          child: Text('Decline',
                          style: BaseStyle.ts14White,),
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      SizedBox(
                        width: 120,
                        child:  RaisedButton(
                          onPressed: (){},
                          child: Text('Accept',
                            style: BaseStyle.ts14White,
                          ),
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                        )
                      )
                    ],
                  ),
                )















              ],
            ),
          )

        ],
      )
    );

  }
}
