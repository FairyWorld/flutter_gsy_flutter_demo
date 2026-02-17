import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gsy_flutter_demo/home/demo_home_page.dart';
import 'package:gsy_flutter_demo/l10n/app_localizations.dart';
import 'package:gsy_flutter_demo/routes/demo_routes.dart';

void main() {
  runApp(const MyApp());
  WidgetsBinding.instance.addObserver(ReferrerObserver());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void _toggleLocale() {
    final current = _locale?.languageCode;
    setState(() {
      _locale = current == 'en' ? const Locale('zh') : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('zh'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(splashFactory: NoSplash.splashFactory),
        ),
      ),
      home: DemoHomePage(
        routes: demoRoutes,
        onToggleLocale: _toggleLocale,
        isEnglish:
            (_locale ?? WidgetsBinding.instance.platformDispatcher.locale)
                    .languageCode ==
                'en',
      ),
      routes: demoRoutes,
    );
  }
}

class ReferrerObserver with WidgetsBindingObserver {
  @override
  Future<bool> didPushRouteInformation(
      RouteInformation routeInformation) async {
    if (kDebugMode) {
      print('didPushRouteInformation ${routeInformation.uri}');
    }
    return false;
  }
}
