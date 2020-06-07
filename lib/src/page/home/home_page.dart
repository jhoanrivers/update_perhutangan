

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:updateperutangan/src/page/detail/detail_page.dart';
import 'package:updateperutangan/src/page/request/request_page.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scrollController = ScrollController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
              },
              child: Card(
                  margin: EdgeInsets.fromLTRB(10,6,10,0),
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
                    subtitle: Text('Keterangan lain '),
                    trailing: RaisedButton(
                      color: Colors.green,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => RequestPage()
                        ));
                      },
                      child: Text('New Request',
                      style: BaseStyle.ts14White,),
                    ),
                  )

              )
            );



          },
        itemCount: 5,
        controller: scrollController,
      ),
    );
  }
}
