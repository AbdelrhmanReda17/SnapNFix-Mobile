import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/image_builder.dart';
import 'package:snapnfix/modules/reports/data/models/report_model.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_card/report_date_indicator.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/report_card/report_status_indicator.dart';

class ReportImageStack extends StatelessWidget {
  final ReportModel report;
  const ReportImageStack({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Hero(
          tag: 'report_image_${report.id}',
          child: SizedBox(
            height: 80.h,
            width: double.infinity,
            child: ImageBuilder.buildImage(
              imageName: report.imagePath,
              fit: BoxFit.cover,
              colorScheme: colorScheme,
              errorBuilder:
                  (context, colorScheme) => Image.asset(
                    'assets/images/issue1.jpg',
                    height: 80.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ),
          ),
        ),
        // Status indicator
        if (report.status != null)
          Positioned(
            top: 8.h,
            left: 8.w,
            child: ReportStatusIndicator(status: report.status!),
          ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: ReportDateIndicator(
            createdAt: report.createdAt ?? DateTime.now(),
          ),
        ),
      ],
    );
  }
}
