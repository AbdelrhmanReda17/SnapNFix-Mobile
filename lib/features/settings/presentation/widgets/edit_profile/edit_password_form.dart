import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/base_components/base_date_picker_field.dart';
import 'package:snapnfix/core/base_components/base_dropdrown_field.dart';
import 'package:snapnfix/core/base_components/base_text_field.dart';
import 'package:snapnfix/features/settings/logic/cubit/edit_profile_cubit.dart';

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
          BaseTextField(
            hintText: localization.name,
            controller: cubit.nameController,
          ),
          SizedBox(height: 20.h),
          BaseTextField(
            hintText: localization.phone,
            controller: cubit.phoneController,
          ),
          SizedBox(height: 20.h),
          ValueListenableBuilder<String?>(
            valueListenable: cubit.selectedGender,
            builder: (context, selectedGender, _) {
              return BaseDropdownField<String>(
                hintText: localization.gender,
                items: cubit.genderOptions,
                value: selectedGender,
                onChanged: (value) {
                  if (value != null) {
                    cubit.updateGender(value);
                  }
                },
                itemLabelBuilder: (item) => item,
              );
            },
          ),
          SizedBox(height: 16.h),
          ValueListenableBuilder<DateTime?>(
            valueListenable: cubit.selectedDate,
            builder: (context, selectedDate, _) {
              return BaseDatePickerField(
                hintText: localization.dateOfBirth,
                value: selectedDate,
                onTap: () async {
                  final pickedDate =
                      await BaseDatePickerField.showCustomDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );

                  if (pickedDate != null) {
                    cubit.updateDate(pickedDate);
                  }
                },
                dateFormatter: cubit.formatDate,
              );
            },
          ),
        ],
      ),
    );
  }
}
