import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ahiaa_web/utils/constants/enums.dart';

import '../../../utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  DateTime? createdAt;
  DateTime? updatedAt;
  String role;
  // List addresses;
  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.createdAt,
    this.updatedAt,
    this.role = 'user',
  });

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? role,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'profilePicture': profilePicture});
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt!.millisecondsSinceEpoch});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt!.millisecondsSinceEpoch});
    }
    result.addAll({'role': role});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : DateTime.now(),
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
        createdAt: null,
        updatedAt: null,
        role: '',
        // addresses: [],
      );

// factory methof to create a user model from firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        createdAt: data['createdAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['createdAt'])
            : DateTime.now(),
        updatedAt: data['updatedAt'] != null
            ? DateTime.fromMillisecondsSinceEpoch(data['updatedAt'])
            : DateTime.now(),
        role: data['role'] ?? '',
        // addresses: data['addresses']?? [],
        // addresses: data['addresses'] ?? '',
        // addresses: data['addresses'] ?? [],
        // addresses: data['addresses'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

  /// HELPER FUNCTIONS

  ///  gets the fullname
  String get fullName => '$firstName $lastName';

  // function to format the phone number
  String get formattedPhoneNumber => PFormatter.formatPhoneNumber(phoneNumber);

  //  formatted date
  String get formattedDate => PFormatter.formatDate(createdAt);

  // splitting fullname into firstname and lastname
  static List<String> splitFullName(fullName) => fullName.split(' ');

  // generating a username from the fullname
  static String generateUsername(fullName) {
    List<String> splitName = fullName.split(' ');
    String firstName = splitName[0].toLowerCase();
    String lastName = splitName.length > 1 ? splitName[1].toLowerCase() : '';

    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = 'pik_$camelCaseUsername';
    return usernameWithPrefix;
  }

  //

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, phoneNumber: $phoneNumber, profilePicture: $profilePicture, createdAt: $createdAt, updatedAt: $updatedAt, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profilePicture == profilePicture &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        profilePicture.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        role.hashCode;
  }
}
