import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomePageChangedState(index: 0));

  void changePage(int index) {
    emit(HomePageChangedState(index: index));
  }

  void pageTapped(int index) => changePage(index);
}
