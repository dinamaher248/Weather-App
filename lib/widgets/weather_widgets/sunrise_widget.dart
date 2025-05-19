import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/widgets/weather_widgets/bar_widget.dart';

import '../../constant/colors.dart';
import '../utils/text_custom_widget.dart' show TextCustomWidget;

class SunriseWidget extends StatelessWidget {
   SunriseWidget({super.key,required this.sunrise,required this.sunset});
  String sunrise;
  String sunset;
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
          BarWidget(icon: Icons.sunny_snowing, stateIcon: "SUNRISE"),

          TextCustomWidget(
            color: TextColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
            text: sunrise ,
          ),

          ///
          SizedBox(height: 2.h),
          Expanded(
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),

                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [FlSpot(0, 1), FlSpot(2, 3.4), FlSpot(4, 1)],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 6, 23, 129),
                        Colors.blueAccent,
                        const Color.fromARGB(255, 6, 23, 129),
                      ],
                    ),
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 2.h),

          Row(
            children: [
              TextCustomWidget(
                color: TextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w200,
                text: "Sunset : ",
              ),
              TextCustomWidget(
                color: TextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w100,
                text: sunset,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
