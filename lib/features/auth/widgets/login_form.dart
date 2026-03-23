import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';
import 'package:mobile_flutter/core/widgets/app_button.dart';
import 'package:mobile_flutter/core/widgets/app_card.dart';
import 'package:mobile_flutter/core/widgets/app_input.dart';
import 'package:mobile_flutter/features/auth/widgets/university_search_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.universityController,
    required this.formKey,
    required this.filteredUniversities,
    required this.showUniversitySuggestions,
    required this.onUniversityQueryChanged,
    required this.onUniversitySelected,
    required this.onLogin,
    required this.isLoading,
    required this.isUniversityLoading,
    required this.errorMessage,
    required this.selectedUniversity,
    required this.emailValidator,
    required this.passwordValidator,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController universityController;
  final GlobalKey<FormState> formKey;
  final List<String> filteredUniversities;
  final bool showUniversitySuggestions;
  final ValueChanged<String> onUniversityQueryChanged;
  final ValueChanged<String> onUniversitySelected;
  final VoidCallback onLogin;
  final bool isLoading;
  final bool isUniversityLoading;
  final String errorMessage;
  final String? selectedUniversity;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Welcome Back', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Sign in with your university account',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (isUniversityLoading)
              const Center(child: CircularProgressIndicator())
            else
              UniversitySearchField(
                controller: universityController,
                filteredOptions: filteredUniversities,
                onQueryChanged: onUniversityQueryChanged,
                onSelect: onUniversitySelected,
                showSuggestions: showUniversitySuggestions,
                selectedUniversity: selectedUniversity,
              ),
            const SizedBox(height: AppSpacing.md),
            AppInput(
              controller: emailController,
              label: 'Email',
              hint: 'name@university.edu',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.alternate_email,
              validator: emailValidator,
            ),
            const SizedBox(height: AppSpacing.md),
            AppInput(
              controller: passwordController,
              label: 'Password',
              obscureText: true,
              prefixIcon: Icons.lock_outline,
              validator: passwordValidator,
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              opacity: errorMessage.isEmpty ? 0 : 1,
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                child: Text(
                  errorMessage.isEmpty ? ' ' : errorMessage,
                  style: const TextStyle(
                    color: Color(0xFFDC2626),
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              text: 'Login',
              icon: Icons.login,
              isLoading: isLoading,
              onPressed: isUniversityLoading ? null : onLogin,
            ),
          ],
        ),
      ),
    );
  }
}
