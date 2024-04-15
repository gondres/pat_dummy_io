import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_example_project/cubit/db_cubit/db_cubit.dart';
import 'package:pat_example_project/cubit/post/post_cubit.dart';
import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:pat_example_project/database/model/likes_mapper.dart';
import 'package:pat_example_project/database/model/likes_model.dart';
import 'package:pat_example_project/pages/widgets/card_post.dart';
import 'package:pat_example_project/pages/widgets/loader_shimmer.dart';

class PostUserScreen extends StatefulWidget {
  const PostUserScreen({super.key});

  @override
  State<PostUserScreen> createState() => _PostUserScreenState();
}

class _PostUserScreenState extends State<PostUserScreen> with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  int page = 0;
  bool allLoaded = false;
  late PostCubit postCubit;
  late DBCubit dbCubit;
  List<LikesModel> listPost = [];
  int dataSize = 0;
  bool showTag = false;
  String tag = '';

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
    setState(() {
      showTag = false;
      page = 0;
      listPost.clear();
    });
    postCubit.getListPost(page);
  }

  void getTagList(String title) {
    setState(() {
      showTag = true;
      page = 0;
      tag = title;
      listPost.clear();
    });
    postCubit.getTagListPost(title, page);
  }

  void insertLikes(Data data) {
    dbCubit.insertLikes(data);
  }

  Future<void> scrollListener() async {
    int tempIndex = 0;
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        if (listPost.length < dataSize) {
          page = page++;
          setState(() {
            tempIndex++;
          });

          postCubit.getListPost(tempIndex);
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
    return Scaffold(
        appBar: showTag
            ? AppBar(title: Text('#${tag.toUpperCase()}'), actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    getList();
                  },
                )
              ])
            : null,
        body: RefreshIndicator(
          onRefresh: () async {
            getList();
          },
          child: BlocBuilder<PostCubit, PostState>(builder: (context, state) {
            if (state is PostLoading) {
              if (listPost.isEmpty) {
                return LoaderShimmer();
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
          }),
        ));
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
            tagList: getTagList,
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
