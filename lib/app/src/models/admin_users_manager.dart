import 'package:agencia_scholz/app/src/data/user_data.dart';
import 'package:agencia_scholz/app/src/models/user_manager_model.dart';
import 'package:faker/faker.dart';
import 'package:flutter/widgets.dart';

class AdminUsersManager extends ChangeNotifier {
  List<User> users = [];

  void updateUser(UserManager userManager) {
    if (userManager.adminEnabled) {
      _listenToUsers();
    }
  }

  void _listenToUsers() {
    const faker = Faker();
    for (int i = 0; i < 1000; i++) {
      users.add(User(
        name: faker.person.name(),
        email: faker.internet.email(),
      ));
    }
    notifyListeners();
  }

  List<String> get names => users.map((e) => e.name).toList();
}
