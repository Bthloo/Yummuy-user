import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data_base/models/meal_model.dart';
import '../../../../core/data_base/my_database.dart';
part 'get_meals_state.dart';

class GetMealsCubit extends Cubit<GetMealsState> {
  GetMealsCubit() : super(GetMealsInitial());
  static GetMealsCubit get(context) => BlocProvider.of(context);

  List<QueryDocumentSnapshot<MealModel>> list = [];
  getMeals(String argument)async{
    emit(GetMealsLoading());
    try{
      list = [];
      QuerySnapshot<MealModel> data = await MyDataBase.getMealCollection(argument).get();
      list.addAll(data.docs);
      emit(GetMealsSuccess(list));
    }on FirebaseException catch(e){
      emit(GetMealsFailure(e.message));
    }catch(e){
      emit(GetMealsFailure(e.toString()));
    }


  }
}
