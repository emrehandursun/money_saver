import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:money_saver/models/customer/customer.dart';
import 'package:money_saver/models/user/user.dart' as models;

class CustomerProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Customer? currentCustomer;
  Future<Customer?> getCurrent() async {
    models.User? user;
    if (FirebaseAuth.instance.currentUser != null) {
      user = await FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((value) => models.User.fromMap(value.docs.first.data()));
    }
    if (user != null) {
      final Customer customer = Customer();
      customer.user = user;
      currentCustomer = customer;
      return customer;
    }
    notifyListeners();
    return null;
  }
}
