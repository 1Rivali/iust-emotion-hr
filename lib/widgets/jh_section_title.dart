import 'package:flutter/material.dart';
import 'package:front/constants/app_colors.dart';

class JHSectionTitle extends StatelessWidget {
  const JHSectionTitle({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(color: primaryColor),
    );
  }
}
