import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/features/auth/cubit/auth_cubit.dart';
import 'package:todo_list_clean_architecture/src/features/home/cubit/home_cubit.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.authService,
    required this.authController,
  });

  final AuthService authService;
  final AuthCubit authController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.onSecondaryContainer,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Olá',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    Visibility(
                      visible: authService.currentUser?.displayName != null &&
                          authController.state is! HomeLoadingState,
                      replacement: Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.only(left: 4),
                        child: const CircularProgressIndicator.adaptive(),
                      ),
                      child: Flexible(
                        child: Text(
                          ' ${authService.currentUser?.displayName ?? ''}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  authService.currentUser?.email ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.task_outlined),
            title: const Text('Tarefas'),
            onTap: () {
              Modular.to.pushNamed('/tasks');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Perfil'),
            onTap: () {
              Modular.to.pushNamed('/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Configurações'),
            onTap: () {
              Modular.to.pushNamed('/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Sair'),
            onTap: authController.signOut,
          ),
        ],
      ),
    );
  }
}
