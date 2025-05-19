class Endpoints {
  //http://api.weatherapi.com/v1/forcast.json?key=c38bd32a7c1c4b18b13225043250705&q=Paris&days=14&aqi=no&alert=no
  static String key = "key=c38bd32a7c1c4b18b13225043250705";
  static String baseUrl = "http://api.weatherapi.com/v1";
  static String currentWeather = "$baseUrl/current.json?$key&q=";
  static String forecastUrl = "$baseUrl/forecast.json?$key&q=";
  static String searchUrl = "$baseUrl/search.json?$key&q=";
  static String timeZone = "$baseUrl/timezone.json?$key&q=";
}

class ApiKey {
  //location map
  static String location = "location";
  static String cityName = "name";
  static String region = "region";
  static String country = "country";
  static String status = "text";

  static String localTime = "localtime";
  static String is_day = "is_day";
  //where there an error
  static String message = "message";
  static String error = "error";
  // forcast map
  static String forecast = "forecast";
  static String forecastday = "forecastday";
  // day map in forcast map
  static String day = "day";
  static String avgTemp = "avgtemp_c";
  static String minTemp = "mintemp_c";
  static String maxTemp = "maxtemp_c";
  //wether condition or state
  static String condition = "condition";
  static String state = "text";
  static String icon = "text";

  /// current
  static String current = "current";
  static String feelslike_c = "feelslike_c";
  static String pressure_in = "pressure_in";
  static String humidity = "humidity";
  static String wind_dir = "wind_dir";
  static String wind_kph = "wind_kph";
  static String wind_degree = "wind_degree";
  static String dewpoint_c = "dewpoint_c";
  static String vis_km = "vis_km";
  static String uv = "uv";
  static String quantityOfRain = "precip_mm";
  static String quantityOfRainForTotal = "totalprecip_mm";
  //for rain hourly
  static String hour = "hour";
  //astro
  static String astro = "astro";
  static String sunrise = "sunrise";
  static String sunset = "sunset";
  //air quality 
    static String air_quality = "air_quality";
    static String aQi = "us-epa-index";

}
