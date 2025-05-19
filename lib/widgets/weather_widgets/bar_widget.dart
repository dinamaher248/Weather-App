import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../utils/text_custom_widget.dart';

class BarWidget extends StatelessWidget {
  IconData icon;
  String stateIcon;

  BarWidget({super.key,required this.icon,required this.stateIcon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.7),
          size: 18,
        ),
        const SizedBox(width: 4),
        TextCustomWidget(
          color: Colors.white.withOpacity(0.7),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          text: stateIcon,
        ),
      ],
    );
  }
}
