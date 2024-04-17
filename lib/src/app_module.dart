import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/features/auth/auth_module.dart';
import 'package:todo_list_clean_architecture/src/features/home/home_module.dart';
import 'package:todo_list_clean_architecture/src/features/splash/splash_page.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service_impl.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    super.binds(i);
    i.addLazySingleton(AuthServiceImpl.new);
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(
      '/',
      child: (context) => const SplashPage(),
    );
    r.module('/auth', module: AuthModule());
    r.module('/home', module: HomeModule());
  }
}
