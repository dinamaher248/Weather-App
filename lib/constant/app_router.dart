import 'package:go_router/go_router.dart';
import 'package:weather_app/screens/home.dart';
import 'package:weather_app/screens/weather_search_add.dart';


class AppRouter {
  static String homePath = '/home';
  static String addPath = '/addPath';
 
  static GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: homePath,
        builder: (context, state) => const Home(),
      ), GoRoute(
        path: addPath,
        builder: (context, state) => const WeatherSearchAdd(),
      ),
    ],
  );
}
