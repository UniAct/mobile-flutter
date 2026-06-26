import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/features/auth/user_model.dart';
import 'package:mobile_flutter/features/home/dashboard_models.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.user,
    required this.dashboard,
    required this.onOpenAttendance,
    required this.onRefresh,
  });

  final UserModel? user;
  final DashboardData? dashboard;
  final VoidCallback onOpenAttendance;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    if (user == null || dashboard == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final currentUser = user!;
    final currentDashboard = dashboard!;

    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          const horizontalPadding = AppSpacing.md;

          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1120),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        isWide ? AppSpacing.lg : AppSpacing.md,
                        horizontalPadding,
                        0,
                      ),
                      child: isWide
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      _HeroGreeting(
                                        user: currentUser,
                                        dashboard: currentDashboard,
                                      ),
                                      const SizedBox(height: AppSpacing.md),
                                      _StatsRow(dashboard: currentDashboard),
                                      if (currentDashboard.isStudent &&
                                          currentDashboard.creditProgress !=
                                              null) ...[
                                        const SizedBox(height: AppSpacing.md),
                                        _CreditProgressSection(
                                          progress:
                                              currentDashboard.creditProgress!,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.lg),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: AppSpacing.md,
                                    ),
                                    child: _ScheduleSection(
                                      dashboard: currentDashboard,
                                      onOpenAttendance: onOpenAttendance,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                _HeroGreeting(
                                  user: currentUser,
                                  dashboard: currentDashboard,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                _StatsRow(dashboard: currentDashboard),
                                if (currentDashboard.isStudent &&
                                    currentDashboard.creditProgress !=
                                        null) ...[
                                  const SizedBox(height: AppSpacing.md),
                                  _CreditProgressSection(
                                    progress: currentDashboard.creditProgress!,
                                  ),
                                ],
                                const SizedBox(height: AppSpacing.md),
                                _ScheduleSection(
                                  dashboard: currentDashboard,
                                  onOpenAttendance: onOpenAttendance,
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).viewPadding.bottom + 24,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroGreeting extends StatelessWidget {
  const _HeroGreeting({required this.user, required this.dashboard});

  final UserModel user;
  final DashboardData dashboard;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMMM d').format(now);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;
        final logoSize = compact ? 46.0 : 58.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(compact ? AppSpacing.md : AppSpacing.lg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            gradient: const LinearGradient(
              colors: [Color(0xFF0F766E), Color(0xFF0D9488)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.14),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _greeting(now.hour),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: compact ? 18 : null,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (user.email.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        user.email,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.82),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(AppRadius.xl),
                          ),
                          child: Text(
                            user.primaryRole,
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        Text(
                          dateStr,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: compact ? AppSpacing.sm : AppSpacing.md),
              Hero(
                tag: 'app-logo',
                child: Container(
                  width: logoSize,
                  height: logoSize,
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _greeting(int hour) {
    if (hour < 12) {
      return 'Good morning';
    }
    if (hour < 17) {
      return 'Good afternoon';
    }
    return 'Good evening';
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.dashboard});

  final DashboardData dashboard;

  @override
  Widget build(BuildContext context) {
    final tiles = dashboard.isStudent
        ? [
            _Stat(
              'Courses',
              dashboard.stats.registeredCourses.toString(),
              Icons.menu_book_rounded,
            ),
            _Stat(
              'Credit Hours',
              dashboard.stats.registeredCreditHours.toString(),
              Icons.timer_rounded,
            ),
          ]
        : [
            _Stat(
              'Sessions',
              dashboard.stats.totalSessions.toString(),
              Icons.event_note_rounded,
            ),
            _Stat(
              'Courses',
              dashboard.stats.distinctCourseCount.toString(),
              Icons.auto_stories_rounded,
            ),
            _Stat(
              'Students',
              dashboard.stats.enrolledStudents.toString(),
              Icons.groups_rounded,
            ),
          ];

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 620) {
          return Row(
            children: [
              for (var i = 0; i < tiles.length; i++) ...[
                Expanded(child: _StatCard(stat: tiles[i])),
                if (i != tiles.length - 1) const SizedBox(width: AppSpacing.sm),
              ],
            ],
          );
        }

        final cardWidth = constraints.maxWidth < 360 ? 154.0 : 170.0;
        return SizedBox(
          height: 82,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tiles.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) =>
                _StatCard(stat: tiles[index], width: cardWidth),
          ),
        );
      },
    );
  }
}

class _CreditProgressSection extends StatelessWidget {
  const _CreditProgressSection({required this.progress});

  final CreditProgress progress;

  @override
  Widget build(BuildContext context) {
    final percent = progress.percent.clamp(0, 100);

    return Container(
      width: double.infinity,
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
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Credit Hours Achievement',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${progress.completedCourses} graded courses completed',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Text(
                '${percent.toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: percent / 100,
              backgroundColor: AppColors.surfaceAlt,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${progress.completedCreditHours} of ${progress.totalRequiredCreditHours} credit hours completed',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (progress.segments.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            ...progress.segments.map(
              (segment) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _CreditSegmentRow(segment: segment),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CreditSegmentRow extends StatelessWidget {
  const _CreditSegmentRow({required this.segment});

  final CreditProgressSegment segment;

  @override
  Widget build(BuildContext context) {
    final percent = segment.percent.clamp(0, 100);

    return Row(
      children: [
        SizedBox(
          width: 78,
          child: Text(
            segment.label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: AppColors.textPrimary),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: LinearProgressIndicator(
              minHeight: 7,
              value: percent / 100,
              backgroundColor: AppColors.surfaceAlt,
              color: segment.label == 'Program'
                  ? AppColors.tertiary
                  : AppColors.secondary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 72,
          child: Text(
            '${segment.completedCreditHours}/${segment.requiredCreditHours} hrs',
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}

class _Stat {
  const _Stat(this.label, this.value, this.icon);

  final String label;
  final String value;
  final IconData icon;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat, this.width});

  final _Stat stat;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 78),
      padding: const EdgeInsets.all(AppSpacing.sm),
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
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(stat.icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    stat.value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  stat.label,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleSection extends StatelessWidget {
  const _ScheduleSection({
    required this.dashboard,
    required this.onOpenAttendance,
  });

  final DashboardData dashboard;
  final VoidCallback onOpenAttendance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Today\'s Schedule',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            if (!dashboard.isStudent)
              FilledButton.icon(
                onPressed: onOpenAttendance,
                icon: const Icon(Icons.fact_check_rounded, size: 16),
                label: const Text('Attendance'),
                style: FilledButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        if (dashboard.todaySchedule.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
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
              children: [
                const Icon(
                  Icons.event_busy_rounded,
                  size: 36,
                  color: AppColors.textMuted,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'No sessions scheduled for today',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          )
        else
          ...dashboard.todaySchedule.asMap().entries.map(
            (entry) => _ScheduleTile(
              item: entry.value,
              isLast: entry.key == dashboard.todaySchedule.length - 1,
              isStudent: dashboard.isStudent,
            ),
          ),
        if (dashboard.isStudent && dashboard.todaySchedule.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Center(
            child: FilledButton.icon(
              onPressed: onOpenAttendance,
              icon: const Icon(Icons.qr_code_2_rounded, size: 18),
              label: const Text('View my QR Code'),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ScheduleTile extends StatelessWidget {
  const _ScheduleTile({
    required this.item,
    required this.isLast,
    required this.isStudent,
  });

  final DashboardScheduleItem item;
  final bool isLast;
  final bool isStudent;

  @override
  Widget build(BuildContext context) {
    final title = '${item.courseCode} ${item.title}'.trim();

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 3),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 52,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  color: AppColors.border,
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(color: AppColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D0F172A),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Flexible(
                        child: Text(
                          '${item.startTime} - ${item.endTime}',
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (item.classroomLabel.trim().isNotEmpty) ...[
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Flexible(
                          child: Text(
                            item.classroomLabel,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (isStudent && (item.teacherName ?? '').isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          size: 14,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            item.teacherName!,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
