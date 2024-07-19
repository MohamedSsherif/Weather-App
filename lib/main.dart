import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/views/home_view.dart';
import 'package:weather_app/views/search_view.dart';

void main() {
  runApp(
    //  MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (context) => WeatherProvider()),
    //     BlocProvider(create: (context) => WeatherCubit(WeatherService())),
    //   ],
     BlocProvider(
    create: (context) {
      return WeatherCubit(
        WeatherService(),
      );
    },
    child: WeatherApp(),
  ));
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit,WeatherState >(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch:
                BlocProvider.of<WeatherCubit>(context).weatherModel == null
                    ? Colors.blue
                    : BlocProvider.of<WeatherCubit>(context)
                        .weatherModel!
                        .getThemeColor(),
          ),
          home: HomePage(),
        );
      },
    );
  }
}
