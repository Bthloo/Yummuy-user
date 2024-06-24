class CartModel{
  String? id;
  String? name;
  String? image;
  double? price;
  String? size;
  String? status;
  int? quantity;
  String? pizzaMaker;

  CartModel({ this.id,this.status, this.name, this.image, this.price, this.quantity,this.size,this.pizzaMaker});

  CartModel.fromJson(Map<String,dynamic>? data):
        this(
    id : data?['id'],
    name : data?['name'],
    image : data?['image'],
    price : data?['price'],
    size : data?['size'],
    status : data?['status'],
    quantity : data?['quantity'],
    pizzaMaker : data?['pizzaMaker']
  );


  Map<String, dynamic> toFireStore(){
   return {
   'id' : id,
   'name' : name,
   'image' : image,
    'status' : status,
   'price' : price,
   'size' : size,
   'quantity' : quantity,
    'pizzaMaker' : pizzaMaker
  };
  }
}