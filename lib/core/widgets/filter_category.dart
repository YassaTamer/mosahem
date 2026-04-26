import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class FilterCategory extends StatelessWidget {
  const FilterCategory({
    super.key,
    required this.categoryName,
    required this.options,
    required this.selectedItems,
    required this.onSelect,
  });
  final String categoryName;
  final List<String> options;
  final List<String> selectedItems;
  final Function(String) onSelect;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            categoryName,
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),

          SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options.map((item) {
              final isSelected = selectedItems.contains(item);

              return GestureDetector(
                onTap: () => onSelect(item),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.primaryLightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.textGrey,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
