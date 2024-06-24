import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data_base/models/categories_model.dart';
import '../../../../core/data_base/my_database.dart';

part 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  GetCategoriesCubit() : super(GetCategoriesInitial());
  static GetCategoriesCubit get(context) => BlocProvider.of(context);

  List<QueryDocumentSnapshot<CategoryModel>> categories = [];
  getCategories()async{
    categories = [];
    emit(GetCategoriesLoading());
    try{
     var data = await MyDataBase.getCategories();
     categories.addAll(data.docs);
     emit(GetCategoriesSuccess(categories));
    }on FirebaseException catch(e){
      emit(GetCategoriesFailure(e.toString()));
    }on TimeoutException catch(e){
      emit(GetCategoriesFailure(e.toString()));
    }
    catch(e){
      emit(GetCategoriesFailure(e.toString()));

    }
  }
}
