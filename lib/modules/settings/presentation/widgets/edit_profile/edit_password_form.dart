import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_date_picker_field.dart';
import 'package:snapnfix/core/base_components/base_dropdown_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/modules/authentication/domain/entities/user_gender.dart';
import 'package:snapnfix/modules/settings/presentation/cubits/edit_profile_cubit.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final cubit = context.read<EditProfileCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          BaseTextField(hintText: localization.name, onChanged: cubit.setName),
          SizedBox(height: 20.h),
          BaseTextField(
            hintText: localization.phone,
            onChanged: cubit.setPhoneNumber,
          ),
          SizedBox(height: 20.h),
          BaseDropdownField<UserGender>(
            hintText: localization.gender,
            items: UserGender.values,
            initialValue: cubit.selectedGender,
            onChanged: cubit.setSelectedGender,
            itemLabelBuilder: (UserGender item) => item.name,
          ),
          SizedBox(height: 16.h),
          BaseDatePickerField(
            hintText: localization.dateOfBirth,
            onChanged: cubit.setDateOfBirth,
            dateFormatter: cubit.formatDate,
          ),
        ],
      ),
    );
  }
}
