import 'package:flutter/material.dart';
import 'package:topics/src/app/managers/managers_lib.dart';

/// A service that stores and retrieves user settings.
///
/// By default, this class does not persist user settings. If you'd like to
/// persist the user settings locally, use the shared_preferences package. If
/// you'd like to store settings on a web server, use the http package.
abstract class SettingsService {
  /// Loads the User's preferred ThemeMode from local or remote storage.
  Future<ThemeMode> get themeMode;

  /// Persists the user's preferred ThemeMode to local or remote storage.
  Future<void> updateThemeMode(ThemeMode theme);

  /// Persists the user's selected language
  Future<void> updateSelectedLanguage(Locale locale);
}

class SettingsServiceImpl implements SettingsService {
  final CacheManager _cacheManager;

  SettingsServiceImpl(this._cacheManager);

  @override
  Future<ThemeMode> get themeMode async => ThemeMode.system;

  /// Persists the user's preferred ThemeMode to local or remote storage.
  @override
  Future<void> updateThemeMode(ThemeMode theme) async {
    // Use the shared_preferences package to persist settings locally or the
    // http package to persist settings over the network.
  }

  @override
  Future<void> updateSelectedLanguage(Locale locale) async {
    await _cacheManager.saveUserSelectedLanguage(locale.toLanguageTag());
  }
}
