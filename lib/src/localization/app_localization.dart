import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:topics/src/app/gloabl.dart';

class AppLocalization {
  static const Locale english = Locale('en', ''); // English, no country code
  static const Locale arabic = Locale('ar', ''); // Arabic, no country code
  static const supportedLocales = [
    english, // English, no country code
    arabic, // Arabic, no country code
  ];

  static AppLocalizations get translation => AppLocalizations.of(appContext)!;
}
