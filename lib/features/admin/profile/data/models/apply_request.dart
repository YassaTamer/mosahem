class ApplyRequest {
  final List<AnswerModel> answers;

  const ApplyRequest({required this.answers});

  Map<String, dynamic> toJson() {
    return {'Answers': answers.map((answer) => answer.toJson()).toList()};
  }
}

class AnswerModel {
  final String questionId;
  final String? answerText;
  final int? choiceKey;
  final List<String>? selectedChoices;

  AnswerModel({
    required this.questionId,
    this.answerText,
    this.choiceKey,
    this.selectedChoices,
  });

  Map<String, dynamic> toJson() {
    return {
      'QuestionId': questionId,
      'AnswerText': answerText,
      'ChoiceKey': choiceKey,
      'SelectedChoices': selectedChoices,
    };
  }
}
