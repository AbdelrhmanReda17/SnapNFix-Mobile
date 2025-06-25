import 'package:injectable/injectable.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_issue_fast_reports_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_issue_snap_reports_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/get_user_reports_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/submit_fast_report_use_case.dart';
import 'package:snapnfix/modules/reports/domain/usecases/submit_report_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/issue_fast_reports_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/issue_snap_reports_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_fast_report_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/user_reports_cubit.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/submit_report_cubit.dart';

@module
abstract class ReportsPresentationModule {
  @factoryMethod
  SubmitReportCubit provideSubmitReportCubit(
    SubmitReportUseCase submitReportUseCase,
  ) => SubmitReportCubit(submitReportUseCase);

  @factoryMethod
  SubmitFastReportCubit provideSubmitFastReportCubit(
    SubmitFastReportUseCase submitFastReportUseCase,
  ) => SubmitFastReportCubit(submitFastReportUseCase);

  @factoryMethod
  UserReportsCubit provideReportReviewCubit(
    GetUserReportsUseCase getUserReportsUseCase,
  ) => UserReportsCubit(getUserReportsUseCase);

  @factoryMethod
  IssueFastReportsCubit provideUserReportsCubit(
    GetIssueFastReportsUseCase getIssueFastReportsUseCase,
  ) => IssueFastReportsCubit(getIssueFastReportsUseCase);

  @factoryMethod
  IssueSnapReportsCubit provideIssueSnapReportsCubit(
    GetIssueSnapReportsUseCase getIssueSnapReportsUseCase,
  ) => IssueSnapReportsCubit(getIssueSnapReportsUseCase);
}
