import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(12),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
              Positioned(
                left: 24,
                top: 30,
                child: _MapLocation(label: 'LTU', color: Colors.teal),
              ),
              Positioned(
                right: 30,
                top: 120,
                child: _MapLocation(label: 'Centrum', color: Colors.orange),
              ),
              Positioned(
                left: 70,
                bottom: 90,
                child: _MapLocation(label: 'Bostad', color: Colors.indigo),
              ),
              Positioned(
                left: 110,
                top: 180,
                child: _MapLocation(label: 'Busshållplats', color: Colors.purple),
              ),
              Positioned(
                left: 90,
                top: 170,
                child: Container(
                  width: 190,
                  height: 170,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500, width: 2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 90,
                child: Container(
                  width: 220,
                  height: 2,
                  color: Colors.grey.shade400,
                ),
              ),
              Positioned(
                left: 150,
                top: 180,
                child: Container(
                  width: 2,
                  height: 130,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapLocation extends StatelessWidget {
  final String label;
  final Color color;

  const _MapLocation({
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: color.withAlpha(35),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(label),
        ),
      ],
    );
  }
}
