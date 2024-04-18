part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final User? user;

  HomeLoadedState({required this.user});
}

final class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}
