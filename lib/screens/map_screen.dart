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
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 40,
                top: 80,
                child: _MapMarker(label: 'LTU', color: Colors.teal),
              ),
              Positioned(
                right: 70,
                top: 250,
                child: _MapMarker(label: 'Centrum', color: Colors.orange),
              ),
              Positioned(
                left: 120,
                bottom: 130,
                child: _MapMarker(label: 'Busshållplats', color: Colors.indigo),
              ),
              Positioned(
                left: 90,
                top: 180,
                child: Container(
                  width: 220,
                  height: 180,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapMarker extends StatelessWidget {
  final String label;
  final Color color;

  const _MapMarker({
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
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(label),
        ),
      ],
    );
  }
}
