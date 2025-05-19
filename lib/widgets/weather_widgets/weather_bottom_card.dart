import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/constant/app_router.dart';
import 'package:weather_app/widgets/utils/text_custom_widget.dart';
import 'package:weather_app/widgets/weather_widgets/air_quality_widget.dart'
    show AirQualityWidget;
import 'package:weather_app/widgets/weather_widgets/feels_like_widget.dart'
    show FeelsLikeWidget;
import 'package:weather_app/widgets/weather_widgets/horizintal_forcast_hourly_widget.dart';
import 'package:weather_app/widgets/weather_widgets/rainfall.dart';
import 'package:weather_app/widgets/weather_widgets/sunrise_widget.dart';
import 'package:weather_app/widgets/weather_widgets/uv_index_widget.dart'
    show UvIndexWidget;
import 'package:weather_app/widgets/weather_widgets/wind_widget.dart';

import '../../cubit/weather_cubit.dart';
import '../../cubit/weather_state.dart';
import 'pressur_widget.dart';

class WeatherBottomCard extends StatefulWidget {
  final ScrollController scrollController;
  final double init;
  const WeatherBottomCard({
    Key? key,
    required this.scrollController,
    required this.init,
  }) : super(key: key);

  @override
  State<WeatherBottomCard> createState() => _WeatherBottomCardState();
}

class _WeatherBottomCardState extends State<WeatherBottomCard> {
  double currentSize = 0.33;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is weatherLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is weatherSuccess) {
          final weatherModel = context.read<WeatherCubit>().weatherModel!;
          return NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              setState(() {
                currentSize = notification.extent;
              });
              return true;
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade900.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hourly Forecast",
                          style: TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Weekly Forecast",
                          style: TextStyle(color: Colors.white24),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),

                    // Horizontal Forecast
                    HorizintalForcastHourly(weatherModel: weatherModel),
                    SizedBox(height: 3.h),
                    if (currentSize <= widget.init + 0.01)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.my_location, color: Colors.white),
                          GestureDetector(
                            onTap: () {
                              context.push(AppRouter.addPath);
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Icon(Icons.add, color: Colors.deepPurple),
                            ),
                          ),
                          Icon(Icons.menu, color: Colors.white),
                        ],
                      ),
                    SizedBox(height: 2.h),
                    // air quality
                    AirQualityWidget(
                      airQualityIndex: weatherModel.airQuality ?? 0,
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        //uv index
                        UvIndexWidget(uvindex: "${weatherModel.uv.toString()}"),
                        SizedBox(width: 2.h),
                        //sunrise
                        SunriseWidget(
                          sunrise: "${weatherModel.sunrise}",
                          sunset: "${weatherModel.sunset}",
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: 
                      [
                        WindWidget(
                          windSpeed: "${weatherModel.wind_kph.toString()}",
                          windDegree: weatherModel.wind_degree ?? 300,
                        ),
                        SizedBox(width: 2.h),

                        Rainfall(
                          qOfRAain: "${weatherModel.quantityOfRain.toString()}",
                          qOfTotal: weatherModel.quantityOfRainForTotal,
                          hourlyRainList: weatherModel.hourlyRainList,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: 
                      [
                        FeelsLikeWidget(
                          textState: "Feels Like",
                          icon: Icons.hot_tub,
                          degree: "${weatherModel.feelslike_c.toString()}°",
                          next: "similar to actual temperature",
                        ),
                        SizedBox(width: 2.h),
                        FeelsLikeWidget(
                          textState: "HUMADITY",
                          icon: Icons.air,
                          degree: "${weatherModel.humidity.toString()}%",
                          next:
                              "The dew point is ${weatherModel.dewpoint_c.toString()} right now",
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: 
                      [
                        FeelsLikeWidget(
                          textState: "VISIBILITY",
                          icon: Icons.visibility_sharp,
                          degree: "${weatherModel.vis_km.toString()}km",
                          next: "similar to the actual temperature",
                        ),
                        SizedBox(width: 2.h),
                        PressurWidget(pressureValue: weatherModel.pressure_in),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: TextCustomWidget(
              text: "No Data",
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          );
        }
      },
    );
  }
}
