import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';

class SubmitPhotoPicker extends StatelessWidget {
  const SubmitPhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final cubit = context.read<SubmitReportCubit>();

    Future<void> takePhoto() async {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? photo = await picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 1200,
          maxHeight: 1200,
          imageQuality: 85,
        );

        if (photo != null) {
          cubit.setImage(File(photo.path));
          debugPrint('📸 Photo taken and saved at ${photo.path}');
        }
      } catch (e) {
        debugPrint('❌ Error taking photo: $e');
      }
    }

    return GestureDetector(
      onTap: () => takePhoto(),
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
          child: BlocBuilder<SubmitReportCubit, SubmitReportState>(
            builder: (context, state) {
              final image = state.image;
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
                            onTap: () => cubit.removeImage(),
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
