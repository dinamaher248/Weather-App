import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/constant/colors.dart';
import 'package:weather_app/constant/image_pathes.dart' show ImagePathes;
import 'package:weather_app/widgets/utils/text_custom_widget.dart';

import '../../models/weather_model.dart';
import '../utils/weather_icons.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard({super.key, required this.model});
  final WeatherModel model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 25.h,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              ImagePathes.shadowBackgroundCard,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(2.h),
            child: Image.asset(
              ImagePathes.cardImageWeather, 
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustomWidget(
                        color: TextColor,
                        fontSize: 33.sp,
                        fontWeight: FontWeight.w300,
                        text: "${model.temp}°",
                      ),
                      Image.asset(
                        WeatherIcons.getWeatherImagePath(model.weatherState),
                        width: 30.w,
                        height: 12.h,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  TextCustomWidget(
                    color: Color.fromARGB(255, 143, 148, 159),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    text: "L:${model.minTemp}°  H:${model.maxTemp}°",
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustomWidget(
                        color: TextColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        text: "${model.cityName}, ${model.country}",
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 3.w),
                        child: TextCustomWidget(
                          color: TextColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          text: "${model.weatherState}", //"Mid Rain",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
