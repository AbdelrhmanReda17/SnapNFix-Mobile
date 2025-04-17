import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snapnfix/features/authentication/data/models/user.dart';
import 'package:snapnfix/features/settings/presentation/widgets/profile_container.dart';
import 'package:snapnfix/features/settings/presentation/widgets/settings_list_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final User user = User(
      id: "1",
      name: "Abdelrahman Reda Mohamed",
      phoneNumber: "1234567890",
      password: "password",
      token: "token",
    );

    // Wrap the entire screen with AnnotatedRegion
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: colorScheme.primary, // Use your theme color
      ),
      child: Column(
        children: [
          ProfileContainer(user: user),
          Expanded(child: SettingsListView()),
        ],
      ),
    );
  }
}
