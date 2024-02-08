import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/auth/auth_cubit.dart';

import 'package:front/utils/cache_helper.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:front/widgets/jh_login_dialog.dart';
import 'package:gap/gap.dart';

class JHAppBar extends HookWidget implements PreferredSizeWidget {
  const JHAppBar({
    super.key,
    required this.tabController,
    required this.tabs,
  });
  final TabController tabController;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    String? name;
    bool isLoggedIn = context.watch<AuthCubit>().isLoggedIn();
    bool isAdmin = context.watch<AuthCubit>().isAdmin();

    useEffect(() {
      if (isLoggedIn) {
        name = CacheHelper.getData(key: "name");
      }
      return;
    }, [isLoggedIn]);
    return Container(
      color: surfaceColor,
      padding:
          EdgeInsets.symmetric(horizontal: screenSize(context).width * 0.08),
      child: AppBar(
        // TODO:: Implement App Logo

        title: Row(
          children: [
            Text(
              "Job Harbor",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSize(context).width * 0.04),
                child: TabBar(
                  controller: tabController,
                  tabs: tabs,
                  onTap: (value) => tabController.animateTo(value),
                ),
              ),
            ),
          ],
        ),

        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Row(
                children: [
                  if (isLoggedIn)
                    JHButton(
                      child: const Text("Logout"),
                      onPressed: () async =>
                          await context.read<AuthCubit>().logout(),
                    ),
                  const Gap(10),
                  if (isLoggedIn && !isAdmin)
                    Text(
                      "Hello $name",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: primaryColor),
                    ),
                  if (!isLoggedIn)
                    JHButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => const LoginDialog(),
                      ),
                      child: Text(
                        'Login / Register',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
