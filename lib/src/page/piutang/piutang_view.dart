

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';

class PiutangView extends StatefulWidget {

  const PiutangView();

  @override
  _PiutangViewState createState() => _PiutangViewState();
}

class _PiutangViewState extends State<PiutangView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Piutang',
        style: BaseStyle.ts18WhiteBold,),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        return GestureDetector(
          onTap: (){},
          child: Card(
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
              title: Text('Ini nama Usernya'),
              subtitle: Text('Rp. 120000',
              style: BaseStyle.ts14PrimaryName,),
              trailing: Container(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('26 Maret 2020'),
                    SizedBox(
                      height: 12,
                    ),
                    Text('120000',
                    style: BaseStyle.ts14PrimaryBold,)
                  ],
                ),
              ),




            ),
          ),
        );
      },
        itemCount: 10,



      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.add,
        color: Colors.white,),
        elevation: 4,
        tooltip: 'Add Piutang',
        backgroundColor: Colors.deepOrangeAccent,
      ),

    );
  }
}
