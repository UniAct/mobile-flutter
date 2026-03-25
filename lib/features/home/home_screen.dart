import 'package:flutter/material.dart';
import 'package:mobile_flutter/app/router.dart';
import 'package:mobile_flutter/core/utils/helpers.dart';
import 'package:mobile_flutter/core/widgets/app_button.dart';
import 'package:mobile_flutter/core/widgets/loading_indicator.dart';
import 'package:mobile_flutter/features/auth/auth_service.dart';
import 'package:mobile_flutter/features/auth/user_model.dart';
import 'package:mobile_flutter/features/home/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserService _userService = UserService();
  final AuthService _authService = AuthService();

  bool _isLoading = true;
  String? _error;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final user = await _userService.getCurrentUser();
      if (mounted) {
        setState(() {
          _user = user;
        });
      }
    } catch (e) {
      if (mounted) {
        final message = AppHelpers.userErrorMessage(e);
        setState(() {
          _error = message;
        });
        AppHelpers.showMessage(context, message);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _logout() async {
    try {
      await _authService.logout();
      if (!mounted) {
        return;
      }

      Navigator.pushReplacementNamed(context, AppRouter.loginRoute);
    } catch (e) {
      if (mounted) {
        AppHelpers.showMessage(context, AppHelpers.userErrorMessage(e));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(padding: const EdgeInsets.all(16), child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingIndicator(message: 'Loading profile...');
    }

    if (_error != null) {
      final errorText = _error ?? 'Unknown error';
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorText, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _loadUser, child: const Text('Retry')),
          ],
        ),
      );
    }

    final user = _user;
    if (user == null) {
      return const Center(child: Text('User not found'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome, ${user.name}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        Text('Email: ${user.email}'),
        const SizedBox(height: 6),
        Text('University: ${user.universityName}'),
        const SizedBox(height: 6),
        Text('Role: ${user.primaryRole}'),
        const Spacer(),
        AppButton(text: 'Logout', onPressed: _logout),
      ],
    );
  }
}
