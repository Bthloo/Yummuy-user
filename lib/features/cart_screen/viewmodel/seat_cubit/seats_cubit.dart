import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/data_base/models/seat_model.dart';
import '../../../../core/data_base/my_database.dart';

part 'seats_state.dart';

class SeatsCubit extends Cubit<SeatsState> {
  SeatsCubit() : super(SeatsInitial());
  static SeatsCubit get(context) => BlocProvider.of(context);
  List<SeatModel> seats = [];
  SeatModel? selectedSeat;
  getSeats()async{
    seats = [];
    selectedSeat = null;
    emit(SeatsLoading());
    try{
      var getCollection = await MyDataBase.getSeatsCollection();
      var seatsFire = await getCollection.get();
      seatsFire.docs.forEach((element) {
        if(element.data().isReserved == false){
          seats.add(element.data());
        }
      });
      emit(SeatsSuccess(seats));
    }catch(e){
      emit(SeatsFailed(e.toString()));
    }
  }
}
