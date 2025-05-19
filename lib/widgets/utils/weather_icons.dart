import 'package:weather_app/constant/image_pathes.dart';

class WeatherIcons {
  static String getWeatherImagePath(String weatherState) {
    final state = weatherState.toLowerCase();

    if (state.contains('sunny') || state.contains('clear')) {
      return ImagePathes.sunnyImage;
    } else if (state.contains('cloudy') || state.contains('overcast') || state.contains('partly cloudy')) {
      return ImagePathes.cloudyImage;
    }  
    else if (state.contains('rain') || state.contains('drizzle') || state.contains('shower')) {
      if (state.contains('light')) {
        return ImagePathes.lightRainImage;
      } else if (state.contains('heavy') || state.contains('torrential')) {
        return ImagePathes.heavyRainImage;
      } else {
        return ImagePathes.moderateRainImage;
      }
    }
    else if (state.contains('snow') || state.contains('sleet') || state.contains('ice') || state.contains('blizzard')) {
      return ImagePathes.snowImage;
    }
    else if (state.contains('thunder')) {
      return ImagePathes.thunderImage;
    }
    else if (state.contains('fog') || state.contains('mist')) {
      return ImagePathes.mistImage;
    }
    else if (state.contains('wind')) {
      return ImagePathes.fastWindImage;
    }  
   

    return ImagePathes.fastWindImage;
  }
}
