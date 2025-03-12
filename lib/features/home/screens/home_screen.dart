import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idealake_weather_app/core/global/global_variables.dart';
import 'package:idealake_weather_app/features/home/widgets/weather_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  List<String> _searchHistory = [];
  List<String> _filteredResults = [];

  @override
  void initState() {
    super.initState();

    checkTempUnit();
    _loadSearchHistory();
  }

  checkTempUnit() async {
    displayByFahrenheit = await getTempUnitValue();
  }

  /// SEARCH..
  // Load search history from SharedPreferences
  Future<void> _loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _searchHistory = prefs.getStringList(keyForSearch) ?? [];
      _filteredResults = _searchHistory;
    });
  }

  // Function to handle search text input and filter history
  void _onSearchChanged(String query) {
    setState(() {
      _filteredResults = _searchHistory
          .where((term) => term.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Function to add a search term to the history and update SharedPreferences
  void _saveSearch(String searchTerm) {
    if (!_searchHistory.contains(searchTerm)) {
      setState(() {
        _searchHistory.add(searchTerm);
        _filteredResults = _searchHistory;
      });
      saveToRecentSearches(searchTerm);
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(DateTime.fromMillisecondsSinceEpoch(1741953600 * 1000, isUtc: false));
    // print(displayByFahrenheit);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ?
            // search bar to filter list...
            fieldToSearchCity()
            : Text(appName),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              // print(_searchHistory);
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear(); // Clear the search query

                  BlocProvider.of<HomeBloc>(context).add(HomeFetchDataEvent(
                    currentPosition!.latitude,
                    currentPosition!.longitude,
                  ));
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          decorativeWidget(),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading || state is HomeInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeError) {
                return Center(child: Text(state.message));
              } else if (state is HomeLoaded) {
                return WeatherCard(
                  listOfWeather: state.data,
                  searchText: _searchController.text,
                );
              } else {
                return Center(child: Text(noDataText));
              }
            },
          ),

          /// display list of recently searched history...
          _isSearching ? recentSearchListDisplay() : const SizedBox(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            displayByFahrenheit = !displayByFahrenheit;
          });
          storeTempUnitValue(displayByFahrenheit);

          BlocProvider.of<HomeBloc>(context).add(ToggleTempUnitEvent(
            isSearchQuery: _isSearching,
            searchedQuery: _searchController.text,
            lat: currentPosition!.latitude,
            long: currentPosition!.longitude,
          ));
        },
        child: const Icon(Icons.ac_unit_rounded),
      ),
    );
  }

  Widget fieldToSearchCity() {
    return TextField(
      autofocus: true,
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search City...',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors().primaryColor,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors().primaryColor,
            width: 4,
          ),
        ),
      ),
      onChanged: _onSearchChanged,
      onSubmitted: (query) {
        context.read<HomeBloc>().add(HomeSearchDataEvent(query));
        setState(() {
          _isSearching = false;
        });

        _saveSearch(query);
      },
    );
  }

  Widget recentSearchListDisplay() {
    return Container(
      color: AppColors().backgroundColor,
      child: ListView.builder(
        itemCount: _filteredResults.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _searchController.text = _filteredResults[index];
              _onSearchChanged(_filteredResults[index]);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 25),
              child: Text(
                _filteredResults[index],
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget decorativeWidget() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.height / 3.4,
        height: MediaQuery.of(context).size.height / 3.4,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [
              AppColors().primaryColor,
              AppColors().accentColor,
            ])),
      ),
    );
  }
}
