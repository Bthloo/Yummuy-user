class MealModel {
  static const String collectionName = 'meal';
  String? id;
  String? name;
  String? description;
  String? price;
  String? imageUrl;
  List<IngredientsModel>? ingredients;

  MealModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.imageUrl,
      this.ingredients});

  MealModel.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data?['id'],
            name: data?['name'],
            price: data?['price'],
            imageUrl: data?['imageUrl'],
            description: data?['description']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price
    };
  }
}

class IngredientsModel {
  static const String collectionName = 'ingredients';

  String? title;
  String? number;
  IngredientsModel({this.number, this.title});

  IngredientsModel.fromFireStore(Map<String, dynamic>? data)
      : this(title: data?['title'], number: data?['number']);

  Map<String, dynamic> toFireStore() {
    return {'title': title, 'number': number};
  }
}
