import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Function(int) onNavigate;
  final List trips;
  final List favoriteTrips;
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
    final textStyle = largeText ? Theme.of(context).textTheme : Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('LuleåGo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Välkommen, student!',
                style: textStyle.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Här finns snabba resor runt i Luleå.',
                style: textStyle.bodyLarge,
              ),
              const SizedBox(height: 20),
              _QuickCard(
                title: 'Kommande resor',
                subtitle: '${trips.length} alternativ idag',
                icon: Icons.directions_bus,
                onTap: () => onNavigate(1),
              ),
              const SizedBox(height: 12),
              _QuickCard(
                title: 'Favoriter',
                subtitle: '${favoriteTrips.length} sparade resor',
                icon: Icons.favorite,
                onTap: () => onNavigate(3),
              ),
              const SizedBox(height: 12),
              _QuickCard(
                title: 'Karta',
                subtitle: 'Se viktiga platser',
                icon: Icons.map,
                onTap: () => onNavigate(2),
              ),
            ],
          ),
        ),
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
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
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
