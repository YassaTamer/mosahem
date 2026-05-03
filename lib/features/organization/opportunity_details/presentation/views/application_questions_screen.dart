import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosahem/core/constants/app_colors.dart';
import 'package:mosahem/core/helpers/app_snackbar_helper.dart';
import 'package:mosahem/features/admin/profile/data/models/apply_request.dart';
import 'package:mosahem/features/admin/profile/data/models/opportunity_model.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_cubit.dart';
import 'package:mosahem/features/admin/profile/logic/cubit/opportunity_state.dart';

enum QuestionType { text, multiChoice, singleChoice }

class AppQuestion {
  final int number;
  final String text;
  final QuestionType type;
  final List<String> options; // for multiChoice / singleChoice

  const AppQuestion({
    required this.number,
    required this.text,
    required this.type,
    this.options = const [],
  });
}

// ── Screen ────────────────────────────────────────────────────────────────────

class ApplicationQuestionsScreen extends StatefulWidget {
  final List<OpportunityQuestionModel> questions;
  final String opportunityId;

  const ApplicationQuestionsScreen({
    super.key,
    required this.questions,
    required this.opportunityId,
  });

  @override
  State<ApplicationQuestionsScreen> createState() =>
      _ApplicationQuestionsScreenState();
}

class _ApplicationQuestionsScreenState
    extends State<ApplicationQuestionsScreen> {
  late final List<AppQuestion> _questions =
      widget.questions
          .map(
            (question) => AppQuestion(
              number: question.order,
              text: question.description,
              type: _mapQuestionType(question.answerType),
              options: question.options,
            ),
          )
          .toList()
        ..sort((a, b) => a.number.compareTo(b.number));

  // Answers state
  final Map<int, String> _textAnswers = {}; // question index → text
  final Map<int, Set<String>> _multiAnswers = {}; // question index → selected
  final Map<int, String?> _singleAnswers = {}; // question index → selected

  int get _totalQuestions => _questions.length;

  int get _answeredCount {
    int count = 0;
    for (int i = 0; i < _questions.length; i++) {
      final q = _questions[i];
      if (q.type == QuestionType.text &&
          (_textAnswers[i]?.trim().isNotEmpty ?? false)) {
        count++;
      } else if (q.type == QuestionType.multiChoice &&
          (_multiAnswers[i]?.isNotEmpty ?? false)) {
        count++;
      } else if (q.type == QuestionType.singleChoice &&
          _singleAnswers[i] != null) {
        count++;
      }
    }
    return count;
  }

  bool get _allAnswered => _answeredCount == _totalQuestions;

  double get _progress =>
      _totalQuestions == 0 ? 0 : _answeredCount / _totalQuestions;

  QuestionType _mapQuestionType(String answerType) {
    switch (answerType.trim().toLowerCase()) {
      case 'singlechoice':
        return QuestionType.singleChoice;
      case 'multiplechoice':
        return QuestionType.multiChoice;
      case 'text':
      default:
        return QuestionType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildSubmitBar(),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          _buildProgressSection(),
          const SizedBox(height: 20),
          _buildHeaderCard(),
          const SizedBox(height: 20),
          ...List.generate(_questions.length, (i) {
            final q = _questions[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildQuestionCard(i, q),
            );
          }),
        ],
      ),
    );
  }

  // ── AppBar ────────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.primary,
          size: 18,
        ),
      ),
      title: const Text(
        'Application Questions',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      centerTitle: true,
    );
  }

  // ── Progress ──────────────────────────────────────────────────────────────

  Widget _buildProgressSection() {
    final pct = (_progress * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$_answeredCount of $_totalQuestions questions answered',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlueDark,
              ),
            ),
            Text(
              '$pct%',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: _progress,
            minHeight: 8,
            backgroundColor: AppColors.greyLight,
            valueColor: AlwaysStoppedAnimation<Color>(
              _progress < 1.0 ? AppColors.primary : AppColors.lightGreen,
            ),
          ),
        ),
      ],
    );
  }

  // ── Header card ───────────────────────────────────────────────────────────

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryLightBlue,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Almost There!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please answer the following questions to complete your application. This helps us match you with the right opportunity.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ── Question card dispatcher ──────────────────────────────────────────────

  Widget _buildQuestionCard(int index, AppQuestion q) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionHeader(index, q),
          const SizedBox(height: 16),
          if (q.type == QuestionType.text) _buildTextAnswer(index),
          if (q.type == QuestionType.multiChoice) _buildMultiChoice(index, q),
          if (q.type == QuestionType.singleChoice) _buildSingleChoice(index, q),
        ],
      ),
    );
  }

  Widget _buildQuestionHeader(int index, AppQuestion q) {
    // Number badge colour: blue for text, green for others
    final badgeColor = q.type == QuestionType.text
        ? AppColors.primary
        : AppColors.lightGreen;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            '${q.number}',
            style: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              q.text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textBlueDark,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Text answer ───────────────────────────────────────────────────────────

  Widget _buildTextAnswer(int index) {
    return TextField(
      onChanged: (val) => setState(() => _textAnswers[index] = val),
      maxLines: 4,
      style: const TextStyle(fontSize: 14, color: AppColors.textBlueDark),
      decoration: InputDecoration(
        hintText: 'Type your answer here...',
        hintStyle: const TextStyle(color: AppColors.greyLight, fontSize: 14),
        filled: true,
        fillColor: const Color(0xffF8FAFC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  // ── Multi-choice answer ───────────────────────────────────────────────────

  Widget _buildMultiChoice(int index, AppQuestion q) {
    final selected = _multiAnswers[index] ?? {};
    return Column(
      children: q.options.map((option) {
        final isSelected = selected.contains(option);
        return GestureDetector(
          onTap: () {
            setState(() {
              final set = Set<String>.from(_multiAnswers[index] ?? {});
              if (isSelected) {
                set.remove(option);
              } else {
                set.add(option);
              }
              _multiAnswers[index] = set;
            });
          },
          child: _buildOptionTile(
            label: option,
            isSelected: isSelected,
            isMulti: true,
          ),
        );
      }).toList(),
    );
  }

  // ── Single-choice answer ──────────────────────────────────────────────────

  Widget _buildSingleChoice(int index, AppQuestion q) {
    final selected = _singleAnswers[index];
    return Column(
      children: q.options.map((option) {
        final isSelected = selected == option;
        return GestureDetector(
          onTap: () => setState(() => _singleAnswers[index] = option),
          child: _buildOptionTile(
            label: option,
            isSelected: isSelected,
            isMulti: false,
          ),
        );
      }).toList(),
    );
  }

  // ── Shared option tile ────────────────────────────────────────────────────

  Widget _buildOptionTile({
    required String label,
    required bool isSelected,
    required bool isMulti,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary.withOpacity(0.06)
            : AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.grey,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          // checkbox or radio
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: isMulti ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: isMulti ? BorderRadius.circular(4) : null,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.greyLight,
                width: 1.8,
              ),
              color: isSelected ? AppColors.primary : AppColors.white,
            ),
            child: isSelected
                ? Icon(
                    isMulti ? Icons.check : Icons.circle,
                    color: AppColors.white,
                    size: isMulti ? 14 : 10,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.primary : AppColors.textBlueDark,
            ),
          ),
        ],
      ),
    );
  }

  // ── Submit bar ────────────────────────────────────────────────────────────

  Widget _buildSubmitBar() {
    return BlocConsumer<OpportunityCubit, OpportunityState>(
      listener: (context, state) {
        if (state is ApplyWithAnswersSuccess) {
          AppSnackBarHelper.success(context, state.message);
          // ← شيل Navigator.pop من هنا
        }

        // ← أضف ده: لما الـ details يتحدث، امشي
        if (state is OpportunityDetailsLoaded) {
          Navigator.pop(context); // ← ده هيرجعك للـ OpportunityDetailsScreen
        }

        if (state is ApplyWithAnswersError) {
          AppSnackBarHelper.error(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is ApplyWithAnswersLoading;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: (_allAnswered && !isLoading)
                        ? _submitApplication
                        : null,
                    icon: isLoading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.send_rounded, size: 18),
                    label: Text(
                      isLoading ? 'Submitting...' : 'Submit Application',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryDark,
                      foregroundColor: AppColors.white,
                      disabledBackgroundColor: AppColors.disabledButton,
                      disabledForegroundColor: AppColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                if (!_allAnswered && !isLoading) ...[
                  const SizedBox(height: 6),
                  const Text(
                    'Please answer all questions to submit',
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  void _submitApplication() {
    final answers = <AnswerModel>[];

    for (int i = 0; i < _questions.length; i++) {
      final q = _questions[i];
      final originalQ = widget.questions[i];

      switch (q.type) {
        case QuestionType.text:
          answers.add(
            AnswerModel(
              questionId: originalQ.id,
              answerText: _textAnswers[i] ?? '',
            ),
          );
          break;

        case QuestionType.singleChoice:
          final selectedText = _singleAnswers[i] ?? '';
          final choiceIndex = q.options.indexOf(selectedText);
          answers.add(
            AnswerModel(
              questionId: originalQ.id,
              choiceKey: choiceIndex >= 0 ? choiceIndex : 0,
            ),
          );
          break;

        case QuestionType.multiChoice:
          answers.add(
            AnswerModel(
              questionId: originalQ.id,
              selectedChoices: (_multiAnswers[i] ?? {}).toList(),
            ),
          );
          break;
      }
    }

    context.read<OpportunityCubit>().applyWithAnswers(
      widget.opportunityId,
      ApplyRequest(answers: answers),
    );
  }
}
