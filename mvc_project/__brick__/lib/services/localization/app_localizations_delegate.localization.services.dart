import 'package:flutter/material.dart';

import 'app_local.localization.services.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocale> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      true; //['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale localizations = new AppLocale(locale);
    await localizations.load();
    print("Load ${locale.languageCode}");
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
