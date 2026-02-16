import 'package:flutter/material.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/check_boxes_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/multiple_choice_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/paragraph_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_container_of_question.dart';

class AddQuestionsView extends StatelessWidget {
  const AddQuestionsView({super.key});

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
              "Add Questions",
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          CustomContainer(
            title: "Paragraph",
            description: "Let users write a long text answer",
            image: AppAssets.paragraphIcon,
            widthBetweenTextImage: 47,
            ontap: ParagraphView(),
          ),
          SizedBox(height: 10),
          CustomContainer(
            title: "Multiple Choice",
            description: "Let users choose one option from a list",
            image: AppAssets.multipleChoiceIcon,
            widthBetweenTextImage: 10,
            ontap: MultipleChoiceView(),
          ),
          SizedBox(height: 10),
          CustomContainer(
            title: "Check Boxes",
            description: "Let users select one or more options",
            image: AppAssets.checkBoxesIcon,
            widthBetweenTextImage: 25,
            ontap: CheckBoxesView(),
          ),
        ],
      ),
    );
  }
}
