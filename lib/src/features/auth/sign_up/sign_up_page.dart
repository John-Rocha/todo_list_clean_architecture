import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list_clean_architecture/src/shared/widgets/custom_text_form_field.dart';
import 'package:validatorless/validatorless.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
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
                          'Senhas não iguais',
                        ),
                      ],
                    ),
                    label: 'Confirme a senha',
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _isObscure,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    borderRadius: 16,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        Modular.to.pushReplacementNamed('/home');
                      },
                      child: const Text('Cadastrar'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
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
  }
}
