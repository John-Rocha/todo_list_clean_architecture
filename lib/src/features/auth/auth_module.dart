import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/features/auth/sign_in/sign_in_page.dart';
import 'package:todo_list_clean_architecture/src/features/auth/sign_up/sign_up_page.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(
      Modular.initialRoute,
      child: (_) => const SignInPage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/signup/',
      child: (_) => const SignUpPage(),
      transition: TransitionType.fadeIn,
    );
  }
}
