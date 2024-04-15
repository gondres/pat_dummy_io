import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_example_project/cubit/db_cubit/db_cubit.dart';
import 'package:pat_example_project/cubit/post/post_cubit.dart';
import 'package:pat_example_project/cubit/users/user_cubit.dart';
import 'package:pat_example_project/data/model/responses/list_post_response.dart';
import 'package:pat_example_project/database/model/likes_mapper.dart';
import 'package:pat_example_project/database/model/likes_model.dart';
import 'package:pat_example_project/pages/widgets/card_post.dart';
import 'package:pat_example_project/pages/widgets/loader_shimmer.dart';

class DetailFeedScreen extends StatefulWidget {
  const DetailFeedScreen({super.key, required this.id});
  final String id;

  @override
  State<DetailFeedScreen> createState() => _DetailFeedScreenState();
}

class _DetailFeedScreenState extends State<DetailFeedScreen> with AutomaticKeepAliveClientMixin {
  final scrollController = ScrollController();
  int page = 0;
  bool allLoaded = false;
  late UserCubit userCubit;
  late DBCubit dbCubit;
  List<LikesModel> listPost = [];
  int dataSize = 0;
  bool showTag = false;
  String tag = '';

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    userCubit = context.read<UserCubit>();
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
    userCubit.getUserFeeds(widget.id, page);
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
          userCubit.getUserFeeds(widget.id, tempIndex);
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

  Future<void> _onBackPressed() async {
    Navigator.pop(context, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (true) {
          _onBackPressed();
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('User Feed'),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              getList();
            },
            child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
              if (state is UserLoading) {
                if (listPost.isEmpty) {
                  return LoaderShimmer();
                }
              }
              if (state is UserFeedSuccess) {
                final res = state.response.data;
                dataSize = state.response.total ?? 0;
                res?.forEach((element) {
                  listPost.add(likesMapperFromResponse(data: element));
                });

                return listPostWidget();
              }

              if (state is UserFailure) {
                return Text('Failed');
              }
              return listPostWidget();
            }),
          )),
    );
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
            tagList: null,
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
