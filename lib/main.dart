import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_app/presentation/bloc/watchlist_event.dart';
import 'core/theme/app_colors.dart';
import 'data/repositories/watchlist_repository.dart';
import 'presentation/bloc/watchlist_bloc.dart';
import 'presentation/screens/main_watchlist_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '021 Trade Watchlist',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Apply centralized theme here
      home: RepositoryProvider(
        create: (context) => WatchlistRepository(),
        child: BlocProvider(
          create: (context) => WatchlistBloc(
            repository: context.read<WatchlistRepository>(),
          )..add(LoadWatchlist()),
          child: const MainWatchlistScreen(),
        ),
      ),
    );
  }
}