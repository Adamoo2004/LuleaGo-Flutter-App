import 'package:flutter/material.dart';

import 'models/trip.dart';
import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/map_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/trips_screen.dart';

void main() {
  runApp(const LuleaGoApp());
}

class LuleaGoApp extends StatefulWidget {
  const LuleaGoApp({super.key});

  @override
  State<LuleaGoApp> createState() => _LuleaGoAppState();
}

class _LuleaGoAppState extends State<LuleaGoApp> {
  int _selectedIndex = 0;
  bool _darkMode = false;
  bool _largeText = false;
  bool _notifications = true;

  final List<Trip> _trips = [
    Trip(
      id: '1',
      title: 'Buss 1',
      route: 'Universitetet → City Center',
      durationMinutes: 12,
      stop: 'Busshållplats Luleå Södra',
      type: 'Buss',
    ),
    Trip(
      id: '2',
      title: 'Buss 4',
      route: 'Bergnäset → LTU',
      durationMinutes: 18,
      stop: 'Kyrkogatan',
      type: 'Buss',
    ),
    Trip(
      id: '3',
      title: 'Cykel',
      route: 'Studentbostad → Campus',
      durationMinutes: 10,
      stop: 'Cykelparkering',
      type: 'Cykel',
    ),
    Trip(
      id: '4',
      title: 'Promenad',
      route: 'Kulturhuset → Universitetet',
      durationMinutes: 22,
      stop: 'Entrévägen',
      type: 'Promenad',
    ),
  ];

  final List<String> _favoriteTripIds = [];

  void _toggleFavorite(String tripId) {
    setState(() {
      if (_favoriteTripIds.contains(tripId)) {
        _favoriteTripIds.remove(tripId);
      } else {
        _favoriteTripIds.add(tripId);
      }
    });
  }

  List<Trip> get _favoriteTrips {
    return _trips.where((trip) => _favoriteTripIds.contains(trip.id)).toList();
  }

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        onNavigate: _changeTab,
        trips: _trips,
        favoriteTrips: _favoriteTrips,
        largeText: _largeText,
      ),
      TripsScreen(
        trips: _trips,
        favoriteIds: _favoriteTripIds,
        onToggleFavorite: _toggleFavorite,
        largeText: _largeText,
      ),
      const MapScreen(),
      FavoritesScreen(
        trips: _favoriteTrips,
        onRemoveFavorite: _toggleFavorite,
        largeText: _largeText,
      ),
      SettingsScreen(
        darkMode: _darkMode,
        largeText: _largeText,
        notifications: _notifications,
        onDarkModeChanged: (value) => setState(() => _darkMode = value),
        onLargeTextChanged: (value) => setState(() => _largeText = value),
        onNotificationsChanged: (value) => setState(() => _notifications = value),
      ),
    ];

    return MaterialApp(
      title: 'LuleåGo',
      debugShowCheckedModeBanner: false,
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        textTheme: _largeText
            ? ThemeData.light().textTheme.apply(fontSizeFactor: 1.2)
            : ThemeData.light().textTheme,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: _largeText
            ? ThemeData.dark().textTheme.apply(fontSizeFactor: 1.2)
            : ThemeData.dark().textTheme,
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _changeTab,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Hem'),
            NavigationDestination(icon: Icon(Icons.directions_transit_outlined), selectedIcon: Icon(Icons.directions_transit), label: 'Resor'),
            NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: 'Karta'),
            NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Favoriter'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Inställningar'),
          ],
        ),
      ),
    );
  }
}
