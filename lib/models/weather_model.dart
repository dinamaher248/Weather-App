import 'package:weather_app/models/hour_models.dart' show HourlyWeather;

import '../core/Api/endpoints.dart';

//has the response
class WeatherModel {
  final String cityName;
  final String country;
  final String region;
  final String date;
  final String? image;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String weatherState;
  final double feelslike_c;
  final int humidity;
  final double pressure_in;
  final double? wind_kph;
  final String wind_dir;
  final int? wind_degree;
  final double dewpoint_c;
  final double vis_km;
  final double uv;
  final String sunrise;
  final String sunset;
  final double? quantityOfRain;
  final double quantityOfRainForTotal;
  final double rainPerHour;
  List<double> hourlyRainList;
  final int ?airQuality;
  final List<HourlyWeather> hourlyWeatherList;


  WeatherModel({
    required this.cityName,
    required this.country,
    required this.region,
    required this.date,
    this.image,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherState,
    required this.feelslike_c,
    required this.humidity,
    required this.pressure_in,
    required this.wind_kph,
    required this.wind_dir,
    required this.wind_degree,
    required this.dewpoint_c,
    required this.vis_km,
    required this.uv,
    required this.sunrise,
    required this.sunset,
    required this.quantityOfRain,
    required this.quantityOfRainForTotal,
    required this.rainPerHour,
    required this.hourlyRainList,
    required this.airQuality,
    required this.hourlyWeatherList
  });

  factory WeatherModel.fromJson(dynamic jsonData) {
    List<double> hourlyRainList = [];
    try {
      var hourlyData =
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.hour];
      hourlyRainList = List<double>.from(
        hourlyData.map((hourData) {
          // Handle null, convert to double, or provide default value (0.0)
          var precip = hourData['precip_mm'];
          if (precip == null) return 0.0;
          return double.tryParse(precip.toString()) ?? 0.0;
        }),
      );
    } catch (e) {
      print("Error parsing hourly rain data: $e");
      hourlyRainList = List.filled(24, 0.0);
    }

    List<HourlyWeather> hourlyWeatherList = [];
try {
  var hourlyData = jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.hour];
  hourlyWeatherList = List<HourlyWeather>.from(
    hourlyData.map((hourData) => HourlyWeather.fromJson(hourData)),
  );
} catch (e) {
  print("Error parsing hourly weather data: $e");
  hourlyWeatherList = [];
}

    return WeatherModel(
      cityName: jsonData[ApiKey.location][ApiKey.cityName],
      country: jsonData[ApiKey.location][ApiKey.country],
      region: jsonData[ApiKey.location][ApiKey.region],
      date: jsonData[ApiKey.location][ApiKey.localTime],
      feelslike_c: jsonData[ApiKey.current][ApiKey.feelslike_c],
      humidity: jsonData[ApiKey.current][ApiKey.humidity],
      pressure_in: jsonData[ApiKey.current][ApiKey.pressure_in],
      wind_dir: jsonData[ApiKey.current][ApiKey.wind_dir],
      wind_kph: jsonData[ApiKey.current][ApiKey.wind_kph],
      wind_degree: jsonData[ApiKey.current][ApiKey.wind_degree],
      dewpoint_c: jsonData[ApiKey.current][ApiKey.dewpoint_c],
      vis_km: jsonData[ApiKey.current][ApiKey.vis_km],
      uv: jsonData[ApiKey.current][ApiKey.uv],
      airQuality:jsonData[ApiKey.current][ApiKey.air_quality][ApiKey.aQi],
      quantityOfRain: jsonData[ApiKey.current][ApiKey.quantityOfRain],
      quantityOfRainForTotal:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.day][ApiKey
              .quantityOfRainForTotal],
      rainPerHour:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey
              .hour][0]['precip_mm'],
      image:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.day][ApiKey
              .condition][ApiKey.icon],
      temp:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.day][ApiKey
              .avgTemp], //0--> because existing of list in API
      maxTemp:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.day][ApiKey
              .maxTemp],
      minTemp:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.day][ApiKey
              .minTemp],
      weatherState:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.day][ApiKey
              .condition][ApiKey.state],
      sunrise:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.astro][ApiKey
              .sunrise],
      sunset:
          jsonData[ApiKey.forecast][ApiKey.forecastday][0][ApiKey.astro][ApiKey
              .sunset],
      hourlyRainList: hourlyRainList,
      hourlyWeatherList: hourlyWeatherList,

    );
  }
}
