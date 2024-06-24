
import 'meal_model.dart';

class CategoryModel{// data class
  static const String collectionName = 'categories';
  String? id;
  String? name;
  String? url;
  List<MealModel>? meals;

  CategoryModel({this.id,this.name,this.url,this.meals});

  CategoryModel.fromFireStore(Map<String,dynamic>? data):
        this(id: data?['id'],
          name: data?['name'],
        url: data?['url'],
        meals: data?['meals'],
         );

  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'name':name,
      'url':url,
      'meals':meals
    };
  }
}