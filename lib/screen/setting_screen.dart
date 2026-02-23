import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting_screen';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Consumer<SettingProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                title: Text(
                  "Dark Theme",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  "Enable dark mode",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                activeThumbColor: Theme.of(context).colorScheme.secondary,
                value: provider.isDarkTheme,
                onChanged: (value) {
                  provider.enabledarkTheme(value);
                },
              ),
              const Divider(),
              SwitchListTile(
                title: Text(
                  "Restaurant Notification",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  "Enable daily notification at 11:00 AM",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                value: provider.isReminderActive,
                activeThumbColor: Theme.of(context).colorScheme.secondary,
                onChanged: (value) {
                  provider.enableDailyReminder(value);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
