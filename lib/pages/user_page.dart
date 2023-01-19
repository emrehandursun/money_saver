import 'package:flutter/material.dart';
import 'package:money_saver/models/customer/customer.dart';
import 'package:provider/provider.dart';

import '../provider/customer/customer_provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.primaryContainer,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: themeData.iconTheme.color,
            size: themeData.iconTheme.size,
          ),
        ),
        centerTitle: true,
        title: Text(
          'User',
          style: themeData.appBarTheme.titleTextStyle,
        ),
      ),
      body: FutureBuilder<Customer?>(
        future: context.read<CustomerProvider>().getCurrent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final customer = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(customer!.user!.userFullName!),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
