import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';

class UniversitySearchField extends StatelessWidget {
  const UniversitySearchField({
    super.key,
    required this.controller,
    required this.filteredOptions,
    required this.onQueryChanged,
    required this.onSelect,
    required this.showSuggestions,
    this.selectedUniversity,
  });

  final TextEditingController controller;
  final List<String> filteredOptions;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String> onSelect;
  final bool showSuggestions;
  final String? selectedUniversity;

  @override
  Widget build(BuildContext context) {
    final selected = selectedUniversity;

    return Semantics(
      button: true,
      label: selected == null
          ? 'Select university'
          : 'Selected university, $selected',
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: () => _showSelector(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'University',
            hintText: 'Tap to select your university',
            prefixIcon: const Icon(Icons.account_balance_rounded),
            suffixIcon: selected == null || selected.isEmpty
                ? const Icon(Icons.keyboard_arrow_down_rounded)
                : IconButton(
                    tooltip: 'Clear university',
                    onPressed: () {
                      controller.clear();
                      onQueryChanged('');
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
          ),
          child: Text(
            selected == null || selected.isEmpty ? '' : selected,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  Future<void> _showSelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _UniversitySelectorSheet(
        universities: filteredOptions,
        initialQuery: controller.text,
      ),
    );

    if (selected == null || selected.isEmpty) {
      return;
    }

    controller.text = selected;
    onSelect(selected);
  }
}

class _UniversitySelectorSheet extends StatefulWidget {
  const _UniversitySelectorSheet({
    required this.universities,
    required this.initialQuery,
  });

  final List<String> universities;
  final String initialQuery;

  @override
  State<_UniversitySelectorSheet> createState() =>
      _UniversitySelectorSheetState();
}

class _UniversitySelectorSheetState extends State<_UniversitySelectorSheet> {
  late final TextEditingController _searchController;
  late List<String> _filtered;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    _filtered = _filter(widget.initialQuery);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return DraggableScrollableSheet(
      initialChildSize: 0.72,
      minChildSize: 0.42,
      maxChildSize: 0.94,
      builder: (context, scrollController) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: bottomInset),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.xl),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      AppSpacing.sm,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 42,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextField(
                          controller: _searchController,
                          autofocus: true,
                          textInputAction: TextInputAction.search,
                          onChanged: _onSearchChanged,
                          decoration: const InputDecoration(
                            labelText: 'Search universities',
                            prefixIcon: Icon(Icons.search_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_filtered.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _NoUniversityResults(
                      query: _searchController.text.trim(),
                    ),
                  )
                else
                  SliverList.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) {
                      final university = _filtered[index];
                      return ListTile(
                        minVerticalPadding: AppSpacing.sm,
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.12),
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: Text(
                            _initials(university),
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                          ),
                        ),
                        title: Text(
                          university,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          _shortCode(university),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => Navigator.of(context).pop(university),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _filtered = _filter(value));
      }
    });
  }

  List<String> _filter(String query) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return widget.universities;
    }
    return widget.universities
        .where((item) => item.toLowerCase().contains(normalized))
        .toList();
  }

  String _initials(String value) {
    final words = value
        .split(RegExp(r'\s+'))
        .where((word) => word.trim().isNotEmpty)
        .take(2)
        .toList();
    if (words.isEmpty) {
      return 'U';
    }
    return words.map((word) => word[0].toUpperCase()).join();
  }

  String _shortCode(String value) {
    final letters = RegExp(r'[A-Za-z]').allMatches(value);
    final code = letters.take(4).map((match) => match.group(0)!).join();
    return code.toUpperCase();
  }
}

class _NoUniversityResults extends StatelessWidget {
  const _NoUniversityResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomPaint(
            size: const Size(96, 72),
            painter: _EmptySearchPainter(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'No results found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            query.isEmpty
                ? 'Try searching by the full university name.'
                : 'No university matches "$query".',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _EmptySearchPainter extends CustomPainter {
  const _EmptySearchPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.14)
      ..style = PaintingStyle.fill;
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(8, 10, size.width - 28, size.height - 22),
        const Radius.circular(AppRadius.md),
      ),
      paint,
    );
    canvas.drawCircle(Offset(size.width - 22, size.height - 18), 13, stroke);
    canvas.drawLine(
      Offset(size.width - 12, size.height - 8),
      Offset(size.width - 2, size.height + 2),
      stroke,
    );
  }

  @override
  bool shouldRepaint(covariant _EmptySearchPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
