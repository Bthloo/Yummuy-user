class SeatModel{
  static const collectionName = 'Seats';
  String? seatName;
  bool? isReserved;
  String? reservedName;

  SeatModel({
   required this.seatName,
    required this.isReserved,
    required this.reservedName
  });

  factory SeatModel.fromJson(Map<String, dynamic>? json){
    return SeatModel(
      seatName: json?['seatName'],
      isReserved: json?['isReserved'],
      reservedName: json?['reservedName']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'seatName': seatName,
      'isReserved': isReserved,
      'reservedName': reservedName
    };
  }

}