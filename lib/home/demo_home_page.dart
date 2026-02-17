import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsy_flutter_demo/l10n/app_localizations.dart';
import 'package:gsy_flutter_demo/l10n/route_title_localizer.dart';
import 'package:window_location_href/window_location_href.dart';

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({
    required this.routes,
    required this.onToggleLocale,
    required this.isEnglish,
    super.key,
  });

  final Map<String, WidgetBuilder> routes;
  final VoidCallback onToggleLocale;
  final bool isEnglish;

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  DemoCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _handleWebHashRoute();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleWebHashRoute() {
    final href = getHref();
    final index = href?.indexOf('#') ?? -1;
    if (href == null || index <= 0) {
      return;
    }

    final key = href.substring(index + 1, href.length);
    if (key.isEmpty || key.length <= 3) {
      return;
    }

    final routeName = Uri.decodeFull(key);
    if (!widget.routes.containsKey(routeName) || routeName == '/') {
      return;
    }

    Future<void>(() {
      if (!mounted) {
        return;
      }
      Navigator.pushNamed(context, routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final allEntries = widget.routes.keys
        .map((routeName) => DemoEntry(
              routeName: routeName,
              title: localizeRouteTitle(routeName, isEnglish: widget.isEnglish),
              category: DemoCategoryMatcher.byTitle(routeName),
            ))
        .toList();

    final filteredEntries = allEntries.where((entry) {
      final query = _query.toLowerCase();
      final byQuery = _query.isEmpty ||
          entry.title.toLowerCase().contains(query) ||
          entry.routeName.toLowerCase().contains(query);
      final byCategory =
          _selectedCategory == null || entry.category == _selectedCategory;
      return byQuery && byCategory;
    }).toList();

    final grouped = <DemoCategory, List<DemoEntry>>{};
    for (final entry in filteredEntries) {
      grouped.putIfAbsent(entry.category, () => <DemoEntry>[]).add(entry);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Color(0xFFEAF2FF), Color(0xFFF8FAFF)],
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _HeroHeader(
                totalCount: allEntries.length,
                filteredCount: filteredEntries.length,
                onToggleLocale: widget.onToggleLocale,
                isEnglish: widget.isEnglish,
              ),
            ),
            SliverToBoxAdapter(
              child: _SearchField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value.trim()),
                onClear: () {
                  _searchController.clear();
                  setState(() {
                    _query = '';
                  });
                },
              ),
            ),
            SliverToBoxAdapter(
              child: _CategorySelector(
                categories: DemoCategory.values,
                selectedCategory: _selectedCategory,
                categoryCount: allEntries,
                onSelected: (category) {
                  setState(() {
                    if (_selectedCategory == category) {
                      _selectedCategory = null;
                    } else {
                      _selectedCategory = category;
                    }
                  });
                },
              ),
            ),
            if (grouped.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyState(),
              )
            else
              SliverList.builder(
                itemCount: DemoCategory.values.length,
                itemBuilder: (context, index) {
                  final category = DemoCategory.values[index];
                  final entries = grouped[category] ?? const <DemoEntry>[];
                  if (entries.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return _CategorySection(entries: entries, category: category);
                },
              ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({
    required this.totalCount,
    required this.filteredCount,
    required this.onToggleLocale,
    required this.isEnglish,
  });

  final int totalCount;
  final int filteredCount;
  final VoidCallback onToggleLocale;
  final bool isEnglish;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final showFiltered = filteredCount != totalCount;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0B4D88),
            Color(0xFF1D7BCB),
            Color(0xFF42A5F5)
          ],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x440B4D88),
            blurRadius: 22,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.appTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: onToggleLocale,
                tooltip: l10n.language,
                icon: const Icon(Icons.language_rounded, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l10n.homeSubtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: <Widget>[
              _StatTag(label: l10n.allExamples, value: totalCount.toString()),
              _StatTag(
                label: showFiltered ? l10n.filteredResults : l10n.currentShown,
                value: filteredCount.toString(),
              ),
              _StatTag(
                label: l10n.language,
                value: isEnglish ? l10n.switchToChinese : l10n.switchToEnglish,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTag extends StatelessWidget {
  const _StatTag({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.white.withValues(alpha: 0.12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1A2E3A59),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: l10n.searchHint,
          hintStyle: const TextStyle(fontSize: 13),
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: onClear,
                  icon: const Icon(Icons.close_rounded),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({
    required this.categories,
    required this.selectedCategory,
    required this.categoryCount,
    required this.onSelected,
  });

  final List<DemoCategory> categories;
  final DemoCategory? selectedCategory;
  final List<DemoEntry> categoryCount;
  final ValueChanged<DemoCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          final count =
              categoryCount.where((entry) => entry.category == category).length;
          final selected = selectedCategory == category;
          return FilterChip(
            selected: selected,
            showCheckmark: false,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(category.icon, size: 16),
                const SizedBox(width: 6),
                Text('${category.label(l10n)} · $count'),
              ],
            ),
            onSelected: (_) => onSelected(category),
            backgroundColor: Colors.white,
            selectedColor: category.color.withValues(alpha: 0.18),
            side: BorderSide(
              color: selected
                  ? category.color.withValues(alpha: 0.6)
                  : const Color(0xFFDFE7F4),
            ),
          );
        },
        separatorBuilder: (context, _) => const SizedBox(width: 8),
        itemCount: categories.length,
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  const _CategorySection({required this.entries, required this.category});

  final List<DemoEntry> entries;
  final DemoCategory category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5ECF7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 14,
                backgroundColor: category.color.withValues(alpha: 0.15),
                child: Icon(category.icon, size: 16, color: category.color),
              ),
              const SizedBox(width: 8),
              Text(
                category.label(l10n),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B2B46),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${entries.length}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF5F6E85),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...entries.map((entry) => _DemoCard(entry: entry)),
        ],
      ),
    );
  }
}

class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.entry});

  final DemoEntry entry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => Navigator.of(context).pushNamed(entry.routeName),
          child: Ink(
            decoration: BoxDecoration(
              color: const Color(0xFFF7FAFF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFDCE7F8)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      entry.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF1B2B46),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: entry.category.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: entry.category.color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.search_off_rounded,
              size: 54, color: Color(0xFF9AA9C2)),
          const SizedBox(height: 10),
          Text(
            l10n.noMatchExamples,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF6C7A91),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class DemoEntry {
  const DemoEntry({
    required this.routeName,
    required this.title,
    required this.category,
  });

  final String routeName;
  final String title;
  final DemoCategory category;
}

enum DemoCategory {
  basic(Icons.widgets_rounded, Color(0xFF1D7BCB)),
  scroll(Icons.swap_vert_rounded, Color(0xFF0B8E70)),
  animation(Icons.play_circle_outline_rounded, Color(0xFFE66A00)),
  canvas(Icons.brush_rounded, Color(0xFF7A57D1)),
  visual(Icons.auto_awesome_mosaic_rounded, Color(0xFF4A74E8));

  const DemoCategory(this.icon, this.color);

  final IconData icon;
  final Color color;

  String label(AppLocalizations l10n) {
    switch (this) {
      case DemoCategory.basic:
        return l10n.categoryBasic;
      case DemoCategory.scroll:
        return l10n.categoryScroll;
      case DemoCategory.animation:
        return l10n.categoryAnimation;
      case DemoCategory.canvas:
        return l10n.categoryCanvas;
      case DemoCategory.visual:
        return l10n.categoryVisual;
    }
  }
}

class DemoCategoryMatcher {
  static DemoCategory byTitle(String title) {
    final value = title.toLowerCase();

    if (_containsAny(value, <String>[
      'list',
      'sliver',
      'scroll',
      'viewpager',
      'pageview',
      '列表',
      '滑动',
      '停靠',
      '联动',
      'bottomsheet',
      'chat',
      'draggable',
      'link',
    ])) {
      return DemoCategory.scroll;
    }

    if (_containsAny(value, <String>[
      '3d',
      'box',
      'card',
      'cube',
      'juejin',
      'logo',
      'sphere',
      'spatial',
      'gallery',
      'disco',
      'mosaic',
      '二维码',
      '画廊',
      '星云',
      '黑洞',
      '太极',
      '鱼',
      'koi',
      'galaxy',
    ])) {
      return DemoCategory.visual;
    }

    if (_containsAny(value, <String>[
      'canvas',
      'shader',
      'path',
      'matrix',
      'blur',
      'glass',
      'liquid',
      'radial',
      'neon',
      'wave',
      '绘制',
      '阴影',
      '路径',
      '高斯',
      '手势',
    ])) {
      return DemoCategory.canvas;
    }

    if (_containsAny(value, <String>[
      'anim',
      'animation',
      'particle',
      'boom',
      'bomb',
      'switch',
      'seekbar',
      'scan',
      'clock',
      'tip',
      '撕裂',
      '爆炸',
      '动画',
      '粒子',
      '炫酷',
      '骚气',
      '霓虹',
      'cool',
    ])) {
      return DemoCategory.animation;
    }

    return DemoCategory.basic;
  }

  static bool _containsAny(String source, List<String> keywords) {
    for (final keyword in keywords) {
      if (source.contains(keyword)) {
        return true;
      }
    }
    return false;
  }
}

void debugPrintCategoryStats(Map<String, WidgetBuilder> routes) {
  if (!kDebugMode) {
    return;
  }
  final count = <DemoCategory, int>{};
  for (final title in routes.keys) {
    final category = DemoCategoryMatcher.byTitle(title);
    count[category] = (count[category] ?? 0) + 1;
  }
  for (final category in DemoCategory.values) {
    debugPrint('[DemoCategory] ${category.name}: ${count[category] ?? 0}');
  }
}
