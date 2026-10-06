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
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final trip = trips[index];
          final isFavorite = favoriteIds.contains(trip.id);

          return InkWell(
            onTap: () {
              _showTripDetails(context, trip);
            },
            borderRadius: BorderRadius.circular(22),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(12),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        trip.type == 'Buss'
                            ? Icons.directions_bus
                            : trip.type == 'Cykel'
                                ? Icons.directions_bike
                                : Icons.directions_walk,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  trip.title,
                                  style: Theme.of(context).textTheme.titleLarge,
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
                          const SizedBox(height: 6),
                          Text(
                            '${trip.from} → ${trip.to}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: [
                              _InfoChip(label: '${trip.departure} avgång'),
                              _InfoChip(label: '${trip.durationMinutes} min'),
                              _InfoChip(label: '${trip.price} kr'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${trip.stop} • ${trip.rating}/5 betyg',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showTripDetails(BuildContext context, Trip trip) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(trip.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Från: ${trip.from}'),
            const SizedBox(height: 8),
            Text('Till: ${trip.to}'),
            const SizedBox(height: 8),
            Text('Avgång: ${trip.departure}'),
            const SizedBox(height: 8),
            Text('Restid: ${trip.durationMinutes} minuter'),
            const SizedBox(height: 8),
            Text('Hållplats: ${trip.stop}'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pris:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${trip.price} kr',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Avbryt'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Biljett köpt för ${trip.title} - ${trip.price} kr'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Köp biljett'),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label),
    );
  }
}
