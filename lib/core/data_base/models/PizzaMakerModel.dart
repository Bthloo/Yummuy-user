/// Toppings : [{"name":"Pepperoni","price":40},{"name":"Beef","price":50},{"Name":"Sausage","Price":50},{"name":"Bacon","price":50},{"name":"Chicken","price":50},{"name":"Anchovies","price":50},{"name":"Salami","price":50},{"name":"Meatballs","price":50}]
/// Sizes : [{"name":"Small","price":10},{"name":"Medium","price":15},{"name":"Large","price":20}]
/// Crusts : [{"name":"Thin","price":10},{"name":"Thick","price":15},{"name":"Stuffed","price":20}]
/// Sauces : [{"name":"Tomato","price":10},{"name":"Pesto","price":15},{"name":"Alfredo","price":20},{"name":"BBQ","price":20},{"name":"Buffalo","price":20},{"name":"Garlic","price":10},{"name":"Ranch","price":20}]
/// Cheeses : [{"name":"Mozzarella","price":10},{"name":"Cheddar","price":15},{"name":"Feta","price":20},{"name":"Parmesan","price":20},{"name":"Provolone","price":20},{"name":"Swiss","price":20}]
/// Vegetables : [{"name":"Onions","price":10},{"name":"Green Peppers","price":10},{"name":"Black Olives","price":10},{"name":"Green Olives","price":10},{"name":"Jalapenos","price":10},{"name":"Pineapple","price":10},{"name":"Spinach","price":10},{"name":"Tomatoes","price":10},{"name":"Banana Peppers","price":10},{"name":"Mushrooms","price":10}]

class PizzaMakerModel {
  PizzaMakerModel({
      this.toppings, 
      this.sizes, 
      this.crusts, 
      this.sauces, 
      this.cheeses, 
      this.vegetables,});
  PizzaMakerModel.fromJson(dynamic json) {
    if (json['Toppings'] != null) {
      toppings = [];
      json['Toppings'].forEach((v) {
        toppings?.add(Toppings.fromJson(v));
      });
    }
    if (json['Sizes'] != null) {
      sizes = [];
      json['Sizes'].forEach((v) {
        sizes?.add(Sizes.fromJson(v));
      });
    }
    if (json['Crusts'] != null) {
      crusts = [];
      json['Crusts'].forEach((v) {
        crusts?.add(Crusts.fromJson(v));
      });
    }
    if (json['Sauces'] != null) {
      sauces = [];
      json['Sauces'].forEach((v) {
        sauces?.add(Sauces.fromJson(v));
      });
    }
    if (json['Cheeses'] != null) {
      cheeses = [];
      json['Cheeses'].forEach((v) {
        cheeses?.add(Cheeses.fromJson(v));
      });
    }
    if (json['Vegetables'] != null) {
      vegetables = [];
      json['Vegetables'].forEach((v) {
        vegetables?.add(Vegetables.fromJson(v));
      });
    }
  }
  List<Toppings>? toppings;
  List<Sizes>? sizes;
  List<Crusts>? crusts;
  List<Sauces>? sauces;
  List<Cheeses>? cheeses;
  List<Vegetables>? vegetables;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (toppings != null) {
      map['Toppings'] = toppings?.map((v) => v.toJson()).toList();
    }
    if (sizes != null) {
      map['Sizes'] = sizes?.map((v) => v.toJson()).toList();
    }
    if (crusts != null) {
      map['Crusts'] = crusts?.map((v) => v.toJson()).toList();
    }
    if (sauces != null) {
      map['Sauces'] = sauces?.map((v) => v.toJson()).toList();
    }
    if (cheeses != null) {
      map['Cheeses'] = cheeses?.map((v) => v.toJson()).toList();
    }
    if (vegetables != null) {
      map['Vegetables'] = vegetables?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Onions"
/// price : 10

class Vegetables {
  Vegetables({
      this.name, 
      this.price,});

  Vegetables.fromJson(dynamic json) {
    name = json['name'];
    price = json['price'];
  }
  String? name;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    return map;
  }

}

/// name : "Mozzarella"
/// price : 10

class Cheeses {
  Cheeses({
      this.name, 
      this.price,});

  Cheeses.fromJson(dynamic json) {
    name = json['name'];
    price = json['price'];
  }
  String? name;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    return map;
  }

}

/// name : "Tomato"
/// price : 10

class Sauces {
  Sauces({
      this.name, 
      this.price,});

  Sauces.fromJson(dynamic json) {
    name = json['name'];
    price = json['price'];
  }
  String? name;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    return map;
  }

}

/// name : "Thin"
/// price : 10

class Crusts {
  Crusts({
      this.name, 
      this.price,});

  Crusts.fromJson(dynamic json) {
    name = json['name'];
    price = json['price'];
  }
  String? name;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    return map;
  }

}

/// name : "Small"
/// price : 10

class Sizes {
  Sizes({
      this.name, 
      this.price,});

  Sizes.fromJson(dynamic json) {
    name = json['name'];
    price = json['price'];
  }
  String? name;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    return map;
  }

}

/// name : "Pepperoni"
/// price : 40

class Toppings {
  Toppings({
      this.name, 
      this.price,});

  Toppings.fromJson(dynamic json) {
    name = json['name'];
    price = json['price'];
  }
  String? name;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    return map;
  }

}