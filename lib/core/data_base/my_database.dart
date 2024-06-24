import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummuy2/core/data_base/models/admin_cart_model.dart';
import 'package:ummuy2/core/data_base/models/cart_model.dart';
import 'package:ummuy2/core/data_base/models/meal_model.dart';
import 'models/categories_model.dart';
import 'models/user.dart';

class MyDataBase{

  static CollectionReference<CartAmdinModel> getCartAdminCollection(){
    return FirebaseFirestore.instance.collection(CartAmdinModel.collectionName)
        .withConverter<CartAmdinModel>(
      fromFirestore: (snapshot, options) => CartAmdinModel.fromFireStore(snapshot.data()),
      toFirestore: (cartAmdinModel, options) => cartAmdinModel.toFireStore(),
    );
  }
  static Future<void> addCartAmdin(
      {required CartAmdinModel cartAmdinModel,required String uId}){
    var collection = getCartAdminCollection();
    var userCollection = getUsersCollection();
   // cartAmdinModel.id = collection.doc().id;
    cartAmdinModel.id = collection.doc().id;
    userCollection.doc(cartAmdinModel.userId).collection('History')
        .withConverter<CartAmdinModel>(
      fromFirestore: (snapshot, options) => CartAmdinModel.fromFireStore(snapshot.data()),
      toFirestore: (cart, options) => cart.toFireStore(),
    ).doc(cartAmdinModel.id).set(cartAmdinModel);
    return collection.doc(cartAmdinModel.id).set(cartAmdinModel);
  }


  static Future<void> addCartAmdinToHistory(CartAmdinModel cartAmdinModel){
    var collection = getCartAdminCollection();


    return collection.doc(cartAmdinModel.id).set(cartAmdinModel);
  }




  static CollectionReference<User> getUsersCollection(){
    return FirebaseFirestore.instance.collection(User.collectionName)
        .withConverter<User>(
      fromFirestore: (snapshot, options) => User.fromFireStore(snapshot.data()),
      toFirestore: (user, options) => user.toFireStore(),
    );
  }

  static Future<void> addUser(User user){
    var collection = getUsersCollection();
    return collection.doc(user.id).set(user);
  }
  static Future<User?> readUser(String id)async{
    var collection = getUsersCollection();
    var docSnapshot = await collection.doc(id).get();
    return docSnapshot.data();
  }

  static Future<void> updateUser(User user){
    var collection = getUsersCollection();
    return collection.doc(user.id).update(user.toFireStore());
  }


  static CollectionReference<CategoryModel> getCategoryCollection(){
    return FirebaseFirestore.instance.collection(CategoryModel.collectionName)
        .withConverter<CategoryModel>(
      fromFirestore: (snapshot, options) => CategoryModel.fromFireStore(snapshot.data()),
      toFirestore: (category, options) => category.toFireStore(),
    );
  }

  static Future<QuerySnapshot<CategoryModel>>getCategories(){
    return getCategoryCollection()
        .get();
  }




  static CollectionReference<MealModel> getMealCollection(String? categoryId){
    var categoryCollection = getCategoryCollection();
    return categoryCollection.doc(categoryId).collection(MealModel.collectionName)
        .withConverter<MealModel>(
      fromFirestore: (snapshot, options) => MealModel.fromFireStore(snapshot.data()),
      toFirestore: (meal, options) => meal.toFireStore(),
    );
  }



  static CollectionReference<IngredientsModel> getIngredientsCollection(
      {required String? categoryId,required String? mealId}){
    var mealCollection = getMealCollection(categoryId);
    return mealCollection.doc(mealId).collection(IngredientsModel.collectionName)
        .withConverter<IngredientsModel>(
      fromFirestore: (snapshot, options) => IngredientsModel.fromFireStore(snapshot.data()),
      toFirestore: (meal, options) => meal.toFireStore(),
    );
  }

  static Future<void> addToHistory({required CartAmdinModel cartAdminModel,required String? id}){
    var collection = getUsersCollection();
    return collection.doc(id).collection('History')
        .withConverter<CartAmdinModel>(
      fromFirestore: (snapshot, options) => CartAmdinModel.fromFireStore(snapshot.data()),
      toFirestore: (cart, options) => cart.toFireStore(),
    ).doc(cartAdminModel.id).set(cartAdminModel);
  }

  static Future<QuerySnapshot<CartAmdinModel>> getHistory({required String? id}){
    var collection = getUsersCollection();
    var historyCollection = collection.doc(id).collection('History')
        .withConverter<CartAmdinModel>(
      fromFirestore: (snapshot, options) => CartAmdinModel.fromFireStore(snapshot.data()),
      toFirestore: (cart, options) => cart.toFireStore(),
    ).get();
    return historyCollection;
  }


  static Future<void> updateHistory({required CartAmdinModel? cartAdminModel,required String? id}){
    var collection = getUsersCollection();
    return collection.doc(id).collection('History')
        .withConverter<CartAmdinModel>(
      fromFirestore: (snapshot, options) => CartAmdinModel.fromFireStore(snapshot.data()),
      toFirestore: (cart, options) => cart.toFireStore(),
    ).doc(cartAdminModel!.id).update(cartAdminModel.toFireStore());
  }





  static Future<void> addToCart({required CartModel cartModel,required String? id}){
    var collection = getUsersCollection();
    cartModel.id = collection.doc().id;
   return collection.doc(id).collection('Cart')
        .withConverter<CartModel>(
      fromFirestore: (snapshot, options) => CartModel.fromJson(snapshot.data()),
      toFirestore: (cart, options) => cart.toFireStore(),
    ).doc(cartModel.id).set(cartModel);
  }

  static Future<void> updateCart({required CartModel? cartModel,required String? id}){
    var collection = getUsersCollection();
    return collection.doc(id).collection('Cart')
        .withConverter<CartModel>(
      fromFirestore: (snapshot, options) => CartModel.fromJson(snapshot.data()),
      toFirestore: (cart, options) => cart.toFireStore(),
    ).doc(cartModel!.id).update(cartModel.toFireStore());
  }
  static Future<void> deleteCart({required CartModel? cartModel,required String? id,String? tripId}){
    var collection = getUsersCollection();
    return collection.doc(id).collection('Cart')
        .withConverter<CartModel>(
      fromFirestore: (snapshot, options) => CartModel.fromJson(snapshot.data()),
      toFirestore: (cart, options) => cart.toFireStore(),
    ).doc(cartModel?.id).delete();
  }


  static Future<QuerySnapshot<CartModel>> getCart({required String? id}){
    var collection = getUsersCollection();

    var cartCollection = collection.doc(id).collection('Cart').withConverter<CartModel>(
      fromFirestore: (snapshot, options) => CartModel.fromJson(snapshot.data()),
      toFirestore: (cart, options) => cart.toFireStore(),
    ).get();


    return cartCollection;

  }
}