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
                  'Du har inga sparade favoriter än.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: trips.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final trip = trips[index];

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.favorite, color: Colors.red),
                    title: Text(trip.title),
                    subtitle: Text('${trip.from} → ${trip.to} • ${trip.durationMinutes} min'),
                    trailing: IconButton(
                      onPressed: () => onRemoveFavorite(trip.id),
                      icon: const Icon(Icons.delete_outline),
                      tooltip: 'Ta bort favorit',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
