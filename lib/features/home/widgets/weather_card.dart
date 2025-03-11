import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:idealake_weather_app/core/constants/app_colors.dart';
import 'package:idealake_weather_app/core/constants/app_strings.dart';
import 'package:idealake_weather_app/core/global/global_variables.dart';
import 'package:idealake_weather_app/features/home/models/weather_model.dart';

class WeatherCard extends StatefulWidget {
  final String searchText;
  final List<WeatherModel> listOfWeather;
  const WeatherCard(
      {super.key, required this.listOfWeather, required this.searchText});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String unit = displayByFahrenheit ? "°F" : "°C";

  @override
  Widget build(BuildContext context) {
    // print(DateTime.fromMillisecondsSinceEpoch(
    //     widget.listOfWeather[2].date! * 1000,
    //     isUtc: false));
    // print(widget.listOfWeather[0].locName);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 15),
          (widget.searchText.isNotEmpty)
              ? Text(
                  widget.listOfWeather[0].locName!,
                  style: Theme.of(context).textTheme.headlineLarge,
                )
              : const Text(""),
          const SizedBox(height: 50),
          Text(
            forecastTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.listOfWeather.length,
              itemBuilder: (context, index) {
                return cardForEachDay(data: widget.listOfWeather[index]);
                // widget.listOfWeather
                //     .map((eachData) => cardForEachDay(data: eachData))
                //     .toList();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget cardForEachDay({required WeatherModel data}) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(data.date! * 1000, isUtc: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.4,
              width: MediaQuery.of(context).size.width / 1.25,
              decoration: BoxDecoration(
                color: AppColors().cardColor.withOpacity(0.25),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 150,
                            child: Image.network(
                              "https://openweathermap.org/img/wn/${data.iconImage}@2x.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            data.description!,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${data.temp!.round()} $unit",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${data.humidity} %",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "${dateTime.day}  ${getMonthInWords(dateTime)}  ${dateTime.year}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
