import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_widgets/bar_widget.dart';

class AirQualityWidget extends StatelessWidget {
  final int airQualityIndex;

  const AirQualityWidget({
    Key? key,
    required this.airQualityIndex,
  }) : super(key: key);

  String getRiskLevel(int aqi) {
    if (aqi <= 50) return "Good";
    if (aqi <= 100) return "Moderate";
    if (aqi <= 150) return "Unhealthy (Sensitive)";
    if (aqi <= 200) return "Unhealthy";
    if (aqi <= 300) return "Very Unhealthy";
    return "Hazardous";
  }

  double getProgressValue(int aqi) {
    return (aqi / 500).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 64, 48, 167), 
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Air Quality Row
          BarWidget(icon: Icons.air, stateIcon: 'AIR QUALITY'),

          const SizedBox(height: 10),

          // AQI Value and Risk Level
          Text(
            '$airQualityIndex-${getRiskLevel(airQualityIndex)} Health Risk',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          Stack(
            children: [
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              FractionallySizedBox(
                widthFactor: getProgressValue(airQualityIndex),
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple, Colors.pink],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'See more',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.7),
                size: 14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
