import '../user/user.dart';
import '../model_base.dart';

class Customer extends ModelBase {
  User? user;
  Customer();
  Customer.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    user = User.fromMap(data['User']);
  }
  @override
  Map<String, dynamic> toMap() {
    return {
      'User': user?.toMap(),
    }
      ..addAll(super.toMap())
      ..removeWhere((key, value) => value == null);
  }
}
