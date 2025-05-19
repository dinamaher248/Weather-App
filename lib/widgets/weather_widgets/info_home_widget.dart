
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant/colors.dart' show TextColor;
import '../../constant/image_pathes.dart';
import '../../cubit/weather_cubit.dart';
import '../utils/text_custom_widget.dart';

class InfoHomeWidget extends StatelessWidget {
  const InfoHomeWidget({
    super.key,
    required this.cubit,
  });

  final WeatherCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            TextCustomWidget(
              color: TextColor,
              fontSize: 25.sp,
              fontWeight: FontWeight.w300,
              text: "${cubit.weatherModel?.cityName}",
            ),
            TextCustomWidget(
              color: TextColor,
              fontSize: 37.sp,
              fontWeight: FontWeight.w300,
              text: "${cubit.weatherModel?.temp}", //"20°",
            ),
            TextCustomWidget(
              color: Color.fromARGB(255, 143, 148, 159),
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              text:
                  "Mostly ${cubit.weatherModel?.weatherState}",
            ),
            TextCustomWidget(
              color: TextColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              text:
                  "L:${cubit.weatherModel?.minTemp}°  H:${cubit.weatherModel?.maxTemp}°",
            ),
            SizedBox(height: 5.h),
            Image.asset(
              ImagePathes.homeImage,
              width: 100.w,
              height: 55.h,
            ),
          ],
        ),
      ),
    );
  }
}
