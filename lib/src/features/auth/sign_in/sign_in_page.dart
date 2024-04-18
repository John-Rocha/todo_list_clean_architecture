import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/core/ui/base_state/base_state.dart';
import 'package:todo_list_clean_architecture/src/features/auth/cubit/auth_cubit.dart';
import 'package:todo_list_clean_architecture/src/shared/widgets/custom_button.dart';
import 'package:todo_list_clean_architecture/src/shared/widgets/custom_text_form_field.dart';
import 'package:validatorless/validatorless.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends BaseState<SignInPage, AuthCubit> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: controller,
      listener: (context, state) {
        if (state is AuthErrorState) {
          showError(state.message);
        }

        if (state is AuthLoadedState) {
          Modular.to.navigate('/home/');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                          dimension: 120,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Missão: Fazer Tudo',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.08,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: _emailController,
                          validator: Validatorless.multiple(
                            [
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.email('E-mail inválido'),
                            ],
                          ),
                          label: 'E-mail',
                          keyboardType: TextInputType.emailAddress,
                          borderRadius: 16,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFormField(
                          controller: _passwordController,
                          validator: Validatorless.multiple(
                            [
                              Validatorless.required('Campo obrigatório'),
                              Validatorless.min(6, 'Senha muito curta'),
                            ],
                          ),
                          label: 'Senha',
                          borderRadius: 16,
                          obscureText: _isObscure,
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => _isObscure = !_isObscure),
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: CustomButton(
                            type: CustomButtonType.elevated,
                            onPressed: state is AuthLoadingState
                                ? null
                                : () {
                                    final validForm =
                                        _formKey.currentState?.validate() ??
                                            false;
                                    if (validForm) {
                                      controller.signIn(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      );
                                    }
                                  },
                            child: state is AuthLoadingState
                                ? const CircularProgressIndicator.adaptive()
                                : const Text('Entrar'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          type: CustomButtonType.text,
                          onPressed: state is AuthLoadingState
                              ? null
                              : () {
                                  Modular.to.pushNamed('/auth/signup/');
                                },
                          child: const Text('Criar conta'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
