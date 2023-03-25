import '../model_base.dart';

class User extends ModelBase {
  String? firstName;
  String? familyName;
  String? userFullName;
  String? email;
  String? phoneNumber;
  String? nationalIdentityNo;
  String? uid;
  bool? verified;
  bool? active;

  User();

  User.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    firstName = data['FirstName'];
    familyName = data['FamilyName'];
    userFullName = data['UserFullName'] ?? '$firstName $familyName';
    email = data['Email'];
    phoneNumber = data['PhoneNumber'];
    nationalIdentityNo = data['NationalIdentityNo'];
    uid = data['Uid'];
    verified = data['Verified'];
    active = data['Active'];
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'FirstName': firstName,
      'FamilyName': familyName,
      'UserFullName': userFullName,
      'EMail': email,
      'PhoneNumber': phoneNumber,
      'NationalIdentityNo': nationalIdentityNo,
      'Uid': uid,
      'Verified': verified,
      'Active': active,
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
