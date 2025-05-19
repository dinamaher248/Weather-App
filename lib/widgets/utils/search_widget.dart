import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../constant/colors.dart';
import '../../cubit/weather_cubit.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});
  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 59, 37, 78), Color(0xff1C1B33)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: TextField(
          controller: context.read<WeatherCubit>().cityName,
          onSubmitted: (value) {
            final cubit = context.read<WeatherCubit>();
            cubit.cityName.text = value.trim();
            cubit.SearchtWeather();
          },
          decoration: InputDecoration(
            hintText: 'Search for a city or airport',
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(
              Icons.search,
              size: 6.w,
              color: const Color.fromARGB(255, 180, 200, 230),
            ),
            suffixIcon: Icon(Icons.filter_list, size: 6.w, color: TextColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.w),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.w),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3.w),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.transparent,
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
