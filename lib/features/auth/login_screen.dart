import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_flutter/app/router.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/utils/connection_monitor.dart';
import 'package:mobile_flutter/core/utils/helpers.dart';
import 'package:mobile_flutter/core/utils/validators.dart';
import 'package:mobile_flutter/features/auth/auth_service.dart';
import 'package:mobile_flutter/features/auth/university_model.dart';
import 'package:mobile_flutter/features/auth/university_service.dart';
import 'package:mobile_flutter/features/auth/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final UniversityService _universityService = UniversityService();
  final _formKey = GlobalKey<FormState>();
  final _universityController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isUniversitiesLoading = true;
  bool _isLoading = false;
  String _errorMessage = '';
  List<UniversityModel> _universities = const <UniversityModel>[];
  List<UniversityModel> _filteredUniversities = const <UniversityModel>[];
  String? _selectedUniversity;
  bool _showUniversitySuggestions = false;
  StreamSubscription<bool>? _connectionSubscription;

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    AppRouter.isOnLoginRoute = true;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _loadUniversities();
    _animationController.forward();
    _connectionSubscription = ConnectionMonitor().onStatusChanged.listen((
      isConnected,
    ) {
      if (!isConnected || !mounted) {
        return;
      }

      setState(() {
        _errorMessage = '';
      });

      _loadUniversities();
    });
  }

  @override
  void dispose() {
    AppRouter.isOnLoginRoute = false;
    _connectionSubscription?.cancel();
    _animationController.dispose();
    _universityController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadUniversities() async {
    setState(() {
      _isUniversitiesLoading = true;
      _errorMessage = '';
    });

    try {
      final universities = await _universityService.getUniversities();
      if (mounted) {
        setState(() {
          // Keep typed login credentials intact; university loading only updates
          // selector options and error UI.
          _universities = universities;
          _filteredUniversities = universities;
        });
      }
    } catch (e) {
      if (mounted) {
        final message = AppHelpers.userErrorMessage(e);
        setState(() {
          // Do not clear email/password here. setState preserves the controller
          // instances owned by _LoginScreenState.
          _errorMessage = message;
        });
        AppHelpers.showError(context, message);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUniversitiesLoading = false;
        });
      }
    }
  }

  Future<void> _onLoginPressed() async {
    final formState = _formKey.currentState;
    if (formState == null || !formState.validate()) {
      return;
    }

    final selectedUniversity = _selectedUniversity;
    if (selectedUniversity == null || selectedUniversity.isEmpty) {
      AppHelpers.showMessage(context, 'Please select a university');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _authService.login(
        universityName: selectedUniversity,
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) {
        return;
      }
      Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
    } catch (e) {
      if (mounted) {
        final message = AppHelpers.userErrorMessage(e);
        setState(() {
          _errorMessage = message;
        });
        AppHelpers.showError(context, message);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onUniversityQueryChanged(String query) {
    final normalized = query.trim().toLowerCase();
    final filtered = _universities.where((university) {
      return university.name.toLowerCase().contains(normalized);
    }).toList();

    setState(() {
      _selectedUniversity = null;
      _showUniversitySuggestions = normalized.isNotEmpty;
      _filteredUniversities = filtered;
    });
  }

  void _onUniversitySelected(String universityName) {
    setState(() {
      _selectedUniversity = universityName;
      _universityController.text = universityName;
      _showUniversitySuggestions = false;
      _filteredUniversities = _universities;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8F7F4), Color(0xFFF7F8FA), Color(0xFFF1F5F9)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: isDesktop ? 980 : 460),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(AppSpacing.lg),
                                  child: const _BrandingBlock(isDesktop: true),
                                ),
                              ),
                              Expanded(child: _buildLoginForm()),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(AppSpacing.md),
                                child: _BrandingBlock(isDesktop: false),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _buildLoginForm(),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return LoginForm(
      emailController: _emailController,
      passwordController: _passwordController,
      universityController: _universityController,
      formKey: _formKey,
      filteredUniversities: _filteredUniversities.map((u) => u.name).toList(),
      showUniversitySuggestions: _showUniversitySuggestions,
      onUniversityQueryChanged: _onUniversityQueryChanged,
      onUniversitySelected: _onUniversitySelected,
      onLogin: _onLoginPressed,
      isLoading: _isLoading,
      isUniversityLoading: _isUniversitiesLoading,
      errorMessage: _errorMessage,
      selectedUniversity: _selectedUniversity,
      emailValidator: Validators.email,
      passwordValidator: Validators.password,
    );
  }
}

class _BrandingBlock extends StatelessWidget {
  const _BrandingBlock({required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineLarge;
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Hero(
          tag: 'app-logo',
          child: Image.asset(
            'assets/images/logo.png',
            width: 72,
            height: 72,
            filterQuality: FilterQuality.high,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text('UniAct', style: titleStyle),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Digital University Ecosystem',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Manage multi-tenant university operations with a secure and modern platform.',
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'University Management System',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
