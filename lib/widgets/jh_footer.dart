import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class JHFooter extends StatelessWidget {
  const JHFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(100),
        const Divider(),
        const Gap(30),
        Text(
          "\u00a9 2024 Job Harbor. All Rights Reserved.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Gap(30),
      ],
    );
  }
}
