import 'package:flutter/material.dart';
import 'package:topics/src/app/managers/managers_lib.dart';
import 'package:topics/src/localization/app_localization.dart';
import 'package:topics/src/core/core_lib.dart';
import 'settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;
  final CacheManager _cacheManager;

  SettingsController(this._settingsService, this._cacheManager);

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode;
    await _loadSystemLocal();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }

  ///region Language
  Locale _locale = const Locale('en');

  Locale get currentLocale => _locale;

  Future<void> updateLocale(Locale? value) async {
    if (value == null) return;
    _locale = value;
    await _saveLocaleInCache(value);
    notifyListeners();
  }

  bool isSameLanguageCode(Locale locale) => _locale == locale;

  Future<void> _saveLocaleInCache(Locale value) async {
    await _cacheManager.saveUserSelectedLanguage(value.languageCode);
  }

  TextDirection get direction => isSameLanguageCode(const Locale('ar')) ? TextDirection.rtl : TextDirection.ltr;

  TextDirection get directionReverse => isSameLanguageCode(const Locale('ar')) ? TextDirection.ltr : TextDirection.rtl;

  TextAlign get textAlign => isSameLanguageCode(const Locale('ar')) ? TextAlign.right : TextAlign.left;

  Alignment getStackTopRightAlign() {
    if (direction == TextDirection.ltr) return Alignment.topRight;
    return Alignment.topLeft;
  }

  Future<bool> isLanguageSavedInCache() async {
    var lang = await _cacheManager.getUserSelectedLanguage();
    return !lang.isNullOrEmpty();
  }

  EdgeInsets getRightPadding(double rightPadding) {
    if (direction == TextDirection.ltr) return EdgeInsets.only(right: rightPadding);
    return EdgeInsets.only(left: rightPadding);
  }

  Future<void> _loadSystemLocal() async {
    String? language = await _cacheManager.getUserSelectedLanguage();
    if (language == null) {
      _locale = AppLocalization.english;
    } else {
      _locale = Locale(language, '');
    }
  }

  ///endregion

}
