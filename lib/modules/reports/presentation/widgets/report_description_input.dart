import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';

class ReportDescriptionInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isRequired;
  final int maxLines;

  const ReportDescriptionInput({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.validator,
    this.isRequired = false,
    this.maxLines = 5,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final displayLabel =
        labelText ??
        (isRequired
            ? 'Description'
            : localization?.additionalDetails ??
                'Additional Details (Optional)');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: displayLabel,
                style: textTheme.bodyLarge!.copyWith(
                  color: colorScheme.primary,
                  fontWeight: isRequired ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: textTheme.bodyLarge!.copyWith(
                    color: colorScheme.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        verticalSpace(8),
        BaseTextField(
          initialValue: controller?.text,
          hintText:
              hintText ??
              localization?.describeIncident ??
              'Describe the incident...',
          maxLines: maxLines,
          onChanged: (value) {
            if (controller != null) {
              controller!.text = value;
            }
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          validator: validator,
        ),
      ],
    );
  }
}
