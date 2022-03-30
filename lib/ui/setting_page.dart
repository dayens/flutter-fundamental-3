import 'package:flutter/material.dart';
import 'package:flutter_fundamental_3/provider/preferences_provider.dart';
import 'package:provider/provider.dart';
import '../provider/scheduling_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return Material(
            child: ListTile(
              title: const Text('Scheduling News'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                      value: provider.isDailyNewsActive,
                      onChanged: (value) async {
                        scheduled.scheduledNews(value);
                        provider.enableDailyNews(value);
                      }
                  );
                },
              ),
            ),
          );
        },
      )
    );
  }
}
