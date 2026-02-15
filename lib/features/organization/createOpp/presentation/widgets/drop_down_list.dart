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
  });
  final String labeltext;
  final Icon icon;
  final bool multiValues;
  final List<String> options;
  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  String? selectedValue;
  List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          initialValue: selectedValue,
          decoration: InputDecoration(
            labelText: widget.labeltext,
            suffixIcon: widget.icon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          ),
          items: widget.options.map((option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [CustomText(option), const Divider()],
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
