

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_bloc.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_event.dart';
import 'package:updateperutangan/src/page/hutang/bloc/hutang_state.dart';


class HutangView extends StatefulWidget {
  @override
  _HutangViewState createState() => _HutangViewState();
}

class _HutangViewState extends State<HutangView> {


  HutangBloc hutangBloc;


  @override
  void initState() {
    super.initState();

    hutangBloc = BlocProvider.of<HutangBloc>(context);
    hutangBloc.add(FetchAllHutang());

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<HutangBloc,HutangState>(
        listener: (context, state){

        },
        child: BlocBuilder<HutangBloc, HutangState>(
          builder: (context, state){
            if(state is LoadingState){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if(state is LoadedState){
              if(state.listHutang.length == 0){
                return Center(
                  child: Text('No Hutang'),
                );
              }

              return ListView.builder(
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){},
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                          child: Text(state.listHutang[index].loan.item),
                        ),
                      ),

                    );

                  },
                  itemCount: state.listHutang.length,

              );


            }


            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
