import 'dart:async';

import 'package:flutter/material.dart';

enum AppToastType { success, error, warning, info }

class AppToast {
  static OverlayEntry? _currentEntry;

  static void show(
    BuildContext context, {
    required String message,
    required AppToastType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    try {
      final overlay = Overlay.maybeOf(context, rootOverlay: true);

      if (overlay == null) {
        debugPrint('[AppToast] Overlay unavailable, skipping: $message');
        return;
      }

      _currentEntry?.remove();
      _currentEntry = null;

      late final OverlayEntry entry;
      entry = OverlayEntry(
        builder: (context) {
          final media = MediaQuery.of(context);
          final maxWidth = media.size.width < 420
              ? media.size.width - 24
              : 380.0;

          return Positioned(
            top: media.padding.top + 12,
            right: 12,
            child: _ToastCard(
              message: message,
              type: type,
              maxWidth: maxWidth,
              duration: duration,
              onDismissed: () {
                if (_currentEntry == entry) {
                  _currentEntry = null;
                }
                entry.remove();
              },
            ),
          );
        },
      );

      _currentEntry = entry;
      overlay.insert(entry);
    } catch (e) {
      // Never throw from toast - fail silently
      debugPrint('[AppToast] Failed to show toast: $e');
    }
  }
}

class _ToastCard extends StatefulWidget {
  const _ToastCard({
    required this.message,
    required this.type,
    required this.maxWidth,
    required this.duration,
    required this.onDismissed,
  });

  final String message;
  final AppToastType type;
  final double maxWidth;
  final Duration duration;
  final VoidCallback onDismissed;

  @override
  State<_ToastCard> createState() => _ToastCardState();
}

class _ToastCardState extends State<_ToastCard> {
  Offset _dragOffset = Offset.zero;
  bool _visible = false;
  Timer? _timer;
  bool _isInteracting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _visible = true;
      });
    });

    _startAutoDismissTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _dismiss() {
    if (!mounted) {
      return;
    }

    setState(() {
      _visible = false;
    });

    Future<void>.delayed(const Duration(milliseconds: 180), () {
      if (mounted) {
        widget.onDismissed();
      }
    });
  }

  void _startAutoDismissTimer() {
    _timer?.cancel();
    _timer = Timer(widget.duration, () {
      if (_isInteracting) {
        return;
      }
      _dismiss();
    });
  }

  void _pauseAutoDismissTimer() {
    _isInteracting = true;
    _timer?.cancel();
    _timer = null;
  }

  void _resumeAutoDismissTimer() {
    _isInteracting = false;
    _startAutoDismissTimer();
  }

  @override
  Widget build(BuildContext context) {
    final toastStyle = _toastStyle(widget.type);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 180),
      opacity: _visible ? 1 : 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(_dragOffset.dx, _dragOffset.dy, 0),
        constraints: BoxConstraints(maxWidth: widget.maxWidth),
        child: GestureDetector(
          onTapDown: (_) => _pauseAutoDismissTimer(),
          onTapUp: (_) => _resumeAutoDismissTimer(),
          onTapCancel: _resumeAutoDismissTimer,
          onPanStart: (_) => _pauseAutoDismissTimer(),
          onPanUpdate: (details) {
            setState(() {
              _dragOffset += details.delta;
            });
          },
          onPanEnd: (_) {
            final shouldDismiss =
                _dragOffset.dx.abs() > 140 || _dragOffset.dy.abs() > 120;
            if (shouldDismiss) {
              _dismiss();
              return;
            }

            setState(() {
              _dragOffset = Offset.zero;
            });
            _resumeAutoDismissTimer();
          },
          onPanCancel: () {
            setState(() {
              _dragOffset = Offset.zero;
            });
            _resumeAutoDismissTimer();
          },
          child: Material(
            color: toastStyle.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: toastStyle.borderColor),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x330F172A),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(toastStyle.icon, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
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

  _ToastStyle _toastStyle(AppToastType type) {
    switch (type) {
      case AppToastType.success:
        return const _ToastStyle(
          backgroundColor: Color(0xFF16A34A),
          borderColor: Color(0xFF22C55E),
          icon: Icons.check_circle,
        );
      case AppToastType.error:
        return const _ToastStyle(
          backgroundColor: Color(0xFFDC2626),
          borderColor: Color(0xFFEF4444),
          icon: Icons.error,
        );
      case AppToastType.warning:
        return const _ToastStyle(
          backgroundColor: Color(0xFFD97706),
          borderColor: Color(0xFFF59E0B),
          icon: Icons.warning_amber_rounded,
        );
      case AppToastType.info:
        return const _ToastStyle(
          backgroundColor: Color(0xFF0F172A),
          borderColor: Color(0xFF334155),
          icon: Icons.info,
        );
    }
  }
}

class _ToastStyle {
  const _ToastStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
  });

  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
}
