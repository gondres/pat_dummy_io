import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_example_project/cubit/db_cubit/db_cubit.dart';
import 'package:pat_example_project/cubit/post/post_cubit.dart';
import 'package:pat_example_project/cubit/users/user_cubit.dart';

class AppCubit {
  Widget initCubit(Widget widget) {
    return MultiBlocProvider(providers: [
      BlocProvider<PostCubit>(create: (BuildContext context) => PostCubit()),
      BlocProvider<DBCubit>(create: (BuildContext context) => DBCubit()),
      BlocProvider<UserCubit>(create: (BuildContext context) => UserCubit()),
    ], child: widget);
  }
}
