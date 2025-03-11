import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idealake_weather_app/core/theme/app_theme.dart';
import 'package:idealake_weather_app/features/home/bloc/home_bloc.dart';
import 'package:idealake_weather_app/features/home/screens/home_screen.dart';

import 'core/constants/app_strings.dart';
import 'core/global/global_variables.dart';
import 'core/services/current_location_services.dart';
import 'features/home/bloc/home_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request location permission and get the current position
  currentPosition = await getCurrentLocation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // print(currentPosition);
    return MaterialApp(
      title: appName,
      theme: AppTheme.appMainTheme,
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context) => HomeBloc()
            ..add(
              HomeFetchDataEvent(
                currentPosition!.latitude,
                currentPosition!.longitude,
              ),
            ),
          child: const HomeScreen()),
    );
  }
}
