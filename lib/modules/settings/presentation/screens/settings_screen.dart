import 'package:flutter/material.dart';
import 'package:snapnfix/core/config/application_configurations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/profile_container.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/settings_list_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Use AnimatedBuilder to listen to ApplicationConfigurations changes
    return AnimatedBuilder(
      animation: getIt<ApplicationConfigurations>(),
      builder: (context, _) {
        final session = getIt<ApplicationConfigurations>().currentSession;
        if (session == null) {
          return Center(
            child: Text(AppLocalizations.of(context)!.loginToViewSettings),
          );
        }
        return Column(
          children: [
            ProfileContainer(user: session.user),
            const Expanded(child: SettingsListView()),
          ],
        );
      },
    );
  }
}
