import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/constant/colors.dart';
import 'package:weather_app/widgets/utils/text_custom_widget.dart';

import '../../models/weather_model.dart';

class HorizintalForcastHourly extends StatelessWidget {
  const HorizintalForcastHourly({super.key, required this.weatherModel});

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: weatherModel.hourlyWeatherList.length ?? 7,
        separatorBuilder: (_, __) => SizedBox(width: 12),
        itemBuilder: (context, index) {
          final hour = weatherModel.hourlyWeatherList[index];
          return Container(
            width: 12.w,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: index == 1 ? Colors.deepPurple : Colors.white10,
              borderRadius: BorderRadius.circular(90),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextCustomWidget(
                    text:  index == 1 ? "Now" : hour.time.split(" ")[1],
                    color: TextColor,
                     fontSize: 12,
                  ),
                  Image.network(hour.iconUrl, width: 27, height: 27),
                  TextCustomWidget(
                    text: "${hour.tempC.round()}°",
                    color: TextColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
