import 'package:idealake_weather_app/features/home/models/weather_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<WeatherModel> data;

  HomeLoaded({required this.data});
}

// class HomeSearched extends HomeState {
//   final List<WeatherModel> filterData;

//   HomeSearched({required this.filterData});
// }

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
