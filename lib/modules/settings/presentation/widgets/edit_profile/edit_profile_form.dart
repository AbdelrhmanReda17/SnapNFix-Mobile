import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:snapnfix/core/base_components/base_date_picker_field.dart';
import 'package:snapnfix/core/base_components/base_dropdown_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final cubit = context.read<EditProfileCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return ValueListenableBuilder<int>(
      valueListenable: cubit.resetCounter,
      builder: (context, resetCount, _) {
        return Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(8),
              BaseTextField(
                key: ValueKey('firstName_$resetCount'),
                labelText: localization.firstName,
                hintText: localization.enterFirstName,
                onChanged: cubit.setFirstName,
                initialValue: cubit.firstName,
              ),
              verticalSpace(20),

              BaseTextField(
                key: ValueKey('lastName_$resetCount'),
                labelText: localization.lastName,
                hintText: localization.enterLastName,
                onChanged: cubit.setLastName,
                initialValue: cubit.lastName,
              ),
              verticalSpace(20),

              if (cubit.isEmailRegistered)
                BaseTextField(
                  key: ValueKey('email_$resetCount'),
                  labelText: localization.email,
                  initialValue: cubit.email,
                  inputTextStyle: textStyles.bodyMedium?.copyWith(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                    fontSize: 16.sp,
                  ),
                  enabled: false,
                  readOnly: true,
                )
              else
                BaseTextField(
                  key: ValueKey('phone_$resetCount'),
                  labelText: localization.phoneNumber,
                  hintText: localization.enterPhoneNumber,
                  initialValue: cubit.phoneNumber,
                  inputTextStyle: textStyles.bodyMedium?.copyWith(
                    color: colorScheme.tertiary.withValues(alpha: 0.3),
                    fontSize: 16.sp,
                  ),
                  enabled: false,
                  readOnly: true,
                ),

              verticalSpace(20),
              BaseDropdownField<UserGender>(
                key: ValueKey('gender_$resetCount'),
                hintText: localization.selectGender,
                labelText: localization.gender,
                items: UserGender.values,
                onChanged: cubit.setSelectedGender,
                itemLabelBuilder:
                    (UserGender item) => item.getLocalizedDisplayName(context),
              ),
              verticalSpace(16),
              BaseDatePickerField(
                key: ValueKey('date_of_birth_$resetCount'),
                hintText: localization.selectDateOfBirth,
                labelText: localization.dateOfBirth,
                onChanged: cubit.setDateOfBirth,
                initialValue:
                    cubit.selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(cubit.selectedDate!)
                        : null,
                dateFormatter: cubit.formatDate,
              ),
            ],
          ),
        );
      },
    );
  }
}
