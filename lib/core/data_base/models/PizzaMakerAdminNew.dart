/// toppings : ["cheese","pepperoni"]
/// crust : ["thin","thick"]
/// sauce : ["red","white"]
/// vegetables : ["mushrooms","onions","peppers"]
/// cheeses : ["mozzarella","cheddar"]

class PizzaMakerAdminNew {
  PizzaMakerAdminNew({
      this.toppings, 
      this.crust, 
      this.sauce, 
      this.vegetables, 
      this.cheeses,});

  PizzaMakerAdminNew.fromJson(dynamic json) {
    toppings = json['toppings'] != null ? json['toppings'].cast<String>() : [];
    crust = json['crust'] != null ? json['crust'].cast<String>() : [];
    sauce = json['sauce'] != null ? json['sauce'].cast<String>() : [];
    vegetables = json['vegetables'] != null ? json['vegetables'].cast<String>() : [];
    cheeses = json['cheeses'] != null ? json['cheeses'].cast<String>() : [];
  }
  List<String>? toppings;
  List<String>? crust;
  List<String>? sauce;
  List<String>? vegetables;
  List<String>? cheeses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['toppings'] = toppings;
    map['crust'] = crust;
    map['sauce'] = sauce;
    map['vegetables'] = vegetables;
    map['cheeses'] = cheeses;
    return map;
  }

}