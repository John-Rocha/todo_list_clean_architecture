part of 'home_cubit.dart';

sealed class HomeState {}

final class HomePageChangedState extends HomeState {
  final int index;

  HomePageChangedState({required this.index});
}
