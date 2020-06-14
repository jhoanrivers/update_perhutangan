


import 'package:updateperutangan/src/page/piutang/bloc/piutang_event.dart';
import 'package:updateperutangan/src/page/piutang/bloc/piutang_state.dart';
import 'package:bloc/bloc.dart';


class PiutangBloc extends Bloc<PiutangEvent,PiutangState>{
  @override
  // TODO: implement initialState
  PiutangState get initialState => InitialState();

  @override
  Stream<PiutangState> mapEventToState(PiutangEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }


}