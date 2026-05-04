import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/core/widgets/custom_text_field.dart';
import 'package:mosahem/core/widgets/custom_enabled_disabled_button.dart';
import 'package:mosahem/features/organization/createOpp/data/models/create_opportunity_request_model.dart';
import 'package:mosahem/features/organization/createOpp/logic/cubit/create_opportunity_cubit.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_required_slide_button.dart';

class ParagraphView extends StatefulWidget {
  const ParagraphView({super.key});

  @override
  State<ParagraphView> createState() => _ParagraphViewState();
}

class _ParagraphViewState extends State<ParagraphView> {
  final TextEditingController _controller = TextEditingController();
  bool isButtonEnabled = false;
  bool isRequired = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        isButtonEnabled = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryLightBlue,
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(
            child: CustomText(
              "Paragraph",
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 25, right: 250),
            child: CustomText(
              "Question",
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CustomTextField(
              textEditingController: _controller,
              numberOfLines: 3,
              hintText: "Type your question here...",
            ),
          ),
          const SizedBox(height: 20),
          CustomRequiredButton(onChanged: (value) => isRequired = value),
          const SizedBox(height: 390),
          CustomEnabledDisabledButton(
            isEnabled: isButtonEnabled,
            buttonName: "Save Question",
            enabledColor: AppColors.primaryDark,
            disabledColor: AppColors.disabledButton,
            onTap: isButtonEnabled
                ? () {
                    context.read<CreateOpportunityCubit>().addQuestion(
                      QuestionModel(
                        description: _controller.text.trim(),
                        answerType: 0, // ← Text
                        isRequired: isRequired,
                        options: [],
                      ),
                    );
                    Navigator.pop(context);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
