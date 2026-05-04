import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_colors.dart';

class CustomDynamicOption extends StatefulWidget {
  final bool isMultiSelection;
  final Function(bool hasOptions) onOptionsChanged;
  final Function(List<String> options) onOptionsUpdated; // ← أضف ده

  const CustomDynamicOption({
    super.key,
    required this.isMultiSelection,
    required this.onOptionsChanged,
    required this.onOptionsUpdated, // ← أضف ده
  });

  @override
  State<CustomDynamicOption> createState() => _CustomDynamicQuestionState();
}

class _CustomDynamicQuestionState extends State<CustomDynamicOption> {
  final TextEditingController optionController = TextEditingController();
  List<String> options = [];
  String? selectedValue;
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: optionController,
                decoration: const InputDecoration(hintText: "Enter option"),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                if (optionController.text.isNotEmpty) {
                  setState(() {
                    options.add(optionController.text);
                    optionController.clear();
                  });
                  widget.onOptionsChanged(options.length >= 2);
                  widget.onOptionsUpdated(options); // ← أضف ده
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (widget.isMultiSelection)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              return Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Text(option),
                      value: selectedValues.contains(option),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            selectedValues.add(option);
                          } else {
                            selectedValues.remove(option);
                          }
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.red),
                    onPressed: () {
                      setState(() {
                        options.removeAt(index);
                        selectedValues.remove(option);
                      });
                      widget.onOptionsChanged(options.length >= 2);
                      widget.onOptionsUpdated(options); // ← أضف ده
                    },
                  ),
                ],
              );
            },
          )
        else
          RadioGroup<String>(
            groupValue: selectedValue,
            onChanged: (value) => setState(() => selectedValue = value),
            child: Column(
              children: options.asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        value: option,
                        title: Text(option),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          options.removeAt(index);
                          if (selectedValue == option) selectedValue = null;
                        });
                        widget.onOptionsChanged(options.length >= 2);
                        widget.onOptionsUpdated(options); // ← أضف ده
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
