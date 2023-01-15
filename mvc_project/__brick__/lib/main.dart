import 'services/app_config.service.dart';
import 'services/beamer.service.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tecfy_basic_package/tecfy_basic_package.dart';

import 'services/localization/app_localizations_delegate.localization.services.dart';

void main() async {
  await ConfigService.init();
  WidgetsFlutterBinding.ensureInitialized();
  Beamer.setPathUrlStrategy();
  runApp(const RestartWidget(MyApp()));
}

class AppScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: AppScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Kafarat Plus',
      // theme: ThemeData(
      //   fontFamily: "Tajawal",
      //   primarySwatch: createMaterialColor(ConstantsService.mainColor),
      //   textTheme: Theme.of(context)
      //       .textTheme
      //       .apply(fontSizeFactor: 0.8, fontFamily: "Tajawal"),
      // ),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizationsDelegate()
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        AppConfigService.supportedAppLocale ??= [];
        AppConfigService.supportedAppLocale = supportedLocales.toList();
        var lang = AppConfigService.language;
        if (AppConfigService.language == '') {
          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode ||
                supportedLocale.countryCode == locale?.countryCode) {
              AppConfigService.language = supportedLocale.languageCode;
              lang = supportedLocale.languageCode;
              return supportedLocale;
            }
          }
        } else {
          var local = supportedLocales
              .where((element) => element.languageCode == lang)
              .first;
          return local;
        }
      },
      routerDelegate: BeamerService.routerDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: BeamerService.routerDelegate,
        alwaysBeamBack: true,
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget(this.child, {super.key});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  State<RestartWidget> createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = Set();
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}

extension FixNum<E> on double {
  double fixnum() => ((this * 100).ceil()) / 100;
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

extension MapHelpers on Map {
  String? display() {
    if (this[AppConfigService.language] == null ||
        this[AppConfigService.language] == '') {
      var x = AppConfigService.supportedAppLocale
          ?.where(
              (element) => element.languageCode != AppConfigService.language)
          .first
          .languageCode;
      return this[x];
    } else {
      return this[AppConfigService.language];
    }
  }
}
