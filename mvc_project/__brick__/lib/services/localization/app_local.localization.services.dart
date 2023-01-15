import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tecfy_basic_package/tecfy_basic_package.dart';

abstract class ITranslateService {
  Map<String, dynamic> getJson(language);
}

class AppLocale {
  AppLocale(this.locale);

  static StreamController? _languageStreamController;

  static StreamController get languageStreamController {
    if (_languageStreamController == null) {
      _languageStreamController = StreamController();
    }
    return _languageStreamController ?? StreamController();
  }

  static Stream? _languageStream;

  static Stream get languageStream {
    if (_languageStreamController == null) {
      _languageStreamController = StreamController();
    }
    if (_languageStream == null) {
      _languageStream = _languageStreamController?.stream.asBroadcastStream();
    }
    return _languageStream ??
        languageStreamController.stream.asBroadcastStream();
  }

  final Locale? locale;
  static AppLocale? appLocale;

  static AppLocale? of(BuildContext? context) {
    if (appLocale != null) return appLocale;
    if (context == null) {
      print('+++++++++++++++ NULLLLLLLLLLLLLL');
      return new AppLocale(null);
    }
    var result = Localizations.of<AppLocale>(context, AppLocale);
    if (result == null)
      print('+++++++++++++++++ class is null');
    else
      appLocale = result;
    return result;
  }

  static Map<String, dynamic>? _sentences;

  Future<bool> load() async {
    //from file
    //String data = await rootBundle.loadString('resources/lang/${this.locale.languageCode}.json');
    //from databse
    //print('================== Start Loading the language (${LocalConfigService.language})  isArabic = ${LocalConfigService.isArabic}');
    // Firestore.instance.document('languages/${this.locale.languageCode}/translation/default').snapshots().listen((onData){
    //   this._sentences = onData.data;
    await ConfigService.init();

    // });
    //var language = await Firestore.instance.document('languages/ar').get();
    //print('================== got some data');
    //print(language.data);
    //print(language.data['Driver']);
    _sentences = locale!.languageCode == 'ar'
        ? {
            'Login': 'تسجيل الدخول',
          }
        : {};
    //print(this._sentences.keys.length);
    return true;

    // var language = await Firestore.instance.document('languages/default').get();
    // String data = language.data[this.locale.languageCode].toString();

    // this._sentences = json.decode(data);
    // return true;
  }

  static String translate(BuildContext? context, String? key) {
    if (TecfyBasicApp.isTest) return key ?? '';
    if (context == null || key == null) return key ?? '[NULL]';

    var cls = of(context);
    if (cls == null) return key;

    return cls.trans(key);
  }

  String trans(String? key) {
    //print('+++++++++++++++ get lang $key');
    if (key == null) return '';
    try {
      if (_sentences == null) {
        print('_sentences is null');
        return key;
      }
      return (_sentences?.containsKey(key) ?? false)
          ? (_sentences?[key] ?? key)
          : key;
    } catch (ex) {
      print('trans error : $ex');
      return key;
    }
  }
}
