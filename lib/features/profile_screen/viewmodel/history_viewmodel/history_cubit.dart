import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ummuy2/features/auth/Login/ViewModel/login_cubit.dart';

import '../../../../core/data_base/models/admin_cart_model.dart';
import '../../../../core/data_base/my_database.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
  List<QueryDocumentSnapshot<CartAmdinModel>> history = [];
  getData()async{
    history = [];
    emit(HistoryLoading());
    try {
      QuerySnapshot<CartAmdinModel> data = await MyDataBase.getHistory(id:LoginCubit.currentUser.id! );
      history.addAll(data.docs);
      emit(HistorySuccess(history));
    }on TimeoutException catch (ex) {
      emit(HistoryError('$ex'));
    }catch (ex) {
      emit(HistoryError('Something Went Wrong \n $ex'));
    }
  }
}
