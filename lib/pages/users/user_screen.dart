import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_example_project/cubit/users/user_cubit.dart';
import 'package:pat_example_project/data/model/responses/list_user_response.dart';
import 'package:pat_example_project/pages/widgets/card_user.dart';
import 'package:pat_example_project/pages/widgets/loader_shimmer.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with AutomaticKeepAliveClientMixin {
  late UserCubit userCubit;
  int page = 0;
  List<Data> listUser = [];
  int dataSize = 0;
  bool allLoaded = false;
  final scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    userCubit = context.read<UserCubit>();
    getListUser();
    scrollListener();
    super.initState();
  }

  void getListUser() {
    setState(() {
      page = 0;
      listUser.clear();
    });
    userCubit.getListUser(page);
  }

  Future<void> scrollListener() async {
    int tempIndex = 0;
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        if (listUser.length <= dataSize) {
          setState(() {
            page = page++;
            tempIndex++;
          });

          userCubit.getListUser(tempIndex);
        } else {
          allLoaded = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        getListUser();
      },
      child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserLoading) {
          if (listUser.isEmpty) {
            return LoaderShimmerUser();
          }
        }
        if (state is UserSuccess) {
          final response = state.response;
          dataSize = state.response.total ?? 0;
          response.data?.forEach((element) {
            listUser.add(element);
          });

          return listPostWidget();
        }

        if (state is UserFailure) {
          return Center(
            child: Text('Error'),
          );
        }

        return listPostWidget();
      }),
    ));
  }

  Widget listPostWidget() {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: listUser.length + 1,
      itemBuilder: (builder, index) {
        if (index < listUser.length) {
          return CardUser(data: listUser[index]);
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
