import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';

class SearchableDropdown extends StatelessWidget {
  const SearchableDropdown({
    super.key,
    required this.controller,
    required this.options,
    required this.onChanged,
    required this.onSelect,
    required this.isOpen,
    this.selectedValue,
  });

  final TextEditingController controller;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSelect;
  final bool isOpen;
  final String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final shouldShowSuggestions = isOpen && options.isNotEmpty;
    final selected = selectedValue;
    final hasSelection = selected != null && selected.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: 'University',
            hintText: 'Search university name',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: hasSelection
                  ? const Icon(
                      Icons.check_circle,
                      key: ValueKey('selected'),
                      color: AppColors.primary,
                    )
                  : const SizedBox(
                      key: ValueKey('not-selected'),
                      width: 0,
                      height: 0,
                    ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          constraints: BoxConstraints(
            maxHeight: shouldShowSuggestions ? 220 : 0,
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 180),
            opacity: shouldShowSuggestions ? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x140F172A),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: options.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = options[index];
                  return InkWell(
                    onTap: () => onSelect(item),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.school_outlined, size: 18),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              item,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
