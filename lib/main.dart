import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:topics/src/app/settings/settings_controller.dart';
import 'package:topics/src/core/core_lib.dart';

import 'src/app.dart';
import 'src/app/setup_depedndacies.dart';

void main() async {
  // await runZonedGuarded(
  //   () async {
      WidgetsFlutterBinding.ensureInitialized();
      await AppSetup.instance.setup();

      var settingsController = serviceLocator<SettingsController>();
      await settingsController.loadSettings();
      // Load the user's preferred theme while the splash screen is displayed.
      // This prevents a sudden theme change when the app is first displayed.

      // Run the app and pass in the SettingsController. The app listens to the
      // SettingsController for changes, then passes it further down to the
      // SettingsView.
      runApp(ProviderScope(child: MyApp(settingsController: settingsController)));
  //   },
  //   (error, stackTrace) => print(error.toString()),
  // );
}
