import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class LabeledFieldRow extends StatelessWidget {
  LabeledFieldRow({
    super.key,
    required this.label,
    required this.hint,
    required this.isRequired,
    required this.items,
    required this.onSelect,
    this.lableFontSize,
    this.lablefontWeight,
    required this.selectedItems,
    this.isMultiSelect = false,
  });
  final String? label;
  final String hint;
  final bool isRequired;
  final List<String> items;
  final Function(List<String>) onSelect;
  final List<String> selectedItems;
  final bool isMultiSelect;
  final GlobalKey _fieldKey = GlobalKey();

  final double? lableFontSize;
  final FontWeight? lablefontWeight;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Row(
            children: [
              if (label != null)
                CustomText(
                  label!,
                  fontSize: lableFontSize ?? 14,
                  fontWeight: lablefontWeight ?? FontWeight.w500,
                ),
              if (isRequired) const CustomText(' *', color: Colors.red),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: GestureDetector(
            onTap: () async {
              if (items.isEmpty) return;
              List<String> tempSelected = [...selectedItems];

              final RenderBox renderBox =
                  _fieldKey.currentContext!.findRenderObject() as RenderBox;
              final RenderBox overlay =
                  Overlay.of(context).context.findRenderObject() as RenderBox;

              final position = renderBox.localToGlobal(
                Offset.zero,
                ancestor: overlay,
              );

              final selected = await showMenu<String>(
                context: context,
                color: AppColors.greyLight,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                position: RelativeRect.fromLTRB(
                  position.dx + 50,
                  position.dy + renderBox.size.height,
                  position.dx + renderBox.size.width + 10,
                  position.dy + 50,
                ),
                items: items.asMap().entries.map((entry) {
                  int index = entry.key;
                  String item = entry.value;
                  return PopupMenuItem<String>(
                    value: item,
                    padding: EdgeInsets.zero,
                    height: 0, //  مهم
                    child: Container(
                      width: double.infinity, //  ياخد العرض كامل
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: index == items.length - 1
                                ? Colors
                                      .transparent //  آخر عنصر ملوش خط
                                : Colors.white,
                            width: 1,
                          ),
                        ),
                      ),
                      child: CustomText(
                        item,
                        color: AppColors.primaryDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              );

              if (selected != null) {
                if (isMultiSelect) {
                  tempSelected.add(selected);
                  onSelect(tempSelected);
                } else {
                  onSelect([selected]);
                }
              }
            },

            child: SizedBox(
              width: double.infinity,

              child: Container(
                key: _fieldKey,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.primaryDark),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        hint,
                        fontSize: 12,
                        color: Colors.grey.shade900,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.primaryDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
