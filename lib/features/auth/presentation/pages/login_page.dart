import 'package:blog/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog/features/auth/presentation/pages/signup_page.dart';
import 'package:blog/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/loader.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/snakbar.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  static rout() => MaterialPageRoute(builder: (context) => const SignupPage());

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
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
                  title: 'Sign In',
                  onCallBack: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(
                        LoginEvent(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim()),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      LoginPage.rout(),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account?  ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'Sign Up',
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
          );
  },
),
        ),
      ),
    );
  }
}
