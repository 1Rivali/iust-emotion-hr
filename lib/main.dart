import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/auth/auth_cubit.dart';
import 'package:front/cubit/calls/calls_cubit.dart';
import 'package:front/cubit/companies/company_cubit.dart';
import 'package:front/cubit/jobs/jobs_cubit.dart';
import 'package:front/cubit/payments/payment_cubit.dart';
import 'package:front/cubit/users/users_cubit.dart';
import 'package:front/screens/admin/admin_layout.dart';
import 'package:front/utils/app_theme.dart';
import 'package:front/utils/cache_helper.dart';
import 'package:front/utils/dio_helper.dart';

import 'screens/user/user_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => JobsCubit(),
        ),
        BlocProvider(
          create: (context) => UsersCubit(),
        ),
        BlocProvider(
          create: (context) => CompanyCubit(),
        ),
        BlocProvider(
          create: (context) => CallsCubit(),
        ),
        BlocProvider(
          create: (context) => PaymentCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        routes: {
          "/": (context) => const UserLayout(),
          "/admin": (context) => AdminLayout(),
        },
      ),
    );
  }
}
