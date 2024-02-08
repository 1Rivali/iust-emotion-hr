import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/cubit/auth/auth_cubit.dart';
import 'package:front/screens/admin/calls_view.dart';
import 'package:front/screens/admin/companies_view.dart';
import 'package:front/screens/admin/jobs_view.dart';
import 'package:front/screens/admin/payments_view.dart';
import 'package:front/screens/admin/users_view.dart';
import 'package:front/utils/content_views.dart';
import 'package:front/widgets/jh_appbar.dart';

class AdminLayout extends HookWidget {
  AdminLayout({super.key});

  final List<ContentView> contentViews = [
    ContentView(
      tab: const Tab(
        child: Text('Users'),
      ),
      content: const AdminUsersView(),
    ),
    ContentView(
      tab: const Tab(
        child: Text('Jobs'),
      ),
      content: const AdminJobsView(),
    ),
    ContentView(
      tab: const Tab(
        child: Text('Companies'),
      ),
      content: const AdminCompaniesView(),
    ),
    ContentView(
      tab: const Tab(
        child: Text('Calls'),
      ),
      content: const AdminCallsView(),
    ),
    ContentView(
      tab: const Tab(
        child: Text('Payments'),
      ),
      content: const AdminPaymentsView(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final TabController tabController = useTabController(
      initialLength: 5,
      initialIndex: 0,
    );

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        bool isAdmin = context.read<AuthCubit>().isAdmin();
        if (!isAdmin || state is AuthLoggedOut) {
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      },
      child: Scaffold(
        appBar: JHAppBar(
            tabController: tabController,
            tabs: contentViews.map((e) => e.tab).toList()),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: contentViews.map((e) => e.content).toList(),
        ),
      ),
    );
  }
}
