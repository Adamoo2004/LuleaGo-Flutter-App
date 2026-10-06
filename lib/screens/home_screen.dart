import 'package:flutter/material.dart';

import '../models/trip.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;
  final List<Trip> trips;
  final List<Trip> favoriteTrips;
  final bool largeText;

  const HomeScreen({
    super.key,
    required this.onNavigate,
    required this.trips,
    required this.favoriteTrips,
    required this.largeText,
  });

  @override
  Widget build(BuildContext context) {
    final nextTrip = trips.isNotEmpty ? trips.first : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LuleåGo'),
        actions: [
          IconButton(
            onPressed: () => onNavigate(4),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Välkommen, student!',
                style: largeText
                    ? Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )
                    : Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
              ),
              const SizedBox(height: 8),
              Text(
                'Planera dina resor snabbt och enkelt i Luleå.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.schedule, color: Colors.white),
                        const SizedBox(width: 8),
                        const Text(
                          'Nästa resa',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (nextTrip != null) ...[
                      Text(
                        '${nextTrip.title} • ${nextTrip.departure}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${nextTrip.from} → ${nextTrip.to}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () => onNavigate(1),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Visa resor'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Resor idag',
                      value: '${trips.length}',
                      icon: Icons.directions_transit,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      title: 'Favoriter',
                      value: '${favoriteTrips.length}',
                      icon: Icons.favorite,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Snabbmeny',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              _QuickCard(
                title: 'Kommande resor',
                subtitle: 'Se alla alternativ för idag',
                icon: Icons.directions_bus,
                onTap: () => onNavigate(1),
              ),
              const SizedBox(height: 12),
              _QuickCard(
                title: 'Karta',
                subtitle: 'Visa viktiga platser i Luleå',
                icon: Icons.map,
                onTap: () => onNavigate(2),
              ),
              const SizedBox(height: 12),
              _QuickCard(
                title: 'Favoriter',
                subtitle: 'Dina sparade resor',
                icon: Icons.favorite,
                onTap: () => onNavigate(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 4),
          Text(title),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
