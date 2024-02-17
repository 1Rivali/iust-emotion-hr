import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/auth/auth_cubit.dart';
import 'package:front/cubit/calls/confrence_cubit.dart';
import 'package:front/cubit/calls/join_call_cubit.dart';
import 'package:front/screens/video_call_screen.dart';

import 'package:front/utils/cache_helper.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/utils/twilio_service.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:front/widgets/dialogs/jh_login_dialog.dart';
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
    final formKey = GlobalKey<FormState>();
    String? name;
    bool isLoggedIn = context.watch<AuthCubit>().isLoggedIn();
    bool isAdmin = context.watch<AuthCubit>().isAdmin();
    final TextEditingController callUrlController = useTextEditingController();
    String? userEmail;
    String? userId;

    useEffect(() {
      if (isLoggedIn) {
        name = CacheHelper.getData(key: "name");
        userEmail = CacheHelper.getData(key: "userEmail");
        userId = CacheHelper.getData(key: "userID");
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
                    JHButton(
                      child: const Text("Interview"),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Center(
                              child: Text(
                            "Attend Interview",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                          content: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize(context).width * 0.015,
                                vertical: screenSize(context).height * 0.03),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Call URL",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const Gap(10),
                                  TextFormField(
                                    controller: callUrlController,
                                    validator: (val) => val!.isNotEmpty
                                        ? null
                                        : "The Call URL field is required",
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: primaryColor.withOpacity(0.05),
                                      hintText: "URL",
                                    ),
                                  ),
                                  const Gap(20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: BlocProvider(
                                      create: (context) => RoomCubit(
                                          backendService:
                                              TwilioFunctionsService.instance),
                                      child: BlocConsumer<RoomCubit, RoomState>(
                                        listener: (context, state) async {
                                          print(state);
                                          if (state is RoomLoaded) {
                                            Navigator.pop(context);
                                            await Navigator.of(context).push(
                                              MaterialPageRoute<ConferencePage>(
                                                  fullscreenDialog: true,
                                                  builder: (BuildContext
                                                          context) =>
                                                      BlocProvider(
                                                        create: (BuildContext
                                                                context) =>
                                                            ConferenceCubit(
                                                          identity:
                                                              state.identity,
                                                          token: state.token,
                                                          name:
                                                              callUrlController
                                                                  .text,
                                                        ),
                                                        child: ConferencePage(),
                                                      )),
                                            );
                                          }
                                        },
                                        builder: (context, state) {
                                          return state is RoomLoading
                                              ? const LinearProgressIndicator(
                                                  color: primaryColor,
                                                )
                                              : JHButton(
                                                  onPressed: () {
                                                    context
                                                        .read<RoomCubit>()
                                                        .submit(
                                                            userId.toString());
                                                  },
                                                  child: const Text("Submit"),
                                                );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
