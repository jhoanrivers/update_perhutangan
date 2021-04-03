

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja/bloc/belanja_bloc.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja/bloc/belanja_event.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja/bloc/belanja_state.dart';
import 'package:updateperutangan/src/page/belanja_directory/belanja_create_new/belanja_create_new_page.dart';
import 'package:updateperutangan/src/utils/basestyle.dart';
import 'package:updateperutangan/src/utils/constant.dart';

class BelanjaView extends StatefulWidget {
  @override
  _BelanjaViewState createState() => _BelanjaViewState();
}

class _BelanjaViewState extends State<BelanjaView> {

  BelanjaBloc belanjaBloc;






  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    belanjaBloc = Provider.of<BelanjaBloc>(context, listen: false);
    belanjaBloc.add(GetListBelanja(start: 0,finish: 10));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Text(
          Constant.belanja,
          style: BaseStyle.ts16Black,
        ),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: BlocListener<BelanjaBloc, BelanjaState>(
        listener: (context, state) {

        },
        child: BlocBuilder<BelanjaBloc, BelanjaState>(
          builder: (context, state) {

            if(state is LoadingBelanja){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SuccessFetchDataBelanja){
              return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          print("hehe");
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 16),
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(90),
                                      color: Colors.green
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(state.purchase.belanjaItem[index].id.toString(),
                                    style: BaseStyle.ts14White,
                                    textAlign: TextAlign.center,),
                                ),
                                Expanded(
                                    child: Column(
                                      children: [
                                        Text(state.purchase.belanjaItem[index].title,
                                          style: BaseStyle.ts14PrimaryBold,
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(state.purchase.account[index].name)
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    )
                                ),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(state.purchase.belanjaItem[index].date)
                                      ],
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: state.purchase.belanjaItem.length,
                  )
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );

          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => BelanjaCreateNewPage()));
        },
        child: Icon(Icons.add,),
      ),
    );


  }
}
