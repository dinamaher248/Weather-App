import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/widgets/weather_widgets/weather_card.dart';

import '../constant/colors.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../widgets/utils/search_widget.dart';
import '../widgets/utils/text_custom_widget.dart';

class WeatherSearchAdd extends StatefulWidget {
  const WeatherSearchAdd({super.key});

  @override
  State<WeatherSearchAdd> createState() => _WeatherSearchAddState();
}

class _WeatherSearchAddState extends State<WeatherSearchAdd> {
  @override
void initState() {
  super.initState();
  final cubit = context.read<WeatherCubit>();

  cubit.cityName.clear();

  cubit.searchedCity = null;

  cubit.getDefaultCitiesWeather();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.keyboard_arrow_left, color: Colors.white70),
        ),
        title: TextCustomWidget(
          color: TextColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w300,
          text: "Weather",
        ),
        backgroundColor: Color(0xff322F5F),
      ),
      backgroundColor: Color(0xff322F5F),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            SearchWidget(),
            SizedBox(height: 2.h),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                final cubit = context.read<WeatherCubit>();

                if (state is weatherLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is weatherSuccess) {
                  if (cubit.searchedCity != null) {
                    return Column(
                      children: [
                        WeatherCard(model: cubit.searchedCity!),
                      ],
                    );
                  } else if (cubit.defaultCities.isNotEmpty) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Text(
                            "Popular Cities",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...cubit.defaultCities
                            .map((model) => WeatherCard(model: model))
                            .toList(),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        "there is no data right now ,please try later",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                } else if (state is weatherFailure) {
                  print(state.errMessage);
                  return Center(
                    child: Text(
                      state.errMessage,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),

            
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
