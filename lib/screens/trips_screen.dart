import 'package:flutter/material.dart';

import '../models/trip.dart';

class TripsScreen extends StatelessWidget {
  final List<Trip> trips;
  final List<String> favoriteIds;
  final void Function(String) onToggleFavorite;
  final bool largeText;

  const TripsScreen({
    super.key,
    required this.trips,
    required this.favoriteIds,
    required this.onToggleFavorite,
    required this.largeText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resor'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          final isFavorite = favoriteIds.contains(trip.id);

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Du valde ${trip.title} – ${trip.route}'),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          trip.type == 'Buss'
                              ? Icons.directions_bus
                              : trip.type == 'Cykel'
                                  ? Icons.directions_bike
                                  : Icons.directions_walk,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trip.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              trip.route,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${trip.durationMinutes} min • ${trip.stop}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => onToggleFavorite(trip.id),
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : null,
                        ),
                        tooltip: isFavorite ? 'Ta bort favorit' : 'Lägg till favorit',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
