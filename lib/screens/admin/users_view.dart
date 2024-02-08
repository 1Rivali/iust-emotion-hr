import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/jobs/jobs_cubit.dart';
import 'package:front/cubit/users/users_cubit.dart';
import 'package:front/models/user_model.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:front/widgets/jh_section_title.dart';
import 'package:front/widgets/jh_table.dart';
import 'package:front/widgets/jh_table_actions.dart';
import 'package:gap/gap.dart';

class AdminUsersView extends HookWidget {
  const AdminUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    useEffect(() {
      context.read<UsersCubit>().getUsers();
      return null;
    }, const []);
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize(context).height * 0.05,
        left: screenSize(context).width * 0.02,
        right: screenSize(context).width * 0.02,
      ),
      child: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          List<UserModel>? users = context.watch<UsersCubit>().usersList;
          if (state is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          if (users != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const JHSectionTitle(
                    title: "Users List",
                  ),
                  const Gap(40),
                  JHTable(
                    columns: const [
                      DataColumn(
                          label: Text(
                        "#",
                      )),
                      DataColumn(
                          label: Text(
                        "Name",
                      )),
                      DataColumn(
                          label: Text(
                        "Email",
                      )),
                      DataColumn(
                          label: Text(
                        "isAdmin",
                      )),
                      DataColumn(
                          label: Text(
                        "Actions",
                      )),
                    ],
                    rows: [
                      for (int i = 0; i < users.length; i++)
                        DataRow(
                          selected: true,
                          cells: [
                            DataCell(
                              Text('${i + 1}'),
                            ),
                            DataCell(
                              Text('${users[i].name}'),
                            ),
                            DataCell(
                              Text('${users[i].email}'),
                            ),
                            DataCell(
                              Text('${users[i].isAdmin}'),
                            ),
                            DataCell(
                              JHTableActions(
                                onDelete: state is UsersDeleteLoading
                                    ? null
                                    : () {
                                        context
                                            .read<UsersCubit>()
                                            .deleteUser(users[i].id!);
                                      },
                                canEdit: false,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              "No Users Yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        },
      ),
    );
  }
}
