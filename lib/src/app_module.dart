import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/features/splash/splash_page.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(
      '/',
      child: (context) => const SplashPage(),
    );
  }
}
