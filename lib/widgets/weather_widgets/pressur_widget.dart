import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/widgets/weather_widgets/bar_widget.dart'
    show BarWidget;


class PressurWidget extends StatelessWidget {
   PressurWidget({super.key,required this.pressureValue});
  double pressureValue;
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BarWidget(icon: Icons.speed, stateIcon: "PRESSURE"),
          SizedBox(height: 0.7.w),
          SleekCircularSlider(
            min: 0,
            max: 100,
            initialValue: pressureValue ,

            appearance: CircularSliderAppearance(
              infoProperties: InfoProperties(
                mainLabelStyle: TextStyle(
                  color: Colors.white, //color of value %
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              customColors: CustomSliderColors(
                trackColor: Colors.blue,
                progressBarColor: Colors.purple,
                dotColor: Colors.white,
              ),
              customWidths: CustomSliderWidths(
                progressBarWidth: 6,
                trackWidth: 6,
                handlerSize: 8,
              ),
              size: 150,
              startAngle: 270,
              angleRange: 360,
            ),
            onChange: (double value) {},
          ),
        ],
      ),
    );
  }
}
