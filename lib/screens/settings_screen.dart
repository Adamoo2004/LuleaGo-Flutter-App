import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final bool darkMode;
  final bool largeText;
  final bool notifications;
  final ValueChanged<bool> onDarkModeChanged;
  final ValueChanged<bool> onLargeTextChanged;
  final ValueChanged<bool> onNotificationsChanged;

  const SettingsScreen({
    super.key,
    required this.darkMode,
    required this.largeText,
    required this.notifications,
    required this.onDarkModeChanged,
    required this.onLargeTextChanged,
    required this.onNotificationsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inställningar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Mörkt läge'),
            subtitle: const Text('Ändra appens tema'),
            value: darkMode,
            onChanged: onDarkModeChanged,
            secondary: const Icon(Icons.dark_mode),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Större text'),
            subtitle: const Text('Ökar läsbarheten'),
            value: largeText,
            onChanged: onLargeTextChanged,
            secondary: const Icon(Icons.text_fields),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Aviseringar'),
            subtitle: const Text('Mottag reminder om resor'),
            value: notifications,
            onChanged: onNotificationsChanged,
            secondary: const Icon(Icons.notifications_active),
          ),
        ],
      ),
    );
  }
}
