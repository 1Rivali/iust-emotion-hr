import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/cubit/auth/auth_cubit.dart';
import 'package:front/cubit/jobs/jobs_cubit.dart';
import 'package:front/models/job_model.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/dialogs/jh_login_dialog.dart';
import 'package:gap/gap.dart';

class JHJobList extends HookWidget {
  const JHJobList({
    super.key,
    required this.tabController,
  });
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<JobsCubit>().getJobs();
      return null;
    }, const []);
    bool isLoggedIn = context.watch<AuthCubit>().isLoggedIn();

    final itemCount = useState<int>(6);
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screenSize(context).width * 0.1),
      child: BlocConsumer<JobsCubit, JobsState>(
        listener: (context, state) {
          final jobs = context.read<JobsCubit>().jobs;
          if (jobs!.length < 6) {
            itemCount.value = jobs.length;
          }
        },
        builder: (context, state) {
          List<JobModel>? jobs = context.watch<JobsCubit>().jobs;

          if (state is JobsLoading) {
            return const CircularProgressIndicator(
              color: primaryColor,
            );
          }

          if (jobs != null) {
            return Column(
              children: [
                GridView.builder(
                  itemCount: itemCount.value,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.8,
                  ),
                  itemBuilder: (context, index) {
                    JobModel job = jobs[index];
                    return JobCard(job: job);
                  },
                ),
                const Gap(35),
                if (itemCount.value != jobs.length)
                  TextButton(
                    onPressed: () {
                      if (isLoggedIn) {
                        tabController.animateTo(1);
                        if (tabController.index == 1) {
                          itemCount.value = jobs.length;
                        }
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (context) => const LoginDialog(),
                      );
                    },
                    child: Text(
                      "Show more",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: primaryColor),
                    ),
                  ),
              ],
            );
          }
          return Text(
            "Sorry There is no Jobs to show",
            style: Theme.of(context).textTheme.headlineSmall,
          );
        },
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
    required this.job,
  });

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = context.watch<AuthCubit>().isLoggedIn();
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize(context).width * 0.02,
          vertical: screenSize(context).width * 0.01),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              job.title!,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.business),
                const Gap(8),
                Text(
                  job.company!.name!,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              job.description!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey.shade600),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isLoggedIn)
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: const Text("Apply Now!"),
              ),
            ),
        ],
      ),
    );
  }
}
