import 'package:flutter/material.dart';
import 'package:front/constants/app_colors.dart';
import 'package:front/utils/helpers.dart';

class JHBanner extends StatelessWidget {
  const JHBanner({
    super.key,
    required this.text,
    required this.img,
  });
  final InlineSpan text;
  final String img;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: surfaceColor,
      padding:
          EdgeInsets.symmetric(horizontal: screenSize(context).width * 0.06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: text,
            ),
          ),
          Expanded(
              child: Image.asset(
            img,
            height: screenSize(context).height * 0.75,
          )),
        ],
      ),
    );
  }
}
