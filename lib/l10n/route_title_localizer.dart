String localizeRouteTitle(String source, {required bool isEnglish}) {
  if (!isEnglish) {
    return source;
  }

  if (_allAscii(source)) {
    return source;
  }

  var value = source;
  for (final entry in _zhToEnPhrases) {
    value = value.replaceAll(entry.zh, entry.en);
  }

  value = value
      .replaceAll('（', '(')
      .replaceAll('）', ')')
      .replaceAll('，', ', ')
      .replaceAll('。', '.');
  value = value.replaceAll(RegExp(r'\s+'), ' ').trim();
  return value;
}

bool _allAscii(String input) {
  for (final code in input.codeUnits) {
    if (code > 127) {
      return false;
    }
  }
  return true;
}

class _Pair {
  const _Pair(this.zh, this.en);

  final String zh;
  final String en;
}

const List<_Pair> _zhToEnPhrases = <_Pair>[
  _Pair('文本输入框简单的 Controller', 'Simple text input controller'),
  _Pair('实现控件圆角不同组合', 'Different rounded corner combinations'),
  _Pair('列表滑动监听', 'List scroll listener'),
  _Pair('滑动到指定位置', 'Scroll to target position'),
  _Pair('展示渐变带边框的文本', 'Gradient text with border'),
  _Pair('计算另类文本行间距展示', 'Custom text line-height demo'),
  _Pair('简单上下刷新', 'Simple pull refresh'),
  _Pair('通过绝对定位布局', 'Absolute positioned layout'),
  _Pair('气泡提示框', 'Bubble tooltip'),
  _Pair('共享元素跳转效果', 'Shared element transition'),
  _Pair('滑动验证', 'Slider verification'),
  _Pair('状态栏颜色修改', 'Status bar color update'),
  _Pair('键盘弹出与监听', 'Keyboard show/hide listener'),
  _Pair('控件动画组合展示', 'Combined widget animations'),
  _Pair('控件展开动画效果', 'Expand animation'),
  _Pair('全局悬浮按键效果', 'Global floating action button'),
  _Pair('全局设置字体大小', 'Global font size setting'),
  _Pair('旧版实现富文本', 'Legacy rich text implementation'),
  _Pair('官方实现富文本', 'Official rich text implementation'),
  _Pair('第三方 viewpager 封装实现', 'Third-party ViewPager wrapper'),
  _Pair('列表滑动过程控件停靠效果', 'Sticky items while scrolling'),
  _Pair('验证码输入框', 'Verification code input'),
  _Pair('自定义布局展示效果', 'Custom layout demo'),
  _Pair('自定义布局实现云词图展示', 'Word cloud with custom layout'),
  _Pair('列表滑动停靠', 'List sticky header'),
  _Pair('键盘顶起展示', 'Keyboard insets demo'),
  _Pair('高斯模糊效果', 'Gaussian blur effect'),
  _Pair('控件动画变形效果', 'Morphing animation'),
  _Pair('时钟动画绘制展示', 'Clock animation drawing'),
  _Pair('按键切换动画效果', 'Switch animation'),
  _Pair('列表滑动过程 item 停靠动画效果', 'Sticky item animation'),
  _Pair('下弹筛选展示效果', 'Dropdown filter demo'),
  _Pair('文本弹出动画效果', 'Text pop animation'),
  _Pair('强大的自定义滑动与停靠结合展示', 'Advanced custom scroll + sticky'),
  _Pair('自定义列表内sliver渲染顺序', 'Custom sliver render order'),
  _Pair('点击弹出动画提示', 'Tap animation tip'),
  _Pair('使用 overflow 处理图片', 'Image overflow demo'),
  _Pair('展示 Align 排布控件', 'Align layout demo'),
  _Pair('通过不同尺寸计算方式展示比例', 'Ratio by size calculation'),
  _Pair('多列表+顶部Tab效果展示', 'Multi-list + top tabs'),
  _Pair('仿真书本翻页动画', 'Book page flip animation'),
  _Pair('粒子动画效果', 'Particle animation effect'),
  _Pair('动画背景效果', 'Animated background effect'),
  _Pair('手势效果', 'Gesture effect'),
  _Pair('一个有趣的底部跟随和停靠例子', 'Bottom follow + sticky demo'),
  _Pair('一个有趣的圆形选择器', 'Circular selector demo'),
  _Pair('一个类似探探堆叠卡片例子', 'Stacked card demo'),
  _Pair('动画按键例子', 'Animated button demo'),
  _Pair('类似QQ发送图片的动画', 'QQ-style image send animation'),
  _Pair('类似探探扫描的动画效果', 'Tantan-style scan animation'),
  _Pair('圆弧形的 SeekBar', 'Arc SeekBar'),
  _Pair('一个国外友人很惊艳的动画效果', 'Impressive animation demo'),
  _Pair('纯 Canvas 绘制闹钟', 'Canvas alarm clock'),
  _Pair('类似 boss 直聘我的页面联动效果', 'BOSS-style linked page'),
  _Pair('结合 Matrix 的拖拽', 'Matrix drag interaction'),
  _Pair('彩色进度条', 'Color progress bar'),
  _Pair('第三方的动画字体', 'Animated font package demo'),
  _Pair('首尾添加数据不会抖动', 'Stable list when prepend/append'),
  _Pair('测试路由嵌套', 'Nested route test'),
  _Pair('测试 canvas 阴影', 'Canvas shadow test'),
  _Pair('控件动画切换效果', 'Widget switch animation'),
  _Pair('垂直', 'Vertical'),
  _Pair('嵌套', 'nested'),
  _Pair('解决斜着滑动问题', 'fix diagonal gesture conflict'),
  _Pair('透视卡片', 'perspective card'),
  _Pair('卡片旋转', 'card rotation'),
  _Pair('硬核', 'advanced'),
  _Pair('展示 canvas transform', 'Canvas transform demo'),
  _Pair('掘金', 'Juejin'),
  _Pair('更', 'enhanced'),
  _Pair('路径', 'path'),
  _Pair('效果', 'effect'),
  _Pair('列表联动 BottomSheet 效果', 'Linked list + BottomSheet'),
  _Pair('异步调用的顺序执行', 'Ordered async calls'),
  _Pair('点击爆炸的五角星', 'Tap-to-explode star'),
  _Pair('有趣画廊', 'Interesting gallery'),
  _Pair('有趣的文本撕裂动画', 'Text tear animation'),
  _Pair('自适应横竖列表', 'Adaptive list orientation'),
  _Pair('手势密码', 'Gesture password'),
  _Pair('粒子动画', 'Particle animation'),
  _Pair('斐波那契球体动画', 'Fibonacci sphere animation'),
  _Pair('星云动画', 'Nebula animation'),
  _Pair('霓虹滑块，100%高亮', 'Neon slider, full highlight'),
  _Pair('炫酷爆炸粒子', 'Cool boom particles'),
  _Pair('流体太极', 'Fluid Taichi'),
  _Pair('黑洞流体', 'Black hole fluid'),
  _Pair('太极粒子', 'Taichi particles'),
  _Pair('破坏杀·罗针', 'Destructive Compass Needle'),
  _Pair('骚气滑动列表', 'Fancy scrolling list'),
  _Pair('骚气粒子效果', 'Fancy particle effect'),
  _Pair('炫酷圣诞树', 'Cool Christmas tree'),
  _Pair('炫酷二维码', 'Cool QR code'),
  _Pair('仅 App', 'App only'),
  _Pair('的', ' '),
  _Pair('展示', 'demo'),
  _Pair('例子', 'example'),
];
