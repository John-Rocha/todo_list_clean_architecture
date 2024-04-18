import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/core/ui/base_state/base_state.dart';
import 'package:todo_list_clean_architecture/src/features/auth/cubit/auth_cubit.dart';
import 'package:todo_list_clean_architecture/src/shared/widgets/custom_button.dart';
import 'package:todo_list_clean_architecture/src/shared/widgets/custom_text_form_field.dart';
import 'package:validatorless/validatorless.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends BaseState<SignUpPage, AuthCubit> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: controller,
      listener: (context, state) {
        if (state is AuthErrorState) {
          showError(state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cadastro',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _nameController,
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.min(3, 'Nome muito curto'),
                          ],
                        ),
                        label: 'Nome',
                        keyboardType: TextInputType.text,
                        borderRadius: 16,
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
                        obscureText: _isObscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscurePassword = !_isObscurePassword;
                            });
                          },
                        ),
                        borderRadius: 16,
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        validator: Validatorless.multiple(
                          [
                            Validatorless.required('Campo obrigatório'),
                            Validatorless.min(6, 'Senha muito curta'),
                            Validatorless.compare(
                              _passwordController,
                              'Senhas não são iguais',
                            ),
                          ],
                        ),
                        label: 'Confirme a senha',
                        obscureText: _isObscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscureConfirmPassword =
                                  !_isObscureConfirmPassword;
                            });
                          },
                        ),
                        borderRadius: 16,
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        width: double.infinity,
                        type: CustomButtonType.elevated,
                        onPressed: state is AuthLoadingState
                            ? null
                            : () {
                                final validForm =
                                    _formKey.currentState?.validate() ?? false;
                                if (validForm) {
                                  controller.signUp(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    name: _nameController.text,
                                  );
                                }
                              },
                        child: state is AuthLoadingState
                            ? const CircularProgressIndicator.adaptive()
                            : const Text('Cadastrar'),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        type: CustomButtonType.text,
                        onPressed: state is AuthLoadingState
                            ? null
                            : () {
                                Modular.to.pop();
                              },
                        child: const Text('Já tenho conta'),
                      ),
                    ],
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
