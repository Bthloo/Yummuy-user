class SaleModel{
  static const collectionName = 'DiscountCodes';
  String? code;
  num? discount;
  int? quantity;
  SaleModel({
    required this.code,
    required this.discount,
    required this.quantity,
  });
  factory SaleModel.fromJson(Map<String, dynamic>? json) {
    return SaleModel(
      code: json?['code'],
      discount: json?['discount'],
      quantity: json?['quantity'],
    );
  }
  Map<String, dynamic> toFireStore() {
    return {
      'code': code,
      'discount': discount,
      'quantity': quantity,
    };
  }
}