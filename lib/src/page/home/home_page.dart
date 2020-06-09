

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:updateperutangan/src/page/detail/detail_page.dart';
import 'package:updateperutangan/src/page/request/request_page.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class HomePage extends StatefulWidget {
  const HomePage();


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Update Perhutangan'),
        centerTitle: true,

      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 30),
                          child: Row(
                            children: <Widget>[
                              CachedNetworkImage(
                                imageUrl: "https://i.pinimg.com/originals/bf/f4/4b/bff44b786d593a55c4033afe4eef7f84.jpg",
                                imageBuilder: (context, imageProvider) => Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: imageProvider
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Ferdiansyah Ali Nughroho',
                            style: BaseStyle.ts14PrimaryName,),
                            SizedBox(height: 6,),
                            Text('Apa isinya ini')
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Minus'),
                            SizedBox(
                              height: 6,
                            ),
                            Text('-10000',
                            style: BaseStyle.ts16RedBold,)
                          ],
                        ),
                        VerticalDivider(),
                        Column(
                          children: <Widget>[
                            Text('Plus'),
                            SizedBox(
                              height: 6,
                            ),
                            Text('+ 250000',
                            style: BaseStyle.ts16GreenBold,)
                          ],
                        ),
                      ],
                    )

                  ],
                ),
              )
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Text('Recently Transaction',
              style: BaseStyle.ts14PrimaryName,),
          ),


          Container(
            height: 80.0 * 4,
            child: ListView.builder(
              itemBuilder: (context, index){
                return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
                    },
                    child: Card(
                        margin: EdgeInsets.fromLTRB(16,6,16,0),
                        child: ListTile(
                          leading: CachedNetworkImage(
                            imageUrl: "https://i.pinimg.com/originals/bf/f4/4b/bff44b786d593a55c4033afe4eef7f84.jpg",
                            imageBuilder: (context, imageProvider) => Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: imageProvider
                                ),
                              ),
                            ),
                          ),
                          title: Text('Nama User'),
                          subtitle: Text('16/Juni/2020'),

                          trailing: Icon(Icons.call_made,
                          color: Colors.green,)
                        )

                    )
                );

              },
              itemCount: 4,
              controller: scrollController,
            ),
          ),
        ],
      )


    );
  }
}
