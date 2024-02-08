import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/jobs/jobs_cubit.dart';

import 'package:front/models/job_model.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_section_title.dart';
import 'package:front/widgets/jh_table.dart';
import 'package:front/widgets/jh_table_actions.dart';
import 'package:gap/gap.dart';

class AdminJobsView extends HookWidget {
  const AdminJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<JobsCubit>().getJobs();
      return null;
    }, const []);
    return Padding(
      padding: EdgeInsets.only(
        top: screenSize(context).height * 0.05,
        left: screenSize(context).width * 0.02,
        right: screenSize(context).width * 0.02,
      ),
      child: BlocBuilder<JobsCubit, JobsState>(
        builder: (context, state) {
          List<JobModel>? jobs = context.watch<JobsCubit>().jobs;
          if (state is JobsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          if (jobs != null) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const JHSectionTitle(
                    title: "Jobs List",
                  ),
                  const Gap(40),
                  JHTable(
                    columns: [
                      const DataColumn(
                          label: Text(
                        "#",
                      )),
                      const DataColumn(
                          label: Text(
                        "Title",
                      )),
                      const DataColumn(
                          label: Text(
                        "Description",
                      )),
                      DataColumn(
                          label: SizedBox(
                        width: screenSize(context).width * 0.1,
                        child: const Text(
                          "No of Applicants",
                        ),
                      )),
                      const DataColumn(
                          label: Text(
                        "Company",
                      )),
                      const DataColumn(
                          label: Text(
                        "Actions",
                      )),
                    ],
                    rows: [
                      for (int i = 0; i < jobs.length; i++)
                        DataRow(
                          selected: true,
                          cells: [
                            DataCell(
                              Text('${i + 1}'),
                            ),
                            DataCell(
                              Text('${jobs[i].title}'),
                            ),
                            DataCell(
                              SizedBox(
                                width: screenSize(context).width * 0.3,
                                child: Text(
                                  '${jobs[i].description}',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(
                              Text('${jobs[i].countApplicants}'),
                            ),
                            DataCell(
                              Text('${jobs[i].company!.name}'),
                            ),
                            DataCell(
                              JHTableActions(
                                onDelete: state is JobsDeleteLoading
                                    ? null
                                    : () {
                                        context
                                            .read<JobsCubit>()
                                            .deleteJob(jobs[i].id!);
                                      },
                                onEdit: () {},
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
              "No Job Lists Yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        },
      ),
    );
  }
}
