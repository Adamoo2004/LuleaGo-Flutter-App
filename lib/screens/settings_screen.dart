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
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Studentprofil'),
              subtitle: const Text('Luleå universitet'),
            ),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            title: const Text('Mörkt läge'),
            subtitle: const Text('Anpassa appens tema'),
            value: darkMode,
            onChanged: onDarkModeChanged,
            secondary: const Icon(Icons.dark_mode),
          ),
          SwitchListTile(
            title: const Text('Större text'),
            subtitle: const Text('För bättre läsbarhet'),
            value: largeText,
            onChanged: onLargeTextChanged,
            secondary: const Icon(Icons.text_fields),
          ),
          SwitchListTile(
            title: const Text('Aviseringar'),
            subtitle: const Text('Påminnelser om kommande resor'),
            value: notifications,
            onChanged: onNotificationsChanged,
            secondary: const Icon(Icons.notifications_active),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Språk'),
            subtitle: const Text('Svenska'),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: const Icon(Icons.accessibility_new),
            title: const Text('Tillgänglighet'),
            subtitle: const Text('Stor text, tydliga ikoner'),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
