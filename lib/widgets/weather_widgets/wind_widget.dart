import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/widgets/weather_widgets/bar_widget.dart' show BarWidget;

class WindWidget extends StatelessWidget {
  const WindWidget({
    Key? key,
    required this.windSpeed,      
    required this.windDegree,     
  }) : super(key: key);

  final String  windSpeed;
  final int  windDegree;

  @override
  Widget build(BuildContext context) {
    final String dirText = _dirFromDeg(windDegree);

    return Container(
      width: 43.w,
      height: 52.w,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 64, 48, 167),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
           BarWidget(icon: Icons.air, stateIcon: 'Wind'),

          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white30, width: 1),
                  ),
                ),

                Positioned(top:    4.w, child: _dirLabel('N')),
                Positioned(bottom: 4.w, child: _dirLabel('S')),
                Positioned(left:   0.w, child: _dirLabel('W')),
                Positioned(right:  0.w, child: _dirLabel('E')),

                // ↗︎ 
                Transform.rotate(
                  angle: windDegree * (math.pi / 180), 
                  child:  Icon(Icons.navigation, color: Colors.white, size: 8.w),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      windSpeed,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 4.h),
                    const Text('km/h', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  //  Text(dirText,style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _dirFromDeg(int deg) {
    if (deg >= 337.5 || deg < 22.5) return 'N';
    if (deg >= 22.5  && deg < 67.5) return 'NE';
    if (deg >= 67.5  && deg < 112.5) return 'E';
    if (deg >= 112.5 && deg < 157.5) return 'SE';
    if (deg >= 157.5 && deg < 202.5) return 'S';
    if (deg >= 202.5 && deg < 247.5) return 'SW';
    if (deg >= 247.5 && deg < 292.5) return 'W';
    return 'NW';
  }

  Widget _dirLabel(String txt) =>
      Text(txt, style: const TextStyle(color: Colors.white));
}
