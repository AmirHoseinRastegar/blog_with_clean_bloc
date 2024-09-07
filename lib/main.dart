import 'package:blog/core/theme/app_theme.dart';
import 'package:blog/features/auth/presentation/pages/login_page.dart';
import 'package:blog/features/blog/presentation/blocs/blog_bloc.dart';
import 'package:blog/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/cubits/user_session_cubit/user_seission_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/blog/presentation/pages/blog_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => locator<UserSeissionCubit>(),
        ), BlocProvider(
          create: (_) => locator<BlogBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(IsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      home: BlocSelector<UserSeissionCubit, UserSeissionState, bool>(
        selector: (state) {
          return state is UserIsloggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const BlogPage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
