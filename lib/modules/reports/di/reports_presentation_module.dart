import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_user_reports_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/submit_report_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/report_review_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';

@module
abstract class ReportsPresentationModule {
  @factoryMethod
  SubmitReportCubit provideSubmitReportCubit(
    SubmitReportUseCase submitReportUseCase,
  ) => SubmitReportCubit(submitReportUseCase);

  @factoryMethod
  ReportReviewCubit provideReportReviewCubit(
    GetUserReportsUseCase getUserReportsUseCase,
  ) => ReportReviewCubit(getUserReportsUseCase);
}
