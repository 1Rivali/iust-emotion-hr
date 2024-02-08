import 'package:flutter/material.dart';
import 'package:front/widgets/jh_footer.dart';
import 'package:gap/gap.dart';

import 'package:front/constants/app_colors.dart';
import 'package:front/utils/helpers.dart';
import 'package:front/widgets/jh_banner.dart';
import 'package:front/widgets/jh_joblist.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.tabController,
  });
  final TabController tabController;
  final List<Map<String, String>> ourPartners = const [
    {
      "logo": "assets/logos/apple-logo.png",
      "title": "apple",
    },
    {
      "logo": "assets/logos/google-logo.png",
      "title": "google",
    },
    {
      "logo": "assets/logos/meta-logo.png",
      "title": "meta",
    },
    {
      "logo": "assets/logos/netflix-logo.png",
      "title": "netflix",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          JHBanner(
            img: 'assets/images/banner-1.png',
            text: TextSpan(
              text: "Find a Job You'll Love\nwith The",
              style: Theme.of(context).textTheme.displayLarge,
              children: [
                TextSpan(
                  text: " #1 Job",
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(color: primaryColor),
                ),
                TextSpan(
                  text: " Site",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                TextSpan(
                  text: "\n\nYour next role could be with one of our partners",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.grey.shade800),
                ),
              ],
            ),
          ),
          const Gap(50),
          Text(
            'Our Partners',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const Gap(50),
          _buildOurPartners(context),
          const Gap(50),
          Text(
            'Popular Job Lists',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const Gap(50),
          JHJobList(
            tabController: tabController,
          ),
          const Gap(50),
          Text(
            'Our Services',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const Gap(50),
          _buildVideoCallService(context),
          const JHFooter(),
        ],
      ),
    );
  }

  Container _buildVideoCallService(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: screenSize(context).width * 0.13),
      padding: EdgeInsets.all(screenSize(context).width * 0.06),
      height: screenSize(context).height * 0.65,
      decoration: BoxDecoration(
          border: Border.all(color: primaryColor, width: 1),
          borderRadius: BorderRadius.circular(35),
          color: primaryColor.withOpacity(0.06)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 100,
              text: TextSpan(
                text: 'Host Your Interviews Online, ',
                style: Theme.of(context).textTheme.headlineLarge,
                children: [
                  TextSpan(
                    text: "With Our AI Powered Video Calls",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: primaryColor),
                  ),
                  TextSpan(
                    text:
                        "\n\nWe offer a Critical video calls mechanism that allow your interviewers to keep track of your interviewee emotions, Which helps the interviewers to interact with the interviewee based on his emotions and mental state",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey.shade800,
                        wordSpacing: 4,
                        letterSpacing: 2),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                'assets/images/video-call.webp',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildOurPartners(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < ourPartners.length; i++)
          Column(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor.withOpacity(0.1),
                radius: screenSize(context).width * 0.03,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    ourPartners[i]["logo"]!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(4),
              Text(
                ourPartners[i]["title"]!,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
      ],
    );
  }
}
