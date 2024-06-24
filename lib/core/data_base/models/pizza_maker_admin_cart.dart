class PizzaMakerAdminModel {
  String? id;
  String? name;
  String? price;
  String? size;
  // Ingrads? crust;
  // Ingrads? toppings;
  // Ingrads? sauces;
  // Ingrads? cheeses;
  // Ingrads? vegetables;

  List<String>? crust;
  List<String>? toppings;
  List<String>? sauces;
  List<String>? cheeses;
  List<String>? vegetables;

  PizzaMakerAdminModel({
    this.id,
    this.name,
    this.price,
    this.size,
    this.crust,
    this.toppings,
    this.sauces,
    this.cheeses,
    this.vegetables,
  });

  PizzaMakerAdminModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    size = json['size'];
    crust = json['crust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['size'] = size;
    data['crust'] = crust;
    return data;
  }
}

class Ingrads{
  List<String>? ingrad;
  Ingrads({ this.ingrad});
}