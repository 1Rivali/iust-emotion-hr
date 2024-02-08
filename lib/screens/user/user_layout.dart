import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/screens/user/home_view.dart';
import 'package:front/screens/user/jobs_view.dart';
import 'package:front/utils/content_views.dart';
import 'package:front/widgets/jh_appbar.dart';

class UserLayout extends HookWidget {
  const UserLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final TabController tabController = useTabController(
      initialLength: 2,
      initialIndex: 0,
    );
    final List<ContentView> contentViews = [
      ContentView(
        tab: const Tab(
          child: Text('Home'),
        ),
        content: HomeView(
          tabController: tabController,
        ),
      ),
      ContentView(
        tab: const Tab(
          child: Text('Jobs'),
        ),
        content: JobsView(
          tabController: tabController,
        ),
      ),
    ];

    return Scaffold(
      appBar: JHAppBar(
        tabController: tabController,
        tabs: contentViews.map((e) => e.tab).toList(),
      ),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: contentViews.map((e) => e.content).toList()),
    );
  }
}
