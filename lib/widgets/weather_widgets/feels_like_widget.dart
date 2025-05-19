import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:sizer/sizer.dart';
import 'package:weather_app/widgets/weather_widgets/bar_widget.dart';

import '../../constant/colors.dart';
import '../utils/text_custom_widget.dart';

class FeelsLikeWidget extends StatelessWidget {
  String degree;
  String next;
  String textState;
  IconData icon;
  FeelsLikeWidget({
    Key? key,
    required this.textState,
    required this.icon,
    required this.degree,
    required this.next,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 43.w,
        height: 52.w,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 64, 48, 167),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BarWidget(icon: icon, stateIcon: textState),

             SizedBox(height: 2.h),

            TextCustomWidget(
              color: TextColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              text: degree,
            ),

            Spacer(),
            TextCustomWidget(
              color: TextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              text: next,
            ),
          ],
        ),
      ),
    );
  }
}
