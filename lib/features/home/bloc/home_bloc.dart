import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idealake_weather_app/core/constants/app_strings.dart';
import '../repository/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeFetchDataEvent>(_fetchDataForHome);
    on<HomeSearchDataEvent>(_fetchSearchedData);
    on<ToggleTempUnitEvent>(_fetchToggledData);
  }

  HomeRepository homeRes = HomeRepository();

  // fetch current location weather data...
  _fetchDataForHome(HomeFetchDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final data = await homeRes.fetchHomeCurrentData(
          lat: event.latitude, long: event.longitude);

      emit(HomeLoaded(data: data));
    } catch (e) {
      emit(HomeError(message: errorTextForCurrent));
    }
  }

  // fetch only Searched City weather data...
  _fetchSearchedData(HomeSearchDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final filterData = await homeRes.fetchHomeSearchedData(city: event.query);

      emit(HomeLoaded(data: filterData));
    } catch (e) {
      // print(e);
      emit(HomeError(message: errorTextForCity));
    }
  }

  // fetch data when unit of temperature toggled
  _fetchToggledData(ToggleTempUnitEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      if (event.isSearchQuery) {
        add(HomeSearchDataEvent(event.searchedQuery));
      } else {
        add(HomeFetchDataEvent(event.lat, event.long));
      }
    } catch (e) {
      emit(HomeError(message: "$e"));
    }
  }
}
