import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/core/utils/helpers.dart';
import 'package:mobile_flutter/features/timetable/timetable_models.dart';
import 'package:mobile_flutter/features/timetable/timetable_service.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final TimetableService _service = TimetableService();

  TimetableData? _data;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTimetable();
  }

  Future<void> _loadTimetable() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final data = await _service.getTimetable();
      if (!mounted) {
        return;
      }
      setState(() {
        _data = data;
        _loading = false;
      });
    } on AppException catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = e.message;
        _loading = false;
      });
      if (!e.isNetworkError) {
        AppHelpers.showError(context, e.message);
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      final message = AppHelpers.userErrorMessage(e);
      setState(() {
        _error = message;
        _loading = false;
      });
      AppHelpers.showMessage(context, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _data;

    if (_loading && data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null && data == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 42,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: _loadTimetable,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final grouped = _groupByDay(data?.timetable ?? const <TimetableItem>[]);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: _loadTimetable,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                0,
              ),
              child: _TimetableHeader(
                totalSessions: data?.timetable.length ?? 0,
                isStudent: data?.isStudent ?? false,
              ),
            ),
          ),
          if (grouped.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: const _EmptyTimetable(),
            )
          else
            SliverList.builder(
              itemCount: grouped.length,
              itemBuilder: (context, index) {
                final entry = grouped.entries.elementAt(index);
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    index == 0 ? AppSpacing.md : 0,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: _DaySection(
                    day: entry.key,
                    items: entry.value,
                    isStudent: data?.isStudent ?? false,
                  ),
                );
              },
            ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).viewPadding.bottom + 24,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<TimetableItem>> _groupByDay(List<TimetableItem> items) {
    final grouped = <String, List<TimetableItem>>{};
    for (final item in items) {
      grouped.putIfAbsent(item.dayOfWeek, () => <TimetableItem>[]).add(item);
    }
    return grouped;
  }
}

class _TimetableHeader extends StatelessWidget {
  const _TimetableHeader({
    required this.totalSessions,
    required this.isStudent,
  });

  final int totalSessions;
  final bool isStudent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isStudent ? 'My weekly classes' : 'Teaching timetable',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '$totalSessions scheduled ${totalSessions == 1 ? 'session' : 'sessions'}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: const Icon(
              Icons.calendar_view_week_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DaySection extends StatelessWidget {
  const _DaySection({
    required this.day,
    required this.items,
    required this.isStudent,
  });

  final String day;
  final List<TimetableItem> items;
  final bool isStudent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(day, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              child: Text(
                items.length.toString(),
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.primaryDark),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _TimetableCard(item: item, isStudent: isStudent),
          ),
        ),
      ],
    );
  }
}

class _TimetableCard extends StatelessWidget {
  const _TimetableCard({required this.item, required this.isStudent});

  final TimetableItem item;
  final bool isStudent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0F172A),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surfaceAlt,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Column(
                  children: [
                    Text(
                      item.startTime,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      item.endTime,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.course.code} ${item.course.name}'.trim(),
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.xs,
                      children: [
                        _MiniBadge(
                          icon: Icons.auto_stories_rounded,
                          label: '${item.course.credits} hrs',
                        ),
                        if (item.type.isNotEmpty)
                          _MiniBadge(
                            icon: Icons.category_rounded,
                            label: item.type,
                          ),
                        if ((item.registrationStatus ?? '').isNotEmpty)
                          _MiniBadge(
                            icon: Icons.check_circle_rounded,
                            label: item.registrationStatus!,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if ((item.classroom?.label ?? '').isNotEmpty)
            _InfoLine(
              icon: Icons.location_on_rounded,
              text: item.classroom!.label,
            ),
          if (isStudent && (item.teacher?.name ?? '').isNotEmpty)
            _InfoLine(icon: Icons.person_rounded, text: item.teacher!.name),
          if (!isStudent && item.programContexts.isNotEmpty)
            ...item.programContexts.map(
              (context) => _InfoLine(
                icon: Icons.groups_rounded,
                text:
                    '${context.programName} - Level ${context.academicLevel} - ${context.enrolledStudents} students',
              ),
            ),
          if (!isStudent && item.allowedCapacity != null)
            _InfoLine(
              icon: Icons.event_seat_rounded,
              text:
                  '${item.enrolledSeats ?? 0}/${item.allowedCapacity} seats used',
            ),
        ],
      ),
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.primaryDark),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.primaryDark),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textMuted),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyTimetable extends StatelessWidget {
  const _EmptyTimetable();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.event_busy_rounded,
              size: 42,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'No timetable entries available',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Pull down to refresh when your semester schedule is published.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
