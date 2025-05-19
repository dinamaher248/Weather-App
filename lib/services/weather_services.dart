import 'package:dio/dio.dart';
import 'package:weather_app/core/Api/endpoints.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherServices {
  final Dio dio;
  WeatherServices(this.dio);
  Future<WeatherModel> getCurrentWeather() async {
    try {
      Response response = await dio.get(
        "http://api.weatherapi.com/v1/forcast.json?key=c38bd32a7c1c4b18b13225043250705&q=${ApiKey.cityName}&days=14",
      );

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errormsg = e.response?.data[ApiKey.error][ApiKey.message]?? "oops, there is an error";
      throw Exception(errormsg);
    }
  }
}
