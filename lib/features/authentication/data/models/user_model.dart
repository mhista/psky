import 'dart:convert';

import 'package:ahiaa_web/features/authentication/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/utils/formatters/formatter.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    super.phoneNumber = '',
    super.profilePicture = '',
    required super.dob,
    required super.createdAt,
    super.updatedAt,
    required super.school,
    super.examBody,
    super.gender = '',
    super.bio = '',
    super.hasOnboarded = false,
    super.subjects

  });



  UserModel copyWith({
    String? id,
    String? gender,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    DateTime? dob,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? school,
    List<String>? examBody,
    String? bio,
    bool? hasOnboarded,
    List<String>? subjects
    
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      dob: dob ?? this.dob,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      school: school ?? this.school,
      examBody: examBody ?? this.examBody,
      bio: bio ?? this.bio,
      hasOnboarded: hasOnboarded ?? this.hasOnboarded,
      subjects: subjects ?? this.subjects
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'gender': gender});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'profilePicture': profilePicture});
    result.addAll({'dob': dob.millisecondsSinceEpoch});
      result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
      if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt!.millisecondsSinceEpoch});
    }
    if (subjects != null) result.addAll({'subjects': subjects});
    result.addAll({'school': school});
    if (examBody != null) result.addAll({'examBody': examBody});
    result.addAll({'bio': bio});
    result.addAll({'hasOnboarded': hasOnboarded});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      gender: map['gender'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob'] ?? 0),
      bio: map['bio'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['dob'] ?? 0),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
      school: map['school'],
      subjects: map['subjects'] != null
          ? List<String>.from(map['subjects'])
          : null,
      examBody:
          map['examBody'] != null ? List<String>.from(map['examBody']) : null,
          hasOnboarded: map['hasOnboarded'] ?? false
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
        gender: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        dob: DateTime.now(),
        school: '',
        bio: '',
        hasOnboarded: false

      );

  // factory method to create a user model from firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        lastName: data['lastName'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        gender: data['gender'] ?? '',
        email: data['email'] ?? '',
        firstName: data['firstName'] ?? '',
        dob: DateTime.fromMillisecondsSinceEpoch(data['dob'] ?? 0),
        createdAt: DateTime.fromMillisecondsSinceEpoch(data['dob'] ?? 0),
        updatedAt: data['updatedAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['updatedAt'])
            : null,
        school: data['school'],
        subjects: data['subjects'] != null
            ? List<String>.from(data['subjects'])
            : null,
        examBody: data['examBody'] != null
            ? List<String>.from(data['examBody'])
            : null,
            bio: data['bio'] ?? '',
            hasOnboarded: data['hasOnboarded'] ?? false 
      );
    } else {
      return UserModel.empty();
    }
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, bio: $bio, dob: $dob, gender: $gender,lastName: $lastName, exambody: $examBody , email: $email, phoneNumber: $phoneNumber, profilePicture: $profilePicture, createdAt: $createdAt, updatedAt: $updatedAt,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profilePicture == profilePicture &&
        other.subjects == subjects &&
        other.dob == dob &&
        other.gender == gender &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.school == school &&
        other.bio == bio &&
        other.hasOnboarded == hasOnboarded &&
        other.examBody == examBody;
        

  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        gender.hashCode ^
        profilePicture.hashCode ^
        bio.hashCode ^
        subjects.hashCode ^
        hasOnboarded.hashCode ^ 
        (dob?.hashCode ?? 0) ^
        (createdAt?.hashCode ?? 0) ^
        (updatedAt?.hashCode ?? 0) ^
        (school?.hashCode ?? 0) ^
        (examBody?.hashCode ?? 0);
  }
}
