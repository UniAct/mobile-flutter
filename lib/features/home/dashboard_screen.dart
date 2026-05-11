import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/widgets/app_card.dart';
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 420;

        return RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(isCompact ? AppSpacing.sm : AppSpacing.md),
            children: [
              _HeaderCard(
                user: user!,
                dashboard: dashboard!,
                compact: isCompact,
              ),
              SizedBox(height: isCompact ? AppSpacing.sm : AppSpacing.md),
              _StatsGrid(dashboard: dashboard!),
              SizedBox(height: isCompact ? AppSpacing.sm : AppSpacing.md),
              _TodayScheduleCard(
                dashboard: dashboard!,
                onOpenAttendance: onOpenAttendance,
                compact: isCompact,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({
    required this.user,
    required this.dashboard,
    required this.compact,
  });

  final UserModel user;
  final DashboardData dashboard;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${user.name}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dashboard.dayOfWeek,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: AppColors.accent,
                radius: 20,
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              dashboard.isStudent
                  ? 'Your schedule and academic progress'
                  : 'Today\'s teaching plan and attendance',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.dashboard});

  final DashboardData dashboard;

  @override
  Widget build(BuildContext context) {
    final statTiles = dashboard.isStudent
        ? <_StatTileModel>[
            _StatTileModel(
              label: 'Registered Courses',
              value: dashboard.stats.registeredCourses.toString(),
              icon: Icons.menu_book_rounded,
            ),
            _StatTileModel(
              label: 'Credit Hours',
              value: dashboard.stats.registeredCreditHours.toString(),
              icon: Icons.timer_rounded,
            ),
          ]
        : <_StatTileModel>[
            _StatTileModel(
              label: 'Total Sessions',
              value: dashboard.stats.totalSessions.toString(),
              icon: Icons.event_note_rounded,
            ),
            _StatTileModel(
              label: 'Distinct Courses',
              value: dashboard.stats.distinctCourseCount.toString(),
              icon: Icons.auto_stories_rounded,
            ),
            _StatTileModel(
              label: 'Enrolled Students',
              value: dashboard.stats.enrolledStudents.toString(),
              icon: Icons.groups_rounded,
            ),
          ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: statTiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.sizeOf(context).width < 520 ? 1 : 2,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
        childAspectRatio: MediaQuery.sizeOf(context).width < 520 ? 2.8 : 1.65,
      ),
      itemBuilder: (context, index) {
        final tile = statTiles[index];
        return AppCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.accent,
                child: Icon(tile.icon, color: AppColors.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tile.value,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tile.label,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TodayScheduleCard extends StatelessWidget {
  const _TodayScheduleCard({
    required this.dashboard,
    required this.onOpenAttendance,
    required this.compact,
  });

  final DashboardData dashboard;
  final VoidCallback onOpenAttendance;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Today Schedule',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              compact
                  ? IconButton(
                      onPressed: onOpenAttendance,
                      icon: const Icon(Icons.fact_check_rounded),
                      tooltip: 'Attendance',
                    )
                  : TextButton(
                      onPressed: onOpenAttendance,
                      child: const Text('Attendance'),
                    ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (dashboard.todaySchedule.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
              ),
              child: const Text('No sessions today.'),
            ),
          ...dashboard.todaySchedule.map((slot) {
            final stacked = MediaQuery.sizeOf(context).width < 360;
            final title = '${slot.courseCode} ${slot.title}'.trim();

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  color: AppColors.background,
                  border: Border.all(color: AppColors.border),
                ),
                child: stacked
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text('${slot.startTime} - ${slot.endTime}'),
                          const SizedBox(height: 2),
                          Text(slot.classroomLabel),
                          if ((slot.teacherName ?? '').isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text('Teacher: ${slot.teacherName}'),
                          ],
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text('${slot.startTime} - ${slot.endTime}'),
                                const SizedBox(height: 2),
                                Text(slot.classroomLabel),
                                if ((slot.teacherName ?? '').isNotEmpty) ...[
                                  const SizedBox(height: 2),
                                  Text('Teacher: ${slot.teacherName}'),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _StatTileModel {
  const _StatTileModel({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;
}
