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
  Trip? _purchasedTrip;

  final List<Trip> _trips = [
    Trip(
      id: '1',
      title: 'Buss 1',
      from: 'Studentbostad',
      to: 'Universitetet',
      departure: '08:15',
      durationMinutes: 12,
      stop: 'Luleå Södra',
      type: 'Buss',
      price: 28,
      rating: 4,
      description: 'Direkt resa till campus via centrum.',
    ),
    Trip(
      id: '2',
      title: 'Buss 4',
      from: 'Bergnäset',
      to: 'LTU',
      departure: '08:40',
      durationMinutes: 18,
      stop: 'Kyrkogatan',
      type: 'Buss',
      price: 32,
      rating: 5,
      description: 'Snabb och enkel resa för studerande.',
    ),
    Trip(
      id: '5',
      title: 'Buss 7',
      from: 'Norrbotten',
      to: 'City Center',
      departure: '10:05',
      durationMinutes: 15,
      stop: 'Storgatan',
      type: 'Buss',
      price: 20,
      rating: 4,
      description: 'Tålig och enkel resa in till centrum.',
    ),
    Trip(
      id: '6',
      title: 'Buss 2',
      from: 'Malmvägen',
      to: 'Campus',
      departure: '11:20',
      durationMinutes: 16,
      stop: 'Centralstationen',
      type: 'Buss',
      price: 24,
      rating: 4,
      description: 'Bra alternativ för studenter som åker till undervisning.',
    ),
  ];

  final List<String> _favoriteTripIds = ['1'];

  void _toggleFavorite(String tripId) {
    setState(() {
      if (_favoriteTripIds.contains(tripId)) {
        _favoriteTripIds.remove(tripId);
      } else {
        _favoriteTripIds.add(tripId);
      }
    });
  }

  void _purchaseTrip(Trip trip) {
    setState(() {
      _purchasedTrip = trip;
    });
  }

  List<Trip> get _favoriteTrips =>
      _trips.where((trip) => _favoriteTripIds.contains(trip.id)).toList();

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        trips: _trips,
        favoriteTrips: _favoriteTrips,
        onNavigate: _changeTab,
        largeText: _largeText,
        purchasedTrip: _purchasedTrip,
      ),
      TripsScreen(
        trips: _trips,
        favoriteIds: _favoriteTripIds,
        onToggleFavorite: _toggleFavorite,
        largeText: _largeText,
        onTripPurchased: _purchaseTrip,
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
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF10131B),
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: _largeText
                ? const TextScaler.linear(1.12)
                : TextScaler.noScaling,
          ),
          child: child!,
        );
      },
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: screens,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _changeTab,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Hem',
            ),
            NavigationDestination(
              icon: Icon(Icons.directions_transit_outlined),
              selectedIcon: Icon(Icons.directions_transit),
              label: 'Resor',
            ),
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map),
              label: 'Karta',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favoriter',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Inställningar',
            ),
          ],
        ),
      ),
    );
  }
}
