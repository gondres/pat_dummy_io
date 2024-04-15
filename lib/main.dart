import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pat_example_project/base/base_url.dart';
import 'package:pat_example_project/pages/tags/tags_screen.dart';
import 'package:pat_example_project/pages/users/user_screen.dart';
import 'package:pat_example_project/pages/main/main_screen.dart';
import 'package:pat_example_project/utils/app_cubit.dart';
import 'package:pat_example_project/utils/register_getIt.dart';
import 'package:pat_example_project/utils/register_service.dart';

void main() {
  final appCubit = AppCubit();
  runApp(appCubit.initCubit(MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appCubit = AppCubit();

  @override
  void initState() {
    registerAppServices();
    super.initState();
  }

  Future<void> registerAppServices() async {
    final registerDio = RegisterGetIt();
    registerDio.InitDI();
    final registerServices = RegisterService(GetIt.I.get<Dio>());
    await registerServices.registerAppServices(base_url);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
