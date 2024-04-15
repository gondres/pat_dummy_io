import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_example_project/cubit/db_cubit/db_cubit.dart';
import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:pat_example_project/database/model/likes_mapper.dart';
import 'package:pat_example_project/database/model/likes_model.dart';
import 'package:pat_example_project/pages/widgets/card_post.dart';

class LikesScreen extends StatefulWidget {
  const LikesScreen({super.key});

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final scrollController = ScrollController();
  List<LikesModel> listLikes = [];
  late DBCubit dbCubit;

  @override
  void initState() {
    dbCubit = context.read<DBCubit>();
    dbCubit.getListLikes();
    super.initState();
  }

  void deleteLikes(Data data) {
    dbCubit.deleteLike(data.id ?? '');
    listLikes.clear();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<DBCubit, DBState>(builder: (context, state) {
      if (state is DBLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is DBListSuccess) {
        final response = state.model;
        response.forEach((element) {
          listLikes.add(element);
        });

        if (response.isEmpty) {
          return Center(child: Text('Empty Favorite Post'));
        }
      }

      if (state is DBFailure) {
        return Center(child: Text('Failed'));
      }

      return listLikesWidget();
    }));
  }

  Widget listLikesWidget() {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: listLikes.length,
      itemBuilder: (builder, index) {
        return CardPost(
          data: listLikes[index],
          insertLikes: deleteLikes,
        );
      },
    );
  }
}
