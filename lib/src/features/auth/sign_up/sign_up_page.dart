import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
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
  final _nameController = TextEditingController(text: 'Teste');
  final _emailController = TextEditingController(text: 'john@email.com');
  final _passwordController = TextEditingController(text: '123456');
  File? _image;

  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;

  void _pickImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(
      source: imageSource,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
    );
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _showPhotoSourceSelector(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Câmera'),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Galeria'),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: controller,
          listener: (context, state) {
            if (state is AuthErrorState) {
              showError(state.message);
            }
          },
          builder: (context, state) {
            return Form(
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
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: _image != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(_image!),
                                  )
                                : const Icon(Icons.person, size: 70),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              radius: 20,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _showPhotoSourceSelector(context);
                                },
                              ),
                            ),
                          ),
                        ],
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
                                    image: _image,
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
            );
          },
        ),
      ),
    );
  }
}
