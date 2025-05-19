import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/constant/colors.dart';
import 'package:weather_app/constant/image_pathes.dart' show ImagePathes;
import 'package:weather_app/cubit/weather_cubit.dart';
import 'package:weather_app/cubit/weather_state.dart';
import 'package:weather_app/widgets/weather_widgets/weather_bottom_card.dart';
import 'package:permission_handler/permission_handler.dart' as perm;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/weather_widgets/info_home_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    context.read<WeatherCubit>().getCurrentWeather();
  }

  Future<void> requestLocationPermission() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final status = await Permission.location.request();
      if (status.isGranted) {
        print('Location permission granted');
      } else {
        print('Permission denied');
      }
    } else {
      print('Permissions not required on this platform');
    }
  }

  @override
  Widget build(BuildContext context) {
    const double initialSheetSize = 0.37;
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state is weatherSuccess) {
          print("Loaded Successfully");
        } else if (state is weatherFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },

      builder: (context, State) {
        final cubit = context.read<WeatherCubit>();

        return Scaffold(
          body: Sizer(
            builder: (context, orientation, deviceType) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(ImagePathes.backgroundImage, fit: BoxFit.cover),
                  State is weatherLoading
                      ? Center(child: SpinKitChasingDots(color: Colors.purple, size: 50.0),)
                      : InfoHomeWidget(cubit: cubit),
                  // Draggable Bottom Card
                  DraggableScrollableSheet(
                    initialChildSize: initialSheetSize,
                    minChildSize: initialSheetSize,
                    maxChildSize: 0.9,
                    builder: (context, scrollController) {
                      return WeatherBottomCard(
                        scrollController: scrollController,
                        init: initialSheetSize,
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
