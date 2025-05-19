class HourlyWeather {
  final String time;
  final double tempC;
  final String conditionText;
  final String iconUrl;

  HourlyWeather({
    required this.time,
    required this.tempC,
    required this.conditionText,
    required this.iconUrl,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: json['time'], // "2023-05-19 14:00"
      tempC: (json['temp_c'] as num).toDouble(),
      conditionText: json['condition']['text'],
      iconUrl: "https:${json['condition']['icon']}",
    );
  }}
  
  /*
  HourlyWeather(
      time:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey
              .hour][0]['time'], // "2023-05-19 14:00"
      tempC: (jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey
              .hour][0]['temp_c'] as num).toDouble(),
      conditionText: jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey
              .hour][0]['condition']['text'],
      iconUrl: "https:${jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey
              .hour][0]['condition']['icon']}",
    );
  }
   */

