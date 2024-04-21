import 'package:firebase_analytics/firebase_analytics.dart';
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
  final _analytics = FirebaseAnalytics.instance;
  final PageController _pageController = PageController();

  List<Widget> pages = const [
    TasksPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _analytics.setAnalyticsCollectionEnabled(true);
  }

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
            onPageChanged: controller.pageTapped,
            children: pages,
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
            onTap: (index) async {
              _pageController.jumpToPage(index);
              controller.pageTapped(index);
              await _analytics.logEvent(
                name: 'page_tapped',
                parameters: {
                  'page_index': index,
                  'page_name': pages[index].runtimeType.toString(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
