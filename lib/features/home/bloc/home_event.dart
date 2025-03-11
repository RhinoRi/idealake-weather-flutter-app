abstract class HomeEvent {}

class HomeFetchDataEvent extends HomeEvent {
  final double latitude;
  final double longitude;
  HomeFetchDataEvent(this.latitude, this.longitude);
}

class HomeSearchDataEvent extends HomeEvent {
  final String query;
  HomeSearchDataEvent(this.query);
}

class ToggleTempUnitEvent extends HomeEvent {
  final bool isSearchQuery;
  final String searchedQuery;
  final double lat;
  final double long;
  ToggleTempUnitEvent({
    required this.isSearchQuery,
    required this.searchedQuery,
    required this.lat,
    required this.long,
  });
}
