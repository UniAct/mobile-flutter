import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';

enum LoadingIndicatorVariant { bootstrap, compact }

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({
    super.key,
    this.message,
    this.variant = LoadingIndicatorVariant.compact,
    this.stepDuration = const Duration(milliseconds: 1200),
  });

  final String? message;
  final LoadingIndicatorVariant variant;
  final Duration stepDuration;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with TickerProviderStateMixin {
  static const List<String> _phaseLabels = <String>[
    'Initializing',
    'Synchronizing',
    'Ready',
  ];

  late final AnimationController _orbitController;
  late final AnimationController _pulseController;
  late final AnimationController _progressController;

  int _phaseIndex = 0;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _progressController = AnimationController(
      vsync: this,
      duration: widget.stepDuration,
    )..forward();

    _startPhaseLoop();
  }

  Future<void> _startPhaseLoop() async {
    while (mounted) {
      await Future<void>.delayed(widget.stepDuration);
      if (!mounted) {
        return;
      }
      setState(() {
        _phaseIndex = (_phaseIndex + 1) % _phaseLabels.length;
      });
      _progressController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variant == LoadingIndicatorVariant.compact) {
      return _buildCompact(context);
    }

    return _buildBootstrap(context);
  }

  Widget _buildBootstrap(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final shortest = constraints.biggest.shortestSide;
        final logoSize = shortest.clamp(118.0, 210.0);
        final titleSize = shortest < 360 ? 24.0 : 30.0;

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFF0F7FF),
                AppColors.background,
                Color(0xFFDCEBFF),
              ],
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 30,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: logoSize,
                      height: logoSize,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          _buildOrbitingUniversities(),
                          _buildCoreHub(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'UniAct',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontSize: titleSize,
                            foreground: Paint()
                              ..shader =
                                  const LinearGradient(
                                    colors: [
                                      Color(0xFF3B82F6),
                                      Color(0xFF1D4ED8),
                                    ],
                                  ).createShader(
                                    const Rect.fromLTWH(0, 0, 220, 40),
                                  ),
                          ),
                    ),
                    const SizedBox(height: 10),
                    _buildPhaseDots(),
                    const SizedBox(height: 14),
                    Text(
                      widget.message ?? 'Initializing tenant infrastructure...',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    _buildProgressBar(),
                    const SizedBox(height: 12),
                    Text(
                      '${_phaseLabels[_phaseIndex]}...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCompact(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          if (widget.message != null) ...[
            const SizedBox(height: 12),
            Text(widget.message!),
          ],
        ],
      ),
    );
  }

  Widget _buildCoreHub() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final scale = 1 + (_pulseController.value * 0.08);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrbitingUniversities() {
    return AnimatedBuilder(
      animation: _orbitController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _orbitController.value * 6.283185307179586,
          child: child,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: const [
          _OrbitNode(alignment: Alignment(0, -0.95)),
          _OrbitNode(alignment: Alignment(0.95, 0)),
          _OrbitNode(alignment: Alignment(0, 0.95)),
          _OrbitNode(alignment: Alignment(-0.95, 0)),
        ],
      ),
    );
  }

  Widget _buildPhaseDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(_phaseLabels.length, (index) {
        final isActive = index == _phaseIndex;
        final isComplete = index < _phaseIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 12 : 10,
          height: isActive ? 12 : 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive || isComplete
                ? AppColors.primary
                : AppColors.border,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.28),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }

  Widget _buildProgressBar() {
    final baseProgress = (_phaseIndex + 1) / _phaseLabels.length;
    final animatedProgress = (_progressController.value / _phaseLabels.length);
    final value = (baseProgress - (1 / _phaseLabels.length) + animatedProgress)
        .clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 4,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: AppColors.secondary,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }
}

class _OrbitNode extends StatelessWidget {
  const _OrbitNode({required this.alignment});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.55)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.18),
              blurRadius: 10,
            ),
          ],
        ),
        child: const Icon(
          Icons.account_balance,
          size: 18,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
