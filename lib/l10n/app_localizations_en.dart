// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GSY Flutter Demo';

  @override
  String get homeSubtitle =>
      'Browse by category, search quickly, and open examples in one tap.';

  @override
  String get allExamples => 'All examples';

  @override
  String get filteredResults => 'Filtered';

  @override
  String get currentShown => 'Shown';

  @override
  String get searchHint => 'Search examples';

  @override
  String get noMatchExamples => 'No matching examples';

  @override
  String get language => 'Language';

  @override
  String get switchToChinese => 'Switch to Chinese';

  @override
  String get switchToEnglish => 'Switch to English';

  @override
  String get categoryBasic => 'Basics';

  @override
  String get categoryScroll => 'Scrolling';

  @override
  String get categoryAnimation => 'Animation';

  @override
  String get categoryCanvas => 'Canvas & Shader';

  @override
  String get categoryVisual => '3D & Visual';
}
