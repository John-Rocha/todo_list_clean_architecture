import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/features/home/home_page.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child(
      Modular.initialRoute,
      child: (context) => const HomePage(),
      transition: TransitionType.fadeIn,
    );
  }
}
