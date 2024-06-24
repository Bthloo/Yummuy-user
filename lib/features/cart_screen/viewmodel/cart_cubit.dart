import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ummuy2/core/data_base/models/cart_model.dart';
import 'package:ummuy2/core/data_base/my_database.dart';
import 'package:ummuy2/features/auth/Login/ViewModel/login_cubit.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(BuildContext context) => BlocProvider.of(context);
  List<CartModel> cartList = [];
  double totalPrice = 0;
  getCart() async {
    emit(CartLoading());
    totalPrice = 0;
    cartList = [];
    try {
      QuerySnapshot<CartModel> cart = await MyDataBase.getCart(id: LoginCubit.currentUser.id);
      for (var element in cart.docs) {
        cartList.add(element.data());
        totalPrice += element.data().price!;
      }

      emit(CartSuccess(cartList));
    } on Exception catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
