import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/features/attendance/services/sync_engine.dart';

class SyncStatusWidget extends StatefulWidget {
  const SyncStatusWidget({
    super.key,
    required this.status,
    this.onRetry,
    this.isOnline = true,
  });

  final SyncStatus status;
  final VoidCallback? onRetry;
  final bool isOnline;

  @override
  State<SyncStatusWidget> createState() => _SyncStatusWidgetState();
}

class _SyncStatusWidgetState extends State<SyncStatusWidget> {
  Timer? _hideTimer;
  bool _hideSynced = false;

  @override
  void didUpdateWidget(covariant SyncStatusWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != oldWidget.status) {
      _hideTimer?.cancel();
      _hideSynced = false;
      if (widget.status == SyncStatus.synced) {
        _hideTimer = Timer(const Duration(milliseconds: 2500), () {
          if (mounted) {
            setState(() => _hideSynced = true);
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.status == SyncStatus.idle && widget.isOnline) ||
        (widget.status == SyncStatus.synced && _hideSynced)) {
      return const SizedBox.shrink();
    }

    final spec = _specFor(context, widget.status);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      child: Align(
        key: ValueKey(widget.status),
        alignment: AlignmentDirectional.centerStart,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.xs,
          ),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: spec.background,
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(color: spec.foreground.withValues(alpha: 0.18)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox.square(
                dimension: 18,
                child: spec.spinner
                    ? CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(spec.foreground),
                      )
                    : Icon(spec.icon, size: 18, color: spec.foreground),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                spec.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: spec.foreground,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (widget.status == SyncStatus.failed && widget.onRetry != null)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  tooltip: 'Retry sync',
                  onPressed: widget.onRetry,
                  icon: Icon(
                    Icons.refresh_rounded,
                    size: 18,
                    color: spec.foreground,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _SyncStatusSpec _specFor(BuildContext context, SyncStatus status) {
    final scheme = Theme.of(context).colorScheme;
    return switch (status) {
      SyncStatus.idle => _SyncStatusSpec(
        label: 'Offline',
        icon: Icons.cloud_off_rounded,
        foreground: scheme.tertiary,
        background: scheme.tertiary.withValues(alpha: 0.12),
      ),
      SyncStatus.offline => _SyncStatusSpec(
        label: 'Saved offline',
        icon: Icons.cloud_off_rounded,
        foreground: scheme.tertiary,
        background: scheme.tertiary.withValues(alpha: 0.12),
      ),
      SyncStatus.syncing => _SyncStatusSpec(
        label: 'Syncing...',
        icon: Icons.sync_rounded,
        foreground: scheme.primary,
        background: scheme.primary.withValues(alpha: 0.12),
        spinner: true,
      ),
      SyncStatus.synced => _SyncStatusSpec(
        label: 'Synced',
        icon: Icons.check_circle_rounded,
        foreground: const Color(0xFF15803D),
        background: const Color(0xFFDCFCE7),
      ),
      SyncStatus.failed => _SyncStatusSpec(
        label: 'Sync failed',
        icon: Icons.error_outline_rounded,
        foreground: scheme.error,
        background: scheme.error.withValues(alpha: 0.1),
      ),
    };
  }
}

class _SyncStatusSpec {
  const _SyncStatusSpec({
    required this.label,
    required this.icon,
    required this.foreground,
    required this.background,
    this.spinner = false,
  });

  final String label;
  final IconData icon;
  final Color foreground;
  final Color background;
  final bool spinner;
}
