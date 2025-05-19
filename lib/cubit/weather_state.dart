class WeatherState {}

final class WeatherInitialState extends WeatherState {}


///####################################################
final class weatherSuccess extends WeatherState {}


final class weatherLoading extends WeatherState {}

final class weatherFailure extends WeatherState {
  final String errMessage;

  weatherFailure({required this.errMessage});
}

///#####################################################
final class GetWeatherSuccess extends WeatherState {

}

final class GetWeatherLoading extends WeatherState{}

final class GetWeatherFailure extends WeatherState {
  final String errMessage;

  GetWeatherFailure({required this.errMessage});
}
