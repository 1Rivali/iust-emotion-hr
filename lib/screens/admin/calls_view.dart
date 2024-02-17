import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/calls/calls_cubit.dart';
import 'package:front/models/call_model.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/dialogs/jh_create_call_dialog.dart';
import 'package:front/widgets/dialogs/jh_edit_call_dialog.dart';
import 'package:front/widgets/jh_button.dart';
import 'package:front/widgets/jh_section_title.dart';
import 'package:front/widgets/jh_table.dart';
import 'package:front/widgets/jh_table_actions.dart';
import 'package:gap/gap.dart';

class AdminCallsView extends HookWidget {
  const AdminCallsView({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<CallsCubit>().getCalls();
      return null;
    }, const []);
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize(context).height * 0.05,
        left: screenSize(context).width * 0.02,
        right: screenSize(context).width * 0.02,
      ),
      child: BlocBuilder<CallsCubit, CallsState>(
        builder: (context, state) {
          List<CallModel>? calls = context.watch<CallsCubit>().callsList;
          if (state is CallsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          if (calls != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const JHSectionTitle(
                        title: "Calls List",
                      ),
                      JHButton(
                          child: const Icon(Icons.add),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => const JHCreateCallDialog());
                          })
                    ],
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
                        "Url",
                      )),
                      DataColumn(
                          label: Text(
                        "Started At",
                      )),
                      DataColumn(
                          label: Text(
                        "User Email",
                      )),
                      DataColumn(
                          label: Text(
                        "Company Name",
                      )),
                      DataColumn(
                          label: Text(
                        "Actions",
                      )),
                    ],
                    rows: [
                      for (int i = 0; i < calls.length; i++)
                        DataRow(
                          selected: true,
                          cells: [
                            DataCell(
                              Text('${i + 1}'),
                            ),
                            DataCell(
                              Text('${calls[i].url}'),
                            ),
                            DataCell(
                              SizedBox(
                                child: Text(
                                  '${calls[i].startedAt}',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Text('${calls[i].user!.email}'),
                            ),
                            DataCell(
                              Text('${calls[i].company!.name}'),
                            ),
                            DataCell(
                              JHTableActions(
                                onDelete: state is CallsDeleteLoading
                                    ? null
                                    : () {
                                        context
                                            .read<CallsCubit>()
                                            .deleteCall(calls[i].id!);
                                      },
                                onEdit: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => JHEditCallDialog(
                                      callId: calls[i].id!,
                                      callUrl: calls[i].url!,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Text(
              "No Call Lists Yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        },
      ),
    );
  }
}
