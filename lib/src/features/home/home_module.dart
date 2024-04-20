import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/features/auth/auth_module.dart';
import 'package:todo_list_clean_architecture/src/features/home/cubit/home_cubit.dart';
import 'package:todo_list_clean_architecture/src/features/home/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [Bind.lazySingleton((i) => HomeCubit())];

  @override
  List<Module> get imports => [AuthModule()];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const HomePage(),
        ),
      ];
}
