import 'package:flutter/material.dart';

import 'package:tecfy_basic_package/tecfy_basic_package.dart';

import '../models/customer.model.dart';

class AppConfigService {
  static List<Locale>? supportedAppLocale;
  static String get language => ConfigService.getValueString('language');
  static set language(v) => ConfigService.setValueString('language', v);
  static Customer? get customer => ConfigService.getValueMap('customer').isEmpty
      ? null
      : Customer.fromJson(ConfigService.getValueMap('customer'));

  static void setCustomer(Map<dynamic, dynamic>? customerData) async =>
      await ConfigService.setValueMap('customer', customerData ?? {});

  static bool get isArabic {
    if (language == 'ar') {
      return true;
    } else {
      return false;
    }
  }

  static String? get _accountType => customer?.type;
}
