import 'package:flutter/material.dart'
    show FormState, GlobalKey, TextEditingController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';

import '../core/Api/api_consumer.dart';
import '../core/Api/endpoints.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.apiConsumer) : super(WeatherInitialState());
  final ApiConsumer apiConsumer;

  TextEditingController cityName = TextEditingController();
  GlobalKey<FormState> weatherFormKey = GlobalKey();

  WeatherModel? weatherModel;
  WeatherModel? searchedCity;
  getCurrentWeather() async {
    try {
      emit(weatherLoading());

      final response = await apiConsumer.get(
        "${Endpoints.forecastUrl}Zagazig&days=14&aqi=yes",
      );

      weatherModel = WeatherModel.fromJson(response);
      emit(weatherSuccess());
    } on ServerException catch (e) {
      emit(weatherFailure(errMessage: e.errorModel.errorMessage));
    }
  }

  Future<void> SearchtWeather() async {
    try {
      emit(weatherLoading());

      final response = await apiConsumer.get(
        "${Endpoints.forecastUrl}${cityName.text}&days=14&aqi=yes",
      );

      searchedCity = WeatherModel.fromJson(response);
      emit(weatherSuccess());
    } catch (e) {
      emit(weatherFailure(errMessage: e.toString()));
    }
  }

  List<WeatherModel> defaultCities = [];

  Future<void> getDefaultCitiesWeather() async {
    try {
      emit(weatherLoading());
      List<String> cities = [
        "Cairo",
        "London",
        "New York",
        "Paris",
        "Tokyo",
        "Sydney",
        "Zagazig",
        "Alexandria",
        "Dubai",
        "Riyadh",
        "Moscow",
        "Berlin",
        "Cape Town",
        "Toronto",
        "Madrid",
        "Rome",
        "Beijing",
        "Seoul",
        "Istanbul",
        "Buenos Aires",
        "Cairo",
        "Alexandria",
        "Riyadh",
        "Jeddah",
        "Dubai",
        "Abu Dhabi",
        "Doha",
        "Amman",
        "Beirut",
        "Kuwait City",
        "Manama",
        "Muscat",
        "Khartoum",
        "Tunis",
        "Algiers",
        "Casablanca",
        "Baghdad",
        "Damascus",
        "Tripoli",
        "Gaza",

      ];

      defaultCities.clear();

      for (var city in cities) {
        final response = await apiConsumer.get(
          "${Endpoints.forecastUrl}$city&days=14&aqi=yes",
        );
        defaultCities.add(WeatherModel.fromJson(response));
      }

      emit(weatherSuccess());
    } catch (e) {
      emit(weatherFailure(errMessage: e.toString()));
    }
  }
}
