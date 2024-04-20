import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/core/ui/base_state/base_state.dart';
import 'package:todo_list_clean_architecture/src/features/auth/cubit/auth_cubit.dart';
import 'package:todo_list_clean_architecture/src/features/home/cubit/home_cubit.dart';
import 'package:todo_list_clean_architecture/src/features/home/pages/profile/profile_page.dart';
import 'package:todo_list_clean_architecture/src/features/home/pages/task/tasks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeCubit> {
  final authController = Modular.get<AuthCubit>();

  // Page Controls
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: controller,
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              TasksPage(),
              ProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: (state as HomePageChangedState).index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.task_outlined),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Perfil',
              ),
            ],
            onTap: (index) {
              _pageController.jumpToPage(index);
              controller.pageTapped(index);
            },
          ),
        );
      },
    );
  }
}
