import 'package:flutter/material.dart';
import 'package:pat_example_project/pages/tags/tags_screen.dart';
import 'package:pat_example_project/pages/users/user_screen.dart';
import 'package:pat_example_project/pages/likes/likes_screen.dart';
import 'package:pat_example_project/pages/post_users/post_user_screen.dart';
import 'package:pat_example_project/pages/widgets/loader_shimmer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    PostUserScreen(),
    LikesScreen(),
    UserScreen(),
  ];

  late final TabController _tabController = TabController(length: _widgetOptions.length, vsync: this, initialIndex: 0)
    ..addListener(() {
      _selectedIndex = _tabController.index;
      setState(() {});
    });

  void _onItemTapped(int index) {
    _tabController.index = index;
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dummy.Io'),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: _widgetOptions,
        controller: _tabController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'People',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
