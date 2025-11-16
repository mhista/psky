import 'package:ahiaa_web/core/utils/enums/exam_enums.dart';
import 'package:ahiaa_web/core/utils/formatters/formatter.dart';

class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profilePicture;
  final String school;
  final DateTime dob;
  final DateTime createdAt;
  final DateTime? updatedAt;  
  final List<String>? examBody;

  // List addresses;
  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.school,
    required this.dob,
    required this.createdAt,
    required this.updatedAt,
    required this.examBody,
  });

   static UserEntity empty() => UserEntity(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        dob: DateTime.now(),
        school: '',
        examBody: []
      );

      /// HELPER FUNCTIONS

  /// gets the fullname
  String get fullName => '$firstName $lastName';

  // function to format the phone number
  String get formattedPhoneNumber => PFormatter.formatPhoneNumber(phoneNumber);

  // formatted date
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
}
