import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart'; 
import 'package:weather_app/widgets/weather_widgets/bar_widget.dart';

import '../../constant/colors.dart';
import '../utils/text_custom_widget.dart';

class Rainfall extends StatelessWidget {
  final String qOfRAain;
  final double qOfTotal;
  final List<double> hourlyRainList;
  final double? progress; 

  const Rainfall({
    Key? key,
    required this.qOfRAain,
    required this.qOfTotal,
    required this.hourlyRainList,
    this.progress,
  }) : super(key: key);

  // Calculate progress based on current time of day (0.0 to 1.0)
  double get timeProgress {
    if (progress != null) return progress!;
    
    final now = DateTime.now();
    // Calculate progress through the day (0-1)
    return (now.hour * 60 + now.minute) / (24 * 60);
  }

  // Get rainfall data for display - consolidate 24 hours to 12 bars if needed
  List<double> get displayRainData {
    // If we have exactly 12 data points, use them directly
    if (hourlyRainList.length == 12) return hourlyRainList;
    
    // If we have 24 data points (hourly for full day), consolidate to 12
    if (hourlyRainList.length == 24) {
      List<double> consolidated = [];
      for (int i = 0; i < 24; i += 2) {
        // Average or sum every 2 hours (depending on preference)
        double value = (hourlyRainList[i] + hourlyRainList[i + 1]) / 2; // Average
        consolidated.add(value);
      }
      return consolidated;
    }
    
    // For any other length, try to normalize to 12 points
    final result = List<double>.filled(12, 0.0);
    if (hourlyRainList.isEmpty) return result;
    
    // Simple distribution of available data
    final factor = hourlyRainList.length / 12;
    for (int i = 0; i < 12; i++) {
      final sourceIndex = (i * factor).floor();
      if (sourceIndex < hourlyRainList.length) {
        result[i] = hourlyRainList[sourceIndex];
      }
    }
    return result;
  }

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
            BarWidget(icon: Icons.water_drop, stateIcon: 'RAINFALL'),

            const SizedBox(height: 4),
            TextCustomWidget(
              color: TextColor,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              text: qOfRAain,
            ),

            const SizedBox(height: 10),

            // Rainfall Graph
            SizedBox(
              height: 8.h,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    size: Size(constraints.maxWidth, 5.h),
                    painter: RainfallGraphPainter(
                      progress: timeProgress,
                      rainfallData: displayRainData,
                    ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Expected: $qOfTotal mm today',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RainfallGraphPainter extends CustomPainter {
  final double progress;
  final List<double> rainfallData;

  RainfallGraphPainter({required this.progress, required this.rainfallData});

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // Draw horizontal line
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1.0;

    canvas.drawLine(
      Offset(0, height * 0.7),
      Offset(width, height * 0.7),
      linePaint,
    );

    // Find maximum rainfall value for normalization
    double maxRainfall = 0.1; // Minimum to avoid division by zero
    for (final value in rainfallData) {
      if (value > maxRainfall) maxRainfall = value;
    }

    // Draw rainfall bars
    final barWidth = width / 12;
    final barMaxHeight = height * 0.65; // Slightly less than line position for margin
    final barPaint = Paint()
      ..color = const Color(0xFF88C0D0)
      ..style = PaintingStyle.fill;

    final normalizedData = rainfallData.map((value) {
      // Normalize values but ensure small values are still visible
      if (value <= 0) return 0.0;
      return 0.05 + ((value / maxRainfall) * 0.95); // Min 5% height for visibility
    }).toList();

    for (int i = 0; i < normalizedData.length; i++) {
      double barHeight = barMaxHeight * normalizedData[i];
      double startX = i * barWidth + barWidth * 0.1;
      double barRealWidth = barWidth * 0.8;

      // Ensure minimum height for non-zero values
      if (rainfallData[i] > 0 && barHeight < 2) {
        barHeight = 2; // Minimum 2 pixels height for non-zero values
      }

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            startX,
            height * 0.7 - barHeight,
            barRealWidth,
            barHeight,
          ),
          Radius.circular(barRealWidth / 2),
        ),
        barPaint,
      );
    }

    final indicatorPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0;

    double indicatorX = width * progress;
    canvas.drawLine(
      Offset(indicatorX, 0),
      Offset(indicatorX, height),
      indicatorPaint,
    );

    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(indicatorX, height * 0.7), 4.0, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}