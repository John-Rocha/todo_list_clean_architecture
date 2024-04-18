import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/core/ui/base_state/base_state.dart';
import 'package:todo_list_clean_architecture/src/features/auth/cubit/auth_cubit.dart';
import 'package:todo_list_clean_architecture/src/features/home/cubit/home_cubit.dart';
import 'package:todo_list_clean_architecture/src/services/auth/auth_service.dart';
import 'package:todo_list_clean_architecture/src/shared/widgets/custom_button.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeCubit> {
  final authController = Modular.get<AuthCubit>();
  final authService = Modular.get<AuthService>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: controller,
      listener: (context, state) {
        if (state is HomeErrorState) {
          showError(state.message);
          hideLoader();
        }

        if (state is HomeLoadingState) {
          showLoader();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Text('Olá'),
                Visibility(
                  visible: authService.currentUser?.displayName != null &&
                      state is! HomeLoadingState,
                  replacement: Container(
                    width: 20,
                    height: 20,
                    padding: const EdgeInsets.only(left: 4),
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                  child: Text(' ${authService.currentUser?.displayName ?? ''}'),
                )
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showUpdateNameDialog(context);
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: authController.signOut,
              ),
            ],
          ),
          body: Center(
            child: Text('${authService.currentUser?.uid}'),
          ),
        );
      },
    );
  }

  Future<void> showUpdateNameDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        String newDisplayName = '';
        return AlertDialog(
          title: const Text('Atualiza o nome de exibição'),
          content: Form(
            key: formKey,
            child: TextFormField(
              onChanged: (value) {
                newDisplayName = value;
              },
              validator: Validatorless.multiple([
                Validatorless.required('Campo obrigatório'),
                Validatorless.min(3, 'Nome precisar mais de 3 caracteres'),
              ]),
              decoration: const InputDecoration(
                hintText: 'Digite o novo nome de exibição',
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Modular.to.pop();
              },
              child: const Text('Cancelar'),
            ),
            CustomButton(
              type: CustomButtonType.elevated,
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  controller.updateDisplayName(newDisplayName);
                  Modular.to.pop();
                }
              },
              child: const Text('Atualizar'),
            ),
          ],
        );
      },
    );
  }
}
