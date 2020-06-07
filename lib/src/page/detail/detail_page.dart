

import 'package:flutter/material.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Hutang Nama'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.black26,
            padding: EdgeInsets.all(20),
            child: Text('Rp -20000',
            style: BaseStyle.ts18WhiteBold,),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Nama',
                      style: BaseStyle.ts12PrimaryLabel,),
                      SizedBox(
                        height: 6,
                      ),
                      Text('Panjang Umur Selamanya',
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
                      Text('Detail Hutang',
                        style: BaseStyle.ts12PrimaryLabel,),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          itemBuilder: (context, index){
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Ini nama listnya'),
                                  Text('20000')
                                ],
                              ),
                            );
                          },
                          itemCount: 5,
                          physics: NeverScrollableScrollPhysics(),


                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('OVO',
                        style: BaseStyle.ts12PrimaryLabel,),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('0812456324124'),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.content_copy),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Whatsapp',
                        style: BaseStyle.ts12PrimaryLabel,),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('0812456324124'),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.content_copy),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Gopay',
                        style: BaseStyle.ts12PrimaryLabel,),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('0812456324124'),
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.content_copy),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
