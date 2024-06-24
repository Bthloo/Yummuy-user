part of 'get_meals_cubit.dart';

sealed class GetMealsState {}

final class GetMealsInitial extends GetMealsState {}

final class GetMealsLoading extends GetMealsState {}

final class GetMealsSuccess extends GetMealsState {
  final List<QueryDocumentSnapshot<MealModel>> data;
  GetMealsSuccess(this.data);
}

final class GetMealsFailure extends GetMealsState {
  final String? message;
  GetMealsFailure(this.message);
}
