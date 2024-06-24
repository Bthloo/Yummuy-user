import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data_base/models/meal_model.dart';
import '../../../../core/data_base/my_database.dart';
part 'meal_screen_state.dart';

class MealScreenCubit extends Cubit<MealScreenState> {
  MealScreenCubit() : super(MealScreenInitial());
  static MealScreenCubit get(context) => BlocProvider.of(context);

  List<QueryDocumentSnapshot<IngredientsModel>> ingredientsList = [];
  getMeals({required String categoryId,required String mealId})async{
    emit(MealScreenLoading());
    ingredientsList = [];
    try{

      QuerySnapshot<IngredientsModel> data = await MyDataBase.getIngredientsCollection(categoryId: categoryId, mealId: mealId).get();
      ingredientsList.addAll(data.docs);
      emit(MealScreenSuccess(ingredientsList));
    }on FirebaseException catch(e){
      emit(MealScreenFailed(e.message??"Error"));
    }catch(e){
      emit(MealScreenFailed(e.toString()));
    }


  }
}
