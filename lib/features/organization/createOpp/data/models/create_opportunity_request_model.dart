class CreateOpportunityRequestModel {
  String? organizationId;
  String? title;
  String? description;
  String? photoKey;
  int? workType;
  int? locationType;
  String? startDate;
  String? endDate;
  int? numberOfVolunteers;
  List<AddressModel>? addresses;
  List<String>? providedSkillIds;
  List<String>? requiredSkillIds;
  List<String>? fieldIds;
  List<QuestionModel>? questions;

  CreateOpportunityRequestModel({
    this.organizationId,
    this.title,
    this.description,
    this.photoKey,
    this.workType,
    this.locationType,
    this.startDate,
    this.endDate,
    this.numberOfVolunteers,
    this.addresses,
    this.providedSkillIds,
    this.requiredSkillIds,
    this.fieldIds,
    this.questions,
  });
  Map<String, dynamic> toJson() {
    return {
      "OrganizationId": organizationId,
      "Title": title,
      "Description": description,
      "PhotoKey": photoKey,
      "WorkType": workType,
      "LocationType": locationType,
      "StartDate": startDate,
      "EndDate": endDate,
      "NumberOfVolunteers": numberOfVolunteers,
      "Addresses": addresses?.map((e) => e.toJson()).toList(),
      "ProvidedSkillIds": providedSkillIds,
      "RequiredSkillIds": requiredSkillIds,
      "FieldIds": fieldIds,
      "Questions": questions?.map((e) => e.toJson()).toList(),
    };
  }
}

class QuestionModel {
  String description;
  int answerType;
  bool isRequired;
  List<String>? options;

  QuestionModel({
    required this.description,
    required this.answerType,
    required this.isRequired,
    this.options,
  });
  Map<String, dynamic> toJson() {
    return {
      "Description": description,
      "AnswerType": answerType,
      "IsRequired": isRequired,
      "Options": options,
    };
  }
}

class AddressModel {
  String governorateId;
  String cityId;
  String description;
  AddressModel({
    required this.governorateId,
    required this.cityId,
    required this.description,
  });
  Map<String, dynamic> toJson() {
    return {
      "GovernorateId": governorateId,
      "CityId": cityId,
      "Description": description,
    };
  }
}
