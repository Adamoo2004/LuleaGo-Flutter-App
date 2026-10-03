import 'package:flutter/material.dart';

import '../models/trip.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Trip> trips;
  final void Function(String) onRemoveFavorite;
  final bool largeText;

  const FavoritesScreen({
    super.key,
    required this.trips,
    required this.onRemoveFavorite,
    required this.largeText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoriter'),
      ),
      body: trips.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Du har inga sparade favoriter ännu.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.red),
                    title: Text(trip.title),
                    subtitle: Text('${trip.route} • ${trip.durationMinutes} min'),
                    trailing: IconButton(
                      onPressed: () => onRemoveFavorite(trip.id),
                      icon: const Icon(Icons.delete_outline),
                      tooltip: 'Ta bort från favoriter',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
