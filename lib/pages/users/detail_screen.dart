import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_example_project/cubit/users/user_cubit.dart';
import 'package:pat_example_project/pages/users/detail_feed_screen.dart';
import 'package:pat_example_project/utils/date.formatter.dart';
import 'package:pat_example_project/utils/string_ext.dart';

class DetailUserScreen extends StatefulWidget {
  DetailUserScreen({super.key, required this.id});
  String id;

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  late UserCubit userCubit;

  @override
  void initState() {
    userCubit = context.read<UserCubit>();
    _getDetailUser(widget.id);
    super.initState();
  }

  void _getDetailUser(String id) {
    userCubit.getDetailUser(id);
  }

  void _navigateToFeedUser() {
    final navigate = Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailFeedScreen(
                id: widget.id,
              )),
    ).then((value) => _getDetailUser(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail User'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.library_books,
                color: Colors.black,
              ),
              onPressed: () => _navigateToFeedUser(),
            )
          ],
        ),
        body: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
          if (state is UserLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserDetailSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipOval(child: Image.network('${state.response.picture}')),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildUserState('Country ', '${state.response.location?.country}'),
                          _buildUserState('City ', '${state.response.location?.city}'),
                          _buildUserState('State ', '${state.response.location?.state}'),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildDescription('Title', '${(state.response.title)?.toTitleCase()}'),
                  _buildDescription('Full Name', '${state.response.firstName} ${state.response.lastName}'),
                  _buildDescription('Gender', '${(state.response.gender)?.toTitleCase()}'),
                  _buildDescription('DOB', '${DateFormatter.formatterDate(state.response.dateOfBirth ?? '')}'),
                  _buildDescription('Phone', '${state.response.phone}'),
                ],
              ),
            );
          }

          if (state is UserFailure) {
            return Center(
              child: Text('Failed'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }));
  }

  Widget _buildUserState(String title, String desc) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        Text(
          desc,
          style: TextStyle(fontWeight: FontWeight.w700),
        )
      ],
    );
  }

  Widget _buildDescription(String title, String desc) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            Text(
              desc,
              style: TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
