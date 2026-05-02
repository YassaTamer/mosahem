import 'package:mosahem/features/organization/createOpp/data/models/skill_model.dart';

class OpportunityModel {
  final String id;
  final String name;
  final String organizationName;
  final String startDate;
  final String endDate;
  final String? logoUrl;
  final String? status;
  final String? opportunityPhotoUrl;
  final String? description;
  final String? location;
  final String? workType;
  final String? timeType;
  final int? likesCount;
  final int? commentsCount;
  final List<SkillModel>? requiredSkills;
  final List<SkillModel>? providedSkills;
  final int? applicantsCount;
  final int? numberOfVolunteers;
  final int? acceptedApplicantsCount;
  final int? rejectedApplicantsCount;
  final int? pendingApplicantsCount;
  final String? createdAt;
  OpportunityModel({
    required this.id,
    required this.name,
    required this.organizationName,
    required this.startDate,
    required this.endDate,
    this.logoUrl,
    this.status,
    this.opportunityPhotoUrl,
    this.description,
    this.location,
    this.workType,
    this.timeType,
    this.likesCount,
    this.commentsCount,
    this.requiredSkills,
    this.providedSkills,
    this.applicantsCount,
    this.numberOfVolunteers,
    this.acceptedApplicantsCount,
    this.rejectedApplicantsCount,
    this.pendingApplicantsCount,
    this.createdAt,
  });

  static String _stringValue(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static String? _nullableStringValue(dynamic value) {
    final text = _stringValue(value).trim();
    return text.isEmpty ? null : text;
  }

  static Map<String, dynamic>? _mapValue(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  static Map<String, dynamic>? _firstMapValue(dynamic value) {
    if (value is List && value.isNotEmpty) {
      return _mapValue(value.first);
    }
    return null;
  }

  static String? _firstStringValue(dynamic value) {
    if (value is List) {
      for (final item in value) {
        final text = _nullableStringValue(item);
        if (text != null) return text;
      }
      return null;
    }
    return _nullableStringValue(value);
  }

  static int? _intValue(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }

  factory OpportunityModel.fromJson(Map<String, dynamic> json) {
    final organization = _mapValue(json['Organization']);
    final firstLocation = _firstMapValue(json['Locations']);

    return OpportunityModel(
      id: _stringValue(json['OpportunityId']),
      name: _stringValue(json['OpportunityName']),
      organizationName: _stringValue(
        json['OrganizationName'] ?? organization?['OrganizationName'],
      ),
      startDate: _stringValue(json['StartDate']),
      endDate: _stringValue(json['EndDate']),
      logoUrl: _nullableStringValue(
        json['OrganizationLogoUrl'] ?? organization?['OrganizationLogoUrl'],
      ),
      status:
          _firstStringValue(json['OpportunityStatus']) ??
          _firstStringValue(json['VerificationStatus']) ??
          _firstStringValue(json['Status']),
      opportunityPhotoUrl: _nullableStringValue(json['OpportunityPhotoUrl']),
      description: _nullableStringValue(
        json['OpportunityDescription'] ?? json['Description'],
      ),
      location: _nullableStringValue(
        json['Location'] ?? firstLocation?['CityName'],
      ),
      workType: _nullableStringValue(json['WorkType']),
      timeType: _nullableStringValue(json['LocationType']),
      likesCount: _intValue(json['LikesCount']),
      commentsCount: _intValue(json['CommentsCount']),
      requiredSkills: (json['RequiredSkills'] as List?)
          ?.map((e) => SkillModel.fromJson(e))
          .toList(),

      providedSkills: (json['ProvidedSkills'] as List?)
          ?.map((e) => SkillModel.fromJson(e))
          .toList(),
      applicantsCount: _intValue(json['ApplicantsCount']),
      numberOfVolunteers: _intValue(json['NumberOfVolunteers']),
      acceptedApplicantsCount: _intValue(json['AcceptedApplicantsCount']),
      rejectedApplicantsCount: _intValue(json['RejectedApplicantsCount']),
      pendingApplicantsCount: _intValue(json['PendingApplicantsCount']),
      createdAt: _nullableStringValue(json['CreatedAt']),
    );
  }
}

class SkillModel {
  final String name;

  SkillModel({required this.name});

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(name: json['SkillName']);
  }
}
