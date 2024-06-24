
class User{// data class
  static const String collectionName = 'users';
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;

  User({this.id,this.name,this.email,this.phoneNumber,this.address});

  User.fromFireStore(Map<String,dynamic>? data):
        this(id: data?['id'],
          name: data?['name'],
          address: data?['address'],
          phoneNumber: data?['phoneNumber'],
          email: data?['email']);

  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'name':name,
      'address':address,
      'email':email,
      'phoneNumber':phoneNumber
    };
  }
}