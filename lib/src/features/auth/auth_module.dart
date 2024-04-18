import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/features/auth/cubit/auth_cubit.dart';
import 'package:todo_list_clean_architecture/src/features/auth/sign_in/sign_in_page.dart';
import 'package:todo_list_clean_architecture/src/features/auth/sign_up/sign_up_page.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service_impl.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthService>((i) => AuthServiceImpl()),
        Bind.singleton((i) => AuthCubit(authService: i.get()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const SignInPage(),
          transition: TransitionType.fadeIn,
        ),
        ChildRoute(
          '/signup/',
          child: (context, args) => const SignUpPage(),
          transition: TransitionType.rightToLeftWithFade,
        ),
      ];
}
