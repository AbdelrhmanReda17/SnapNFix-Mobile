import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../logic/cubit/add_report_cubit.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<AddReportCubit>();

    return GestureDetector(
      onTap: () => cubit.takePhoto(),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        strokeWidth: 2,
        color: colorScheme.primary.withValues(alpha: 0.5),
        dashPattern: const [6, 4],
        child: Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ValueListenableBuilder<File?>(
            valueListenable: cubit.imageNotifier,

            builder: (context, image, child) {
              return image == null
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 42.sp,
                          color: colorScheme.primary,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          localization?.takeAPhoto ?? 'Take a photo',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(image, fit: BoxFit.cover),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            // onTap: () => cubit.removeImage(),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: colorScheme.error,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
