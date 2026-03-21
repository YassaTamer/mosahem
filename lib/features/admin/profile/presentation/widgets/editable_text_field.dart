import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';

class EditableTextField extends StatefulWidget {
  const EditableTextField({
    super.key,
    required this.label,
    required this.controller,
  });
  final String label;
  final TextEditingController controller;

  @override
  State<EditableTextField> createState() => _EditableTextFieldState();
}

class _EditableTextFieldState extends State<EditableTextField> {
  bool isEditing = false;
  FocusNode focusNode = FocusNode();

  void enableEditing() {
    setState(() {
      isEditing = true;
    });
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.label),
        SizedBox(width: 20),
        Expanded(
          child: CustomTextField(
            onSubmitted: (value) {
              setState(() {
                isEditing = false;
              });
              focusNode.unfocus();
            },
            textEditingController: widget.controller,
            focusNode: focusNode,
            readonly: !isEditing,
            keyboardType: widget.label == "Phone number:"
                ? TextInputType.numberWithOptions()
                : TextInputType.text,
          ),
        ),
        IconButton(
          onPressed: () {
            enableEditing();
          },
          icon: Image.asset(AppAssets.editRightArrow),
        ),
      ],
    );
  }
}
