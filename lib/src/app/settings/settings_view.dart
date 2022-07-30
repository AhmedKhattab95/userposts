import 'package:flutter/material.dart';
import 'package:topics/src/app/theme/app_sizes.dart';
import 'package:topics/src/localization/app_localization.dart';
import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(AppLocalization.translation.settings),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: AppSizes.cardPadding,
                  // Glue the SettingsController to the theme selection DropdownButton.
                  //
                  // When a user selects a theme from the dropdown list, the
                  // SettingsController is updated, which rebuilds the MaterialApp.
                  child: DropdownButton<ThemeMode>(
                      // Read the selected themeMode from the controller
                      value: controller.themeMode,
                      // Call the updateThemeMode method any time the user selects a theme.
                      onChanged: controller.updateThemeMode,
                      items: [
                        DropdownMenuItem(value: ThemeMode.system, child: Text(AppLocalization.translation.systemTheme)),
                        DropdownMenuItem(value: ThemeMode.light, child: Text(AppLocalization.translation.lightTheme)),
                        DropdownMenuItem(value: ThemeMode.dark, child: Text(AppLocalization.translation.darkTheme))
                      ]),
                ),
                Padding(
                  padding: AppSizes.cardPadding,
                  // Glue the SettingsController to the theme selection DropdownButton.
                  //
                  // When a user selects a theme from the dropdown list, the
                  // SettingsController is updated, which rebuilds the MaterialApp.
                  child: DropdownButton<Locale>(
                      // Read the selected themeMode from the controller
                      value: controller.currentLocale,
                      // Call the updateThemeMode method any time the user selects a theme.
                      onChanged: controller.updateLocale,
                      items: [
                        DropdownMenuItem(
                            value: AppLocalization.english, child: Text(AppLocalization.translation.english)),
                        DropdownMenuItem(value: AppLocalization.arabic, child: Text(AppLocalization.translation.arabic))
                      ]),
                )
              ],
            ),
          );
        });
  }
}
