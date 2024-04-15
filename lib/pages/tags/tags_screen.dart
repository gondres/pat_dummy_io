import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_example_project/cubit/db_cubit/db_cubit.dart';
import 'package:pat_example_project/cubit/post/post_cubit.dart';
import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:pat_example_project/database/model/likes_mapper.dart';
import 'package:pat_example_project/database/model/likes_model.dart';
import 'package:pat_example_project/pages/widgets/card_post.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key, required this.title});

  final String title;

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  int page = 0;
  bool allLoaded = false;
  late PostCubit postCubit;
  late DBCubit dbCubit;
  // List<Data> listPost = [];
  List<LikesModel> listPost = [];
  int dataSize = 0;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    postCubit = context.read<PostCubit>();
    dbCubit = context.read<DBCubit>();
    getList();
    scrollListener();
    super.initState();
  }

  void getList() {
    postCubit.getTagListPost(widget.title, page);
  }

  void insertLikes(Data data) {
    dbCubit.insertLikes(data);
  }

  Future<void> scrollListener() async {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        if (listPost.length < dataSize) {
          page = page++;
          postCubit.getListPost(page);
        } else {
          allLoaded = true;
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<PostCubit, PostState>(builder: (context, state) {
      if (state is PostLoading) {
        if (listPost.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
      }
      if (state is PostSuccess) {
        final res = state.response.data;
        dataSize = state.response.total ?? 0;
        res?.forEach((element) {
          listPost.add(likesMapperFromResponse(data: element));
        });

        return listPostWidget();
      }

      if (state is PostFailure) {
        return Text('Failed');
      }
      return listPostWidget();
    }));
  }

  Widget listPostWidget() {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: listPost.length + 1,
      itemBuilder: (builder, index) {
        if (index < listPost.length) {
          return CardPost(
            data: listPost[index],
            insertLikes: insertLikes,
          );
        } else {
          return allLoaded
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
        }
      },
    );
  }
}
