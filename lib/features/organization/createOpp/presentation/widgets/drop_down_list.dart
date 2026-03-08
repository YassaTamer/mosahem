import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class DropDownList extends StatefulWidget {
  const DropDownList({
    super.key,
    required this.labeltext,
    required this.icon,
    this.multiValues = false,
    required this.options,
    this.onChanged,
  });
  final String labeltext;
  final Icon icon;
  final bool multiValues;
  final List<String> options;
  final Function(String?)? onChanged;
  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  String? selectedValue;
  List<String> selectedItems = [];
  void reset() {
    setState(() {
      selectedValue = null;
      selectedItems.clear();
    });
    widget.onChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          initialValue: selectedValue,
          borderRadius: BorderRadius.circular(10),
          dropdownColor: AppColors.greyLight,
          //menuMaxHeight: 250,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primary),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.primaryDark,
                width: 1.6,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            labelText: widget.labeltext,
            suffixIcon: widget.icon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6), // نفس LabeledFieldRow
            ),
          ),
          items: widget.options.asMap().entries.map((entry) {
            int index = entry.key;
            String option = entry.value;

            return DropdownMenuItem<String>(
              value: option,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: index == widget.options.length - 1
                          ? Colors.transparent
                          : Colors.white,
                      width: 1,
                    ),
                  ),
                ),
                child: CustomText(
                  option,
                  color: AppColors.primaryDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          selectedItemBuilder: (context) {
            return widget.options.map((option) {
              return Align(
                alignment: Alignment.centerLeft,
                child: CustomText(option),
              );
            }).toList();
          },
          onChanged: (newValue) {
            if (newValue == null) return;
            setState(() {
              if (widget.multiValues) {
                if (!selectedItems.contains(newValue)) {
                  selectedItems.add(newValue);
                }
                selectedValue = null;
              } else {
                selectedValue = newValue;
              }
            });
            if (!widget.multiValues) {
              widget.onChanged?.call(newValue);
            }
          },
        ),

        SizedBox(height: 5),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedItems.map((item) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Chip(
                  backgroundColor: AppColors.primary,
                  label: Text(item, style: TextStyle(color: AppColors.white)),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedItems.remove(item);
                    });
                  },
                  child: Image.asset(AppAssets.removeTrashIcon),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
