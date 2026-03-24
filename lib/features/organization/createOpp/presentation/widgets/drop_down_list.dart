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
    this.onMultiChanged,
  });
  final String labeltext;
  final Icon icon;
  final bool multiValues;
  final List<String> options;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<List<String>>? onMultiChanged;
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
    if (widget.multiValues) {
      widget.onMultiChanged?.call(const []);
    } else {
      widget.onChanged?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              key: ValueKey(
                '${widget.multiValues}-${selectedValue ?? ''}-${selectedItems.length}',
              ),
              initialValue: selectedValue,
              isExpanded: true,
              icon: const SizedBox.shrink(),
              borderRadius: BorderRadius.circular(10),
              dropdownColor: AppColors.greyLight,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
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
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 48,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              items: widget.options.asMap().entries.map((entry) {
                final index = entry.key;
                final option = entry.value;

                return DropdownMenuItem<String>(
                  value: option,
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              }).toList(),
              selectedItemBuilder: (context) {
                return widget.options.map((option) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      option,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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

                if (widget.multiValues) {
                  widget.onMultiChanged?.call(List.unmodifiable(selectedItems));
                } else {
                  widget.onChanged?.call(newValue);
                }
              },
            ),
            const SizedBox(height: 8),
            if (selectedItems.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectedItems.map((item) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Chip(
                            backgroundColor: AppColors.primary,
                            label: CustomText(
                              item,
                              color: AppColors.white,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedItems.remove(item);
                            });
                            widget.onMultiChanged?.call(
                              List.unmodifiable(selectedItems),
                            );
                          },
                          child: Image.asset(AppAssets.removeTrashIcon),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
          ],
        );
      },
    );
  }
}
