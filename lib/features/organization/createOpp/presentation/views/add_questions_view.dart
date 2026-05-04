import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_assets.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/widgets/custom_text.dart';
import 'package:mosahem/features/organization/createOpp/logic/cubit/create_opportunity_cubit.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/check_boxes_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/multiple_choice_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/views/paragraph_view.dart';
import 'package:mosahem/features/organization/createOpp/presentation/widgets/custom_container_of_question.dart';

class AddQuestionsView extends StatefulWidget {
  const AddQuestionsView({super.key});

  @override
  State<AddQuestionsView> createState() => _AddQuestionsViewState();
}

class _AddQuestionsViewState extends State<AddQuestionsView> {
  String _questionTypeName(int type) {
    switch (type) {
      case 0:
        return "Paragraph";
      case 2:
        return "Multiple Choice";
      case 3:
        return "Check Boxes";
      default:
        return "Question";
    }
  }

  Future<void> _navigateTo(Widget view) async {
    final cubit = context.read<CreateOpportunityCubit>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(value: cubit, child: view),
      ),
    );
    setState(() {}); // ← يتحدث لما يرجع
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateOpportunityCubit>();
    final questions = cubit.opportunity.questions ?? [];

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
          // ← أزرار الإضافة الأول
          CustomContainer(
            title: "Paragraph",
            description: "Let users write a long text answer",
            image: AppAssets.paragraphIcon,
            widthBetweenTextImage: 47,
            ontap: const ParagraphView(),
            onTapCallback: () => _navigateTo(const ParagraphView()),
          ),
          const SizedBox(height: 10),
          CustomContainer(
            title: "Multiple Choice",
            description: "Let users choose one option from a list",
            image: AppAssets.multipleChoiceIcon,
            widthBetweenTextImage: 10,
            ontap: const MultipleChoiceView(),
            onTapCallback: () => _navigateTo(const MultipleChoiceView()),
          ),
          const SizedBox(height: 10),
          CustomContainer(
            title: "Check Boxes",
            description: "Let users select one or more options",
            image: AppAssets.checkBoxesIcon,
            widthBetweenTextImage: 25,
            ontap: const CheckBoxesView(),
            onTapCallback: () => _navigateTo(const CheckBoxesView()),
          ),
          const SizedBox(height: 16),

          // ← الأسئلة المضافة تحت
          if (questions.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLightBlue,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            q.answerType == 0
                                ? Icons.short_text
                                : q.answerType == 2
                                ? Icons.radio_button_checked
                                : Icons.check_box,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                q.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColors.textBlueDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    _questionTypeName(q.answerType),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  if (q.isRequired) ...[
                                    const SizedBox(width: 8),
                                    const Text(
                                      "Required",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.red,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              cubit.opportunity.questions!.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.check_rounded, color: Colors.white),
                label: const Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
