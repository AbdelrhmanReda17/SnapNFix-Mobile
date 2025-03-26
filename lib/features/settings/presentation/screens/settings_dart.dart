import 'package:flutter/material.dart';
import 'package:snapnfix/features/authentication/data/models/user.dart';
import 'package:snapnfix/features/settings/presentation/widgets/profile_container.dart';
import 'package:snapnfix/features/settings/presentation/widgets/settings_list_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = User(
      id: "1",
      name: "Abdelrahman Reda Mohamed",
      phoneNumber: "1234567890",
      password: "password",
      token: "token",
    );
    return Column(
      children: [
        ProfileContainer(user: user),
        Expanded(child: SettingsListView()),
      ],
    );
  }
}
