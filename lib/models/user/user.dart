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
    firstName = data['firstName'];
    familyName = data['familyName'];
    userFullName = data['userFullName'] = '$firstName $familyName';
    email = data['email'];
    phoneNumber = data['phoneNumber'];
    nationalIdentityNo = data['nationalIdentityNo'];
    uid = data['uid'];
    verified = data['verified'];
    active = data['active'];
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
      'Verified': verified,
      'Active': active,
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
