part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class CartLoading extends CartState {}
final class CartSuccess extends CartState {
  final List<CartModel> cartItems;
  CartSuccess(this.cartItems);
}
final class CartError extends CartState {
  final String message;
  CartError(this.message);
}
