import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/calls/calls_cubit.dart';
import 'package:front/cubit/calls/confrence_cubit.dart';
import 'package:front/cubit/calls/join_call_cubit.dart';
import 'package:front/cubit/companies/company_cubit.dart';
import 'package:front/cubit/emotion/emotion_cubit.dart';
import 'package:front/cubit/users/users_cubit.dart';
import 'package:front/models/company_model.dart';
import 'package:front/models/user_model.dart';
import 'package:front/screens/video_call_screen.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/utils/twilio_service.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:gap/gap.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class JHCreateCallDialog extends HookWidget {
  const JHCreateCallDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController companyIdController =
        useTextEditingController();
    final TextEditingController userIdController = useTextEditingController();
    int? companyId;
    int? userId;
    useEffect(
      () {
        context.read<CompanyCubit>().getCompanies();
        context.read<UsersCubit>().getUsers();
        return null;
      },
      const [],
    );
    return AlertDialog(
      title: Center(
        child: Text(
          "Create Company",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize(context).width * 0.015,
            vertical: screenSize(context).height * 0.03),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Company",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              BlocBuilder<CompanyCubit, CompanyState>(
                builder: (context, state) {
                  List<CompanyModel>? companies =
                      context.watch<CompanyCubit>().companiesList;
                  if (state is CompanyLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                  if (companies != null) {
                    return DropdownMenu(
                        hintText: "Select a Company",
                        controller: companyIdController,
                        onSelected: (value) {
                          companyId = value!;
                        },
                        inputDecorationTheme: InputDecorationTheme(
                          filled: true,
                          fillColor: primaryColor.withOpacity(0.05),
                        ),
                        dropdownMenuEntries: [
                          for (int i = 0; i < companies.length; i++)
                            DropdownMenuEntry(
                                value: companies[i].id,
                                label: companies[i].name!),
                        ]);
                  }
                  return const Text("No Data");
                },
              ),
              Text(
                "User",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(10),
              BlocBuilder<UsersCubit, UsersState>(
                builder: (context, state) {
                  List<UserModel>? users =
                      context.watch<UsersCubit>().usersList;
                  if (state is UsersLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                  if (users != null) {
                    return DropdownMenu(
                      hintText: "Select a User",
                      controller: userIdController,
                      onSelected: (value) {
                        userId = value!;
                      },
                      inputDecorationTheme: InputDecorationTheme(
                        filled: true,
                        fillColor: primaryColor.withOpacity(0.05),
                      ),
                      dropdownMenuEntries: [
                        for (int i = 0; i < users.length; i++)
                          DropdownMenuEntry(
                              value: users[i].id, label: users[i].email!),
                      ],
                    );
                  }
                  return const Text("No Data");
                },
              ),
              const Gap(30),
              SizedBox(
                width: double.infinity,
                child: BlocProvider(
                  create: (context) => RoomCubit(
                      backendService: TwilioFunctionsService.instance),
                  child: BlocConsumer<RoomCubit, RoomState>(
                    listener: (context, state) async {
                      print(state);
                      if (state is RoomLoaded) {
                        log(context.read<CallsCubit>().createdCallUrl!);
                        Navigator.pop(context);
                        await Navigator.of(context).push(
                          MaterialPageRoute<ConferencePage>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => BlocProvider(
                                    create: (BuildContext context) =>
                                        ConferenceCubit(
                                      identity: state.identity,
                                      token: state.token,
                                      name: context
                                          .read<CallsCubit>()
                                          .createdCallUrl!,
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
                                if (formKey.currentState!.validate()) {
                                  context.read<CallsCubit>().createCall(
                                      companyId: companyId!, userId: userId!);
                                  context
                                      .read<RoomCubit>()
                                      .submit(companyId.toString());
                                }
                              },
                              child: const Text("Submit"),
                            );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
