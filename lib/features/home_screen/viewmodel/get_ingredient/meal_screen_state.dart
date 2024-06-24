part of 'meal_screen_cubit.dart';

sealed class MealScreenState {}

final class MealScreenInitial extends MealScreenState {}
final class MealScreenLoading extends MealScreenState {}
final class MealScreenSuccess extends MealScreenState {
  final List<QueryDocumentSnapshot<IngredientsModel>> ingredients;
  MealScreenSuccess(this.ingredients);
}
final class MealScreenFailed extends MealScreenState{
  final String message;
  MealScreenFailed(this.message);
}
