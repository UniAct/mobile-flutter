import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/widgets/searchable_dropdown.dart';

class UniversitySearchField extends StatelessWidget {
  const UniversitySearchField({
    super.key,
    required this.controller,
    required this.filteredOptions,
    required this.onQueryChanged,
    required this.onSelect,
    required this.showSuggestions,
    this.selectedUniversity,
  });

  final TextEditingController controller;
  final List<String> filteredOptions;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<String> onSelect;
  final bool showSuggestions;
  final String? selectedUniversity;

  @override
  Widget build(BuildContext context) {
    return SearchableDropdown(
      controller: controller,
      options: filteredOptions,
      onChanged: onQueryChanged,
      onSelect: onSelect,
      isOpen: showSuggestions,
      selectedValue: selectedUniversity,
    );
  }
}
