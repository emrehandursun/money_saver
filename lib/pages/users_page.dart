import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money_saver/models/user/user.dart' as model;

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  bool isSearchMode = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getAllUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<model.User> userList = [];
                if (isSearchMode) {
                  userList = [];
                } else {
                  userList = snapshot.data;
                }
                return ListView.builder(
                  itemCount: userList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final user = userList[index];
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8),
                      color: themeData.colorScheme.onPrimaryContainer,
                      child: Text(user.firstName ?? 'null'),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: themeData.colorScheme.primary,
                  ),
                );
              } else {
                return const Center(
                  child: Text('Error'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<List<model.User>?> getAllUsers() async {
  List<model.User> userList = [];
  await FirebaseFirestore.instance.collection('users').get().then(
    (allUsers) {
      for (final user in allUsers.docs) {
        userList.add(model.User.fromMap(user.data()));
      }
    },
  );
  if (userList.isNotEmpty) {
    return userList;
  } else {
    return null;
  }
}

Future<List<model.User>?> getUser(String query) async {
  List<model.User> userList = [];
  await FirebaseFirestore.instance.collection('users').where('firstName', isEqualTo: query).get().then(
    (allUsers) {
      for (final user in allUsers.docs) {
        userList.add(model.User.fromMap(user.data()));
      }
    },
  );
  if (userList.isNotEmpty) {
    return userList;
  } else {
    return null;
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return FutureBuilder(
      future: getUser(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final List<model.User> userList = snapshot.data;
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              var user = userList[index];
              return Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  user.firstName ?? 'null',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: themeData.colorScheme.primary),
          );
        } else {
          return const Center(
            child: Text('No Data'),
          );
        }
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return FutureBuilder(
      future: getUser(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final List<model.User> userList = snapshot.data;
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              var user = userList[index];
              return Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  user.firstName ?? 'null',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: themeData.colorScheme.primary),
          );
        } else {
          return const Center(
            child: Text('No Data'),
          );
        }
      },
    );
  }
}
