import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/features/auth/auth_module.dart';
import 'package:todo_list_clean_architecture/src/features/home/home_module.dart';
import 'package:todo_list_clean_architecture/src/features/splash/splash_page.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service_impl.dart';
import 'package:todo_list_clean_architecture/src/services/database/user_database.dart';
import 'package:todo_list_clean_architecture/src/services/database/user_database_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<UserDatabase>((i) => UserDatabaseImpl()),
        Bind.lazySingleton<AuthService>(
            (i) => AuthServiceImpl(userDatabase: i.get())),
      ];

  @override
  List<Module> get imports => [
        AuthModule(),
        HomeModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SplashPage(),
        ),
        ModuleRoute('/auth', module: AuthModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
