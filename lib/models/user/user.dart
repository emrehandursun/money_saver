import '../model_base.dart';

class User extends ModelBase {
  String? firstName;
  String? familyName;
  String? userFullName;
  String? eMail;
  String? phoneNumber;
  String? nationalIdentityNo;
  bool? verified;
  bool? active;

  User();

  User.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    firstName = data['FirstName'];
    familyName = data['FamilyName'];
    userFullName = data['UserFullName'];
    eMail = data['EMail'];
    phoneNumber = data['PhoneNumber'];
    nationalIdentityNo = data['NationalIdentityNo'];
    verified = data['Verified'];
    active = data['Active'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'FirstName': firstName,
      'FamilyName': familyName,
      'UserFullName': userFullName,
      'EMail': eMail,
      'PhoneNumber': phoneNumber,
      'NationalIdentityNo': nationalIdentityNo,
      'Verified': verified,
      'Active': active,
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
