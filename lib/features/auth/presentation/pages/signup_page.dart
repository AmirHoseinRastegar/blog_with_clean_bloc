import 'package:blog/core/constants/loader.dart';
import 'package:blog/core/utils/snakbar.dart';
import 'package:blog/core/widgets/custom_app_bar.dart';
import 'package:blog/features/auth/presentation/pages/login_page.dart';
import 'package:blog/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/text_field.dart';

class SignupPage extends StatefulWidget {
  static rout() => MaterialPageRoute(builder: (context) => const LoginPage());

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                return snakBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const AppLoader();
              }

              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        hintText: 'Name',
                        controller: _nameController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hintText: 'Email',
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hintText: 'Password',
                        controller: _passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        title: 'Sign Up',
                        onCallBack: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(SignUpEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                name: _nameController.text.trim()));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, SignupPage.rout());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account?  ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: AppPallete.gradient2,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
