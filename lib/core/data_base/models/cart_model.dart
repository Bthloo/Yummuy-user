
class TotalCart{
  //List<CartModel>? cartModelList;
  double? totalPrice;
  double? priceAfterDiscount;
  String? discountCode;
  bool? isCodeUsed;
  num? discountRate;
  TotalCart({
    this.isCodeUsed,
    this.discountCode,
    this.discountRate,
    this.priceAfterDiscount,
    // this.cartModelList,
     this.totalPrice,
  });

  TotalCart.fromFireStore(Map<String,dynamic>?data):
        this(
          //cartModelList: (data?['cartModelList'] as List).map((e) => CartModel.fromJson(e)).toList(),
          totalPrice: data?['totalPrice'],
          priceAfterDiscount: data?['priceAfterDiscount'],
          discountCode: data?['discountCode'],
          isCodeUsed: data?['isCodeUsed'],
          discountRate: data?['discountRate']
      );


  Map<String,dynamic> toFireStore(){
    return {
      //'cartModelList':cartModelList?.map((e) => e.toFireStore()).toList(),
      'totalPrice':totalPrice,
      'priceAfterDiscount':priceAfterDiscount,
      'discountCode':discountCode,
      'isCodeUsed':isCodeUsed,
      'discountRate':discountRate
    };
  }


}


class CartModel{
  String? id;
  String? name;
  String? image;
  double? price;
  String? size;
  String? status;
  int? quantity;
  String? pizzaMaker;
  bool? isCodeUsed;
  String? discountCode;

  CartModel({ this.isCodeUsed,this.discountCode,
    this.id,this.status, this.name, this.image, this.price, this.quantity,this.size,this.pizzaMaker});

  CartModel.fromJson(Map<String,dynamic>? data):
        this(
    id : data?['id'],
    name : data?['name'],
    image : data?['image'],
    price : data?['price'],
    size : data?['size'],
    status : data?['status'],
    quantity : data?['quantity'],
    isCodeUsed : data?['isCodeUsed'],
    discountCode : data?['discountCode'],
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
    'isCodeUsed' : isCodeUsed,
    'discountCode' : discountCode,
   'quantity' : quantity,
    'pizzaMaker' : pizzaMaker
  };
  }
}