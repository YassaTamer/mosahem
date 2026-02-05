import 'package:flutter/material.dart';
import 'package:mosahem/core/widgets/custom_text.dart';

class DropDownList extends StatefulWidget {
  const DropDownList({super.key, required this.labeltext});
  final String labeltext;
  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  String? selectedValue;
  List<String> options = [
    'Cairo',
    'Alexandria',
    'Port Said',
    'Suez',
    'New Valley',
    'Luxor',
    'Giza',
    'Beheira',
    'Aswan',
    'Asyut',
    'Sohag',
    'Beni Suef',
    'Dakahlia',
    'Damietta',
    'Faiyum',
    'Gharbia',
    'Ismailia',
    'Kafr El Sheikh',
    'Matrouh',
    'Minya',
    'Monufia',
    'North sinai',
  ];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedValue,
      decoration: InputDecoration(
        labelText: widget.labeltext,
        suffixIcon: Icon(Icons.arrow_drop_down),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: CustomText(option),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedValue = newValue;
        });
      },
    );
  }
}
