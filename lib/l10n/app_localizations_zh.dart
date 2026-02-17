// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'GSY Flutter Demo';

  @override
  String get homeSubtitle => '分组浏览、快速检索，一键进入示例。';

  @override
  String get allExamples => '全部示例';

  @override
  String get filteredResults => '筛选结果';

  @override
  String get currentShown => '当前显示';

  @override
  String get searchHint => '搜索示例名称（中英文均可）';

  @override
  String get noMatchExamples => '没有匹配的示例';

  @override
  String get language => '语言';

  @override
  String get switchToChinese => '切换中文';

  @override
  String get switchToEnglish => '切换英文';

  @override
  String get categoryBasic => '基础控件';

  @override
  String get categoryScroll => '列表滚动';

  @override
  String get categoryAnimation => '动画交互';

  @override
  String get categoryCanvas => '绘制与Shader';

  @override
  String get categoryVisual => '3D与视觉';
}
