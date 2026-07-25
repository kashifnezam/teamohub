import 'package:cloud_firestore/cloud_firestore.dart';

class AgentModel {
  final String uid;
  final bool isAgent;
  final String agentStatus;

  final String agentName;
  final String phone;
  final String profileImage;
  final String about;

  final String experience;
  final int yearsOfExperience;

  final List<String> languages;
  final List<String> serviceStates;
  final List<String> serviceCities;

  final String commissionType;
  final double commissionValue;

  final String verificationStatus;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const AgentModel({
    required this.uid,
    required this.isAgent,
    required this.agentStatus,
    required this.agentName,
    required this.phone,
    required this.profileImage,
    required this.about,
    required this.experience,
    required this.yearsOfExperience,
    required this.languages,
    required this.serviceStates,
    required this.serviceCities,
    required this.commissionType,
    required this.commissionValue,
    required this.verificationStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory AgentModel.empty(String uid) {
    return AgentModel(
      uid: uid,
      isAgent: false,
      agentStatus: '',
      agentName: '',
      phone: '',
      profileImage: '',
      about: '',
      experience: '',
      yearsOfExperience: 0,
      languages: const [],
      serviceStates: const [],
      serviceCities: const [],
      commissionType: 'Percentage',
      commissionValue: 0,
      verificationStatus: 'pending',
      createdAt: null,
      updatedAt: null,
    );
  }

  factory AgentModel.fromMap(
      Map<String, dynamic> map,
      String uid,
      ) {
    return AgentModel(
      uid: uid,
      isAgent: map['isAgent'] ?? false,
      agentStatus: map['agentStatus'] ?? '',
      agentName: map['agentName'] ?? '',
      phone: map['phone'] ?? '',
      profileImage: map['profileImage'] ?? '',
      about: map['about'] ?? '',
      experience: map['experience'] ?? '',
      yearsOfExperience: (map['yearsOfExperience'] ?? 0) is int
          ? map['yearsOfExperience']
          : int.tryParse(
        map['yearsOfExperience'].toString(),
      ) ??
          0,
      languages: List<String>.from(map['languages'] ?? const []),
      serviceStates:
      List<String>.from(map['serviceStates'] ?? const []),
      serviceCities:
      List<String>.from(map['serviceCities'] ?? const []),
      commissionType: map['commissionType'] ?? 'Percentage',
      commissionValue:
      (map['commissionValue'] ?? 0).toDouble(),
      verificationStatus:
      map['verificationStatus'] ?? 'pending',
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isAgent': isAgent,
      'agentStatus': agentStatus,
      'agentName': agentName,
      'phone': phone,
      'profileImage': profileImage,
      'about': about,
      'experience': experience,
      'yearsOfExperience': yearsOfExperience,
      'languages': languages,
      'serviceStates': serviceStates,
      'serviceCities': serviceCities,
      'commissionType': commissionType,
      'commissionValue': commissionValue,
      'verificationStatus': verificationStatus,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  AgentModel copyWith({
    String? uid,
    bool? isAgent,
    String? agentStatus,
    String? agentName,
    String? phone,
    String? profileImage,
    String? about,
    String? experience,
    int? yearsOfExperience,
    List<String>? languages,
    List<String>? serviceStates,
    List<String>? serviceCities,
    String? commissionType,
    double? commissionValue,
    String? verificationStatus,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return AgentModel(
      uid: uid ?? this.uid,
      isAgent: isAgent ?? this.isAgent,
      agentStatus: agentStatus ?? this.agentStatus,
      agentName: agentName ?? this.agentName,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      about: about ?? this.about,
      experience: experience ?? this.experience,
      yearsOfExperience:
      yearsOfExperience ?? this.yearsOfExperience,
      languages: languages ?? this.languages,
      serviceStates:
      serviceStates ?? this.serviceStates,
      serviceCities:
      serviceCities ?? this.serviceCities,
      commissionType:
      commissionType ?? this.commissionType,
      commissionValue:
      commissionValue ?? this.commissionValue,
      verificationStatus:
      verificationStatus ?? this.verificationStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}