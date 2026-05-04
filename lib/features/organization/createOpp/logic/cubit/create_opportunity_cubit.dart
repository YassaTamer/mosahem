import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:mosahem/core/helpers/cache_helper.dart';
import 'package:mosahem/features/auth/data/models/branch_location_model.dart';
import 'package:mosahem/features/organization/createOpp/data/models/create_opportunity_request_model.dart';
import 'package:mosahem/features/organization/createOpp/data/models/skill_model.dart';
import 'package:mosahem/features/organization/createOpp/data/repository/create_opportunity_repository.dart';

part 'create_opportunity_state.dart';

class CreateOpportunityCubit extends Cubit<CreateOpportunityState> {
  final CreateOpportunityRepository repository;
  final CreateOpportunityRequestModel opportunity =
      CreateOpportunityRequestModel();
  List<SkillModel> skills = [];

  CreateOpportunityCubit(this.repository)
    : super(const CreateOpportunityState());

  Future<void> getSkills() async {
    emit(
      state.copyWith(
        skillsStatus: SkillsRequestStatus.loading,
        clearSkillsErrorMessage: true,
      ),
    );

    try {
      skills = await repository.getSkills();
      emit(
        state.copyWith(
          skillsStatus: SkillsRequestStatus.success,
          clearSkillsErrorMessage: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          skillsStatus: SkillsRequestStatus.error,
          skillsErrorMessage: _extractErrorMessage(error),
        ),
      );
    }
  }

  Future<void> createOpportunity() async {
    emit(
      state.copyWith(
        submissionStatus: CreateOpportunitySubmissionStatus.initial,
      ),
    );
    final organizationId =
        await CacheHelper.getOrganizationId(); // 🔥 check لو كله فاضي
    bool isAllEmpty =
        (opportunity.title == null || opportunity.title!.isEmpty) &&
        (opportunity.description == null || opportunity.description!.isEmpty) &&
        (opportunity.addresses == null || opportunity.addresses!.isEmpty) &&
        (opportunity.startDate == null) &&
        (opportunity.endDate == null) &&
        (opportunity.numberOfVolunteers == null ||
            opportunity.numberOfVolunteers == 0) &&
        (opportunity.locationType == null) &&
        (opportunity.workType == null);

    if (isAllEmpty) {
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.error,
          submissionErrorMessage: 'Please fill required fields',
        ),
      );
      return;
    }
    if (organizationId == null || organizationId.isEmpty) {
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.error,
          submissionErrorMessage:
              'Organization ID is missing. Please log in again.',
        ),
      );
      return;
    }

    opportunity.organizationId = organizationId;
    if (opportunity.title == null || opportunity.title!.isEmpty) {
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.error,
          submissionErrorMessage: 'Title is required',
        ),
      );
      return;
    }

    if (opportunity.description == null || opportunity.description!.isEmpty) {
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.error,
          submissionErrorMessage: 'Description is required',
        ),
      );
      return;
    }
    if (opportunity.addresses == null) {
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.error,
          submissionErrorMessage: 'Address is required',
        ),
      );
      return;
    }

    if (opportunity.startDate == null || opportunity.endDate == null) {
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.error,
          submissionErrorMessage: 'Start date and End date is required',
        ),
      );
      return;
    }
    if (opportunity.numberOfVolunteers == null) {
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.error,
          submissionErrorMessage: 'Number Of Volunteers is required',
        ),
      );
      return;
    }
    if (opportunity.workType == null || opportunity.locationType == null) {
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.error,
          submissionErrorMessage: 'Work location and Work Type  is required',
        ),
      );
      return;
    }

    //print("HEADERS: ${dio.options.headers}");
    // print(opportunity.toJson());
    // print(jsonEncode(opportunity.toJson()));
    try {
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.loading,
          clearSubmissionErrorMessage: true,
        ),
      );

      final response = await repository.createOpportunity(opportunity);

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(
          state.copyWith(
            submissionStatus: CreateOpportunitySubmissionStatus.success,
            clearSubmissionErrorMessage: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            submissionStatus: CreateOpportunitySubmissionStatus.error,
            submissionErrorMessage: 'Unexpected error',
          ),
        );
      }
    } catch (error) {
      // print("❌ ERROR: $error");

      String errorMessage = _extractErrorMessage(error);

      if (error is DioException) {
        //  print("📡 STATUS CODE: ${error.response?.statusCode}");
        //   print("📩 RESPONSE DATA: ${error.response?.data}");

        final data = error.response?.data;

        if (data != null) {
          // لو فيه validation errors
          if (data['Errors'] != null) {
            final errors = data['Errors'] as Map<String, dynamic>;

            if (errors.isNotEmpty) {
              final firstError = errors.values.first;

              if (firstError is List && firstError.isNotEmpty) {
                errorMessage = firstError.first.toString();
              }
            } else if (data['Message'] != null) {
              // لو مفيش validation errors نستخدم message
              errorMessage = data['Message'];
            }
          }
          // fallback على message العامة
          else if (data['Message'] != null) {
            errorMessage = data['Message'];
          }
        }
      }

      // print("📌 STACK TRACE: $stackTrace");

      /// 🔥 أهم سطر
      emit(
        state.copyWith(
          submissionStatus: CreateOpportunitySubmissionStatus.error,
          submissionErrorMessage: errorMessage,
        ),
      );
    }
  }

  void addAddress(BranchLocationModel address) {
    opportunity.addresses ??= [];

    opportunity.addresses!.add(
      AddressModel(
        governorateId: address.governorateId,
        cityId: address.cityId,
        description: address.details,
      ),
    );
  }

  void updateFieldIds(List<String> fieldIds) {
    opportunity.fieldIds = List<String>.from(fieldIds);
  }

  void updateRequiredSkillIds(List<String> skillIds) {
    opportunity.requiredSkillIds = List<String>.from(skillIds);
  }

  void updateProvidedSkillIds(List<String> skillIds) {
    opportunity.providedSkillIds = List<String>.from(skillIds);
  }

  List<String> mapSkillNamesToIds(List<String> skillNames) {
    final selectedNames = skillNames.toSet();

    return skills
        .where((skill) => selectedNames.contains(skill.name))
        .map((skill) => skill.id)
        .toList(growable: false);
  }

  String _extractErrorMessage(Object error) {
    const exceptionPrefix = 'Exception: ';
    final message = error.toString();

    if (message.startsWith(exceptionPrefix)) {
      return message.substring(exceptionPrefix.length);
    }

    return message;
  }

  void addQuestion(QuestionModel question) {
    opportunity.questions ??= [];
    opportunity.questions!.add(question);
  }
}
