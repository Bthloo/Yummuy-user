part of 'seats_cubit.dart';

@immutable
sealed class SeatsState {}

final class SeatsInitial extends SeatsState {}
final class SeatsLoading extends SeatsState {}
final class SeatsSuccess extends SeatsState {
  final List<SeatModel> seats;
  SeatsSuccess(this.seats);
}
final class SeatsFailed extends SeatsState {
  final String message;
  SeatsFailed(this.message);
}
