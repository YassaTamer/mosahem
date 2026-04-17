part of 'create_opportunity_cubit.dart';

enum SkillsRequestStatus { initial, loading, success, error }

enum CreateOpportunitySubmissionStatus { initial, loading, success, error }

@immutable
class CreateOpportunityState {
  final SkillsRequestStatus skillsStatus;
  final CreateOpportunitySubmissionStatus submissionStatus;
  final String? skillsErrorMessage;
  final String? submissionErrorMessage;

  const CreateOpportunityState({
    this.skillsStatus = SkillsRequestStatus.initial,
    this.submissionStatus = CreateOpportunitySubmissionStatus.initial,
    this.skillsErrorMessage,
    this.submissionErrorMessage,
  });

  CreateOpportunityState copyWith({
    SkillsRequestStatus? skillsStatus,
    CreateOpportunitySubmissionStatus? submissionStatus,
    String? skillsErrorMessage,
    String? submissionErrorMessage,
    bool clearSkillsErrorMessage = false,
    bool clearSubmissionErrorMessage = false,
  }) {
    return CreateOpportunityState(
      skillsStatus: skillsStatus ?? this.skillsStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      skillsErrorMessage: clearSkillsErrorMessage
          ? null
          : skillsErrorMessage ?? this.skillsErrorMessage,
      submissionErrorMessage: clearSubmissionErrorMessage
          ? null
          : submissionErrorMessage ?? this.submissionErrorMessage,
    );
  }
}
