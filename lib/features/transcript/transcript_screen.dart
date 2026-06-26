import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/utils/app_exception.dart';
import 'package:mobile_flutter/core/utils/helpers.dart';
import 'package:mobile_flutter/features/transcript/transcript_models.dart';
import 'package:mobile_flutter/features/transcript/transcript_service.dart';

class TranscriptScreen extends StatefulWidget {
  const TranscriptScreen({super.key});

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  final TranscriptService _service = TranscriptService();

  TranscriptData? _data;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadTranscript();
  }

  Future<void> _loadTranscript() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final data = await _service.getTranscript();
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
                Icons.school_outlined,
                size: 42,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: _loadTranscript,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final semesters = data?.semesters ?? const <TranscriptTerm>[];
    final latest = semesters.isNotEmpty ? semesters.last : null;

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: _loadTranscript,
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
              child: _TranscriptHeader(
                latestCgpa: latest?.cumulativeGpa,
                totalTerms: semesters.length,
                totalCredits: latest?.totalCredits ?? 0,
              ),
            ),
          ),
          if (semesters.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: _EmptyTranscript(),
            )
          else
            SliverList.builder(
              itemCount: semesters.length,
              itemBuilder: (context, index) {
                final term = semesters[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    index == 0 ? AppSpacing.md : 0,
                    AppSpacing.md,
                    AppSpacing.md,
                  ),
                  child: _TermCard(term: term, initiallyExpanded: index == 0),
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
}

class _TranscriptHeader extends StatelessWidget {
  const _TranscriptHeader({
    required this.latestCgpa,
    required this.totalTerms,
    required this.totalCredits,
  });

  final double? latestCgpa;
  final int totalTerms;
  final int totalCredits;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        gradient: const LinearGradient(
          colors: [Color(0xFF115E59), Color(0xFF0F766E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Academic Transcript',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Icon(
                  Icons.history_edu_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _HeaderMetric(
                  label: 'CGPA',
                  value: latestCgpa == null
                      ? '--'
                      : latestCgpa!.toStringAsFixed(2),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _HeaderMetric(label: 'Terms', value: '$totalTerms'),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _HeaderMetric(label: 'Credits', value: '$totalCredits'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderMetric extends StatelessWidget {
  const _HeaderMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _TermCard extends StatelessWidget {
  const _TermCard({required this.term, required this.initiallyExpanded});

  final TranscriptTerm term;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: initiallyExpanded,
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.md,
          ),
          title: Text(
            term.semester.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                _TermChip(label: 'GPA ${term.semesterGpa.toStringAsFixed(2)}'),
                _TermChip(
                  label: 'CGPA ${term.cumulativeGpa.toStringAsFixed(2)}',
                ),
                _TermChip(label: '${term.totalCredits} credits'),
              ],
            ),
          ),
          children: [
            ...term.courses.map(
              (course) => Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: _CourseRow(course: course),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TermChip extends StatelessWidget {
  const _TermChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: AppColors.primaryDark),
      ),
    );
  }
}

class _CourseRow extends StatelessWidget {
  const _CourseRow({required this.course});

  final TranscriptCourse course;

  @override
  Widget build(BuildContext context) {
    final score = course.scorePercentage == null
        ? null
        : '${course.scorePercentage!.toStringAsFixed(1)}%';

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: AppColors.border),
            ),
            child: Text(
              course.grade ?? '--',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: _gradeColor(course.grade),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${course.courseCode} ${course.courseName}'.trim(),
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xs,
                  children: [
                    Text(
                      '${course.credits} hrs',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (score != null)
                      Text(
                        score,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    if (course.gradePoints != null)
                      Text(
                        '${course.gradePoints!.toStringAsFixed(2)} pts',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _gradeColor(String? grade) {
    if ((grade ?? '').toUpperCase() == 'F') {
      return AppColors.error;
    }
    return AppColors.success;
  }
}

class _EmptyTranscript extends StatelessWidget {
  const _EmptyTranscript();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.history_edu_outlined,
              size: 42,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'No transcript records yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Completed and graded terms will appear here after transcripts are generated.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
