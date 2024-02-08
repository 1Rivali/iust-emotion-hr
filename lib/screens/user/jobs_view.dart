import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:front/widgets/jh_footer.dart';
import 'package:gap/gap.dart';

import 'package:front/constants/app_colors.dart';
import 'package:front/widgets/jh_banner.dart';
import 'package:front/widgets/jh_joblist.dart';

class JobsView extends HookWidget {
  const JobsView({
    super.key,
    required this.tabController,
  });
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        JHBanner(
          img: "assets/images/jobs.png",
          text: TextSpan(
            text: 'There Are',
            style: Theme.of(context).textTheme.displayLarge,
            children: [
              TextSpan(
                text: " 100+",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: primaryColor),
              ),
              TextSpan(
                text: " Postings\nHere For You!",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              TextSpan(
                text: "\n\nFind Jobs, Employment & Career Opportunities",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.grey.shade800),
              )
            ],
          ),
        ),
        const Gap(50),
        Text(
          'Find Jobs',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        const Gap(50),
        JHJobList(
          tabController: tabController,
        ),
        const JHFooter(),
      ]),
    );
  }
}
