import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: colorScheme.primary, strokeWidth: 2),
          verticalSpace(16),
          Text(
            AppLocalizations.of(context)!.loading,
            style: textTheme.bodyLarge!.copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
