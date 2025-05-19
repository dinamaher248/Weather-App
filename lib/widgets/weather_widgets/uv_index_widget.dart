import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/widgets/weather_widgets/bar_widget.dart';

import '../../constant/colors.dart';
import '../utils/text_custom_widget.dart' show TextCustomWidget;

class UvIndexWidget extends StatelessWidget {
   UvIndexWidget({super.key,required this.uvindex});
  String uvindex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 64, 48, 167),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarWidget(icon: Icons.sunny, stateIcon: "UV INDEX"),

          SizedBox(height: 1.h),

          TextCustomWidget(
            color: TextColor,
            fontSize: 27.sp,
            fontWeight: FontWeight.w500,
            text: uvindex,
          ),
          TextCustomWidget(
            color: TextColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            text: "Moderate",
          ),
          SizedBox(height: 4.w),

          //progress
          Container(
            height: 4,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple, Colors.pink],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // White dot indicator that moves
                    Positioned(
                      left:
                          constraints.maxWidth * 0.2 -
                          4,
                      top: -2, 
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
