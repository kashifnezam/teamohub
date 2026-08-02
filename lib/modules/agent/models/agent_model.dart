import 'package:cloud_firestore/cloud_firestore.dart';
import 'agent_location_model.dart';

class AgentModel {
  final String uid;
  final String agentStatus;
  final String? rejectedReason;
  final String agentName;
  final String phone;
  final String profileImage;
  final String? verificationFileUrl;
  final String about;

  final String experience;
  final int yearsOfExperience;

  final List<String> languages;

  final List<AgentLocationModel> operatingAreas;
  final String commissionType;
  final double commissionValue;

  final String verificationStatus;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final Timestamp? rejectedAt;

  const AgentModel({
    required this.uid,
    required this.agentStatus,
    this.rejectedReason,
    required this.agentName,
    required this.phone,
    required this.profileImage,
    this.verificationFileUrl,
    required this.about,
    required this.experience,
    required this.yearsOfExperience,
    required this.languages,
    required this.operatingAreas,
    required this.commissionType,
    required this.commissionValue,
    required this.verificationStatus,
    this.createdAt,
    this.updatedAt,
    this.rejectedAt,
  });

  factory AgentModel.empty(String uid) {
    return AgentModel(
      uid: uid,
      agentStatus: '',
      rejectedReason: '',
      agentName: '',
      phone: '',
      profileImage: '',
      verificationFileUrl: '',
      about: '',
      experience: '',
      yearsOfExperience: 0,
      languages: const [],

      commissionType: 'Percentage',
      commissionValue: 0,
      verificationStatus: 'pending',
      operatingAreas: [],
      createdAt: null,
      rejectedAt: null,
      updatedAt: null,
    );
  }

  factory AgentModel.fromMap(
      Map<String, dynamic> map,
      String uid,
      ) {
    return AgentModel(
      uid: uid,
      agentStatus: map['agentStatus'] ?? '',
      rejectedReason: map['rejectedReason'] ?? '',
      agentName: map['agentName'] ?? '',
      phone: map['phone'] ?? '',
      profileImage: map['profileImage'] ?? '',
      verificationFileUrl: map['verificationFileUrl'] ?? '',
      about: map['about'] ?? '',
      experience: map['experience'] ?? '',
      yearsOfExperience: (map['yearsOfExperience'] ?? 0) is int
          ? map['yearsOfExperience']
          : int.tryParse(
        map['yearsOfExperience'].toString(),
      ) ??
          0,
      languages: List<String>.from(map['languages'] ?? const []),

      operatingAreas: (map["operatingAreas"] as List? ?? [])
          .map(
            (e) => AgentLocationModel.fromMap(
          Map<String, dynamic>.from(e),
        ),
      )
          .toList(),
      commissionType: map['commissionType'] ?? 'Percentage',
      commissionValue:
      (map['commissionValue'] ?? 0).toDouble(),
      verificationStatus:
      map['verificationStatus'] ?? 'pending',
      createdAt: map['createdAt'],
      rejectedAt: map['rejectedAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'agentStatus': agentStatus,
      'rejectedReason': rejectedReason,
      'agentName': agentName,
      'phone': phone,
      'profileImage': profileImage,
      'verificationFileUrl': verificationFileUrl,
      'about': about,
      'experience': experience,
      'yearsOfExperience': yearsOfExperience,
      'languages': languages,
      "operatingAreas": operatingAreas
          .map((e) => e.toMap())
          .toList(),
      'commissionType': commissionType,
      'commissionValue': commissionValue,
      'verificationStatus': verificationStatus,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'rejectedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  AgentModel copyWith({
    String? uid,
    bool? isAgent,
    String? agentStatus,
    String? rejectedReason,
    String? agentName,
    String? phone,
    String? profileImage,
    String? verificationFileUrl,
    String? about,
    String? experience,
    int? yearsOfExperience,
    List<String>? languages,
    List<String>? serviceStates,
    List<String>? serviceCities,
    List<AgentLocationModel>? operatingAreas,
    String? commissionType,
    double? commissionValue,
    String? verificationStatus,
    Timestamp? createdAt,
    Timestamp? rejectedAt,
    Timestamp? updatedAt,
  }) {
    return AgentModel(
      uid: uid ?? this.uid,
      agentStatus: agentStatus ?? this.agentStatus,
      rejectedReason: rejectedReason ?? this.rejectedReason,
      agentName: agentName ?? this.agentName,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      verificationFileUrl: verificationFileUrl ?? this.verificationFileUrl,
      about: about ?? this.about,
      experience: experience ?? this.experience,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      languages: languages ?? this.languages,
      operatingAreas: operatingAreas ?? this.operatingAreas,
      commissionType: commissionType ?? this.commissionType,
      commissionValue: commissionValue ?? this.commissionValue,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      createdAt: createdAt ?? this.createdAt,
      rejectedAt: rejectedAt ?? this.rejectedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}