import 'package:ummuy2/core/data_base/models/cart_model.dart';

class CartAmdinModel{
static const String collectionName = 'CartAdmin';
String? id;
  List<CartModel>? cartModelList;
  List<String>? pizzaMaker;
  num? totalPrice;
  String? userName;
  String? userPhone;
  String? userAddress;
  String? userEmail;
  String userId;
  String? time;
  String? status;
  bool? isCodeUsed;
  String? discountCode;
  CartAmdinModel({
    this.id,
    required this.cartModelList,
    required this.totalPrice,
    required this.userAddress,
    required this.userName,
    required this.userPhone,
    required this.time,
    required this.userEmail,
    required this.status,
    required this.userId,
    this.isCodeUsed,
    this.discountCode,
     this.pizzaMaker
   });

  Map<String,dynamic> toFireStore(){
    return {
      'cartModelList':cartModelList?.map((e) => e.toFireStore()).toList(),
      'totalPrice':totalPrice,
      'id' : id,
      'userName' : userName,
      'userPhone' : userPhone,
      'userAddress' : userAddress,
      'userEmail' : userEmail,
      'status' : status,
      'userId' : userId,
      'time':time,
      'isCodeUsed':isCodeUsed,
      'discountCode':discountCode,
      'pizzaMaker':pizzaMaker
    };
  }

  CartAmdinModel.fromFireStore(Map<String,dynamic>?data):
        this(
          cartModelList: (data?['cartModelList'] as List).map((e) => CartModel.fromJson(e)).toList(),
          totalPrice: data?['totalPrice'],
          userName: data?['userName'],
          userAddress: data?['userAddress'],
          userPhone: data?['userPhone'],
          id: data?['id'],
          status: data?['status'],
          userEmail: data?['userEmail'],
          userId: data?['userId'],
          isCodeUsed: data?['isCodeUsed'],
          discountCode: data?['discountCode'],
          time: data?['time'],
          pizzaMaker: data?['pizzaMaker']
        );

}