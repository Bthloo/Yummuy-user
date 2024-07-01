import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ummuy2/core/data_base/my_database.dart';

import '../../../core/data_base/models/PizzaMakerModel.dart';

part 'pizza_maker_state.dart';

class PizzaMakerCubit extends Cubit<PizzaMakerState> {
  PizzaMakerCubit() : super(PizzaMakerInitial());
  PizzaMakerModel pizzaMakerItem = PizzaMakerModel(
    cheeses: [],
    crusts: [],
    sauces: [],
    toppings: [],
    vegetables: [],
  );
  List<bool> isToppingSelected = [];
  List<bool> isCheeseSelected = [];
  List<bool> isSauceSelected = [];
  List<bool> isVegetablesSelected = [];
  List<bool> isCrustSelected = [];
  static PizzaMakerCubit get(BuildContext context) => BlocProvider.of(context);
  getPizzaMaker()async{
    pizzaMakerItem = PizzaMakerModel(
      cheeses: [],
      crusts: [],
      sauces: [],
      toppings: [],
      vegetables: [],
    );
    emit(PizzaMakerLoading());
    try{
    var pizzaMakerJson = await MyDataBase.getPizzaMakerJson();
    String response = await pizzaMakerJson["JsonFile"];
    debugPrint('Response $response');
     // final String response = await rootBundle.loadString('lib/core/json/maker.json');
      final data = await json.decode(response);
      PizzaMakerModel pizzaMakerModel = PizzaMakerModel.fromJson(data);
      isToppingSelected = List.generate(pizzaMakerModel.toppings!.length, (index) => false);
      isCheeseSelected = List.generate(pizzaMakerModel.cheeses!.length, (index) => false);
      isSauceSelected = List.generate(pizzaMakerModel.sauces!.length, (index) => false);
      isVegetablesSelected = List.generate(pizzaMakerModel.vegetables!.length, (index) => false);
      isCrustSelected = List.generate(pizzaMakerModel.crusts!.length, (index) => false);
      emit(PizzaMakerLoaded(pizzaMakerModel));
    }catch(e){
      emit(PizzaMakerError(e.toString()));
    }
  }
}
