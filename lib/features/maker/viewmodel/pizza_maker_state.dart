part of 'pizza_maker_cubit.dart';

@immutable
sealed class PizzaMakerState {}

final class PizzaMakerInitial extends PizzaMakerState {}
final class PizzaMakerLoading extends PizzaMakerState {}
final class PizzaMakerError extends PizzaMakerState {
  final String message;
  PizzaMakerError(this.message);
}
final class PizzaMakerLoaded extends PizzaMakerState {
  final PizzaMakerModel pizzaMakerModel;
  PizzaMakerLoaded(this.pizzaMakerModel);
}
