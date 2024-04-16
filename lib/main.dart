import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/firebase_options.dart';
import 'package:todo_list_clean_architecture/src/app_module.dart';
import 'package:todo_list_clean_architecture/src/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
