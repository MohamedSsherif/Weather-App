import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/views/search_view.dart';

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }));
              },
              icon: const Icon(Icons.search),
            ),
          ],
          title: const Text('Weather App'),
          backgroundColor:
              weatherData == null ? Colors.blue : weatherData!.getThemeColor(),
        ),
        body: BlocBuilder<WeatherCubit,WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherSuccess) {
              BlocProvider.of<WeatherCubit>(context).weatherModel;
              return SuccessBody(weatherData: weatherData);
            } else if (state is WeatherFailure) {
              return DefaultHomePage();
            } else {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'there is no weather 😔 start',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'searching now 🔍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}

class DefaultHomePage extends StatelessWidget {
  const DefaultHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'something went wrong 😔 start searching now 🔍',
    ));
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return  
    Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            weatherData!.getThemeColor(),
            weatherData!.getThemeColor()[300]!,
            weatherData!.getThemeColor()[100]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Text(
              BlocProvider.of<WeatherCubit>(context).cityName!,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(weatherData!.getImage()),
                Text(
                  weatherData!.temp.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                    Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              weatherData!.weatherStateName,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      
    );
  }
}