import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/authentication/domain/usecases/logout_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/cubits/user_reports_cubit.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/dark_mode_tile.dart';
import 'package:snapnfix/modules/settings/presentation/widgets/language_tile.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class SettingsListView extends StatefulWidget {
  const SettingsListView({super.key});

  @override
  State<SettingsListView> createState() => _SettingsListViewState();
}

class _SettingsListViewState extends State<SettingsListView> {
  late final LogoutUseCase _logoutUseCase;
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _logoutUseCase = getIt<LogoutUseCase>();
  }

  Future<void> _handleLogout() async {
    if (_isLoggingOut) return;

    setState(() {
      _isLoggingOut = true;
    });

    try {
      final result = await _logoutUseCase.call();
      result.when(
        success: (_) {
          if (mounted) {
            getIt<UserReportsCubit>().clear();
            context.go(Routes.login);
          }
        },
        failure: (error) {
          if (mounted) {
            setState(() {
              _isLoggingOut = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Logout failed. Please try again."),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Logout failed. Please try again."),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final localization = AppLocalizations.of(context)!;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      margin: const EdgeInsets.all(0),
      color: colorScheme.surface.withValues(alpha: 0.8),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSettingsTile(
                localization.notificationSettings,
                () {},
                colorScheme,
                textStyles,
              ),
              _buildSettingsTile(
                localization.support,
                () {
                  context.push(Routes.support);
                },
                colorScheme,
                textStyles,
              ),
            ],
          ),
          verticalSpace(7),
          DarkModeTile(),
          LanguageTile(),
          verticalSpace(7),
          _buildSettingsTile(
            localization.termsAndConditions,
            () {
              context.push(Routes.termsAndConditions);
            },
            colorScheme,
            textStyles,
          ),
          _buildSettingsTile(
            localization.privacyPolicy,
            () {
              context.push(Routes.privacyPolicy);
            },
            colorScheme,
            textStyles,
          ),
          _buildSettingsTile(
            localization.about,
            () {
              context.push(Routes.about);
            },
            colorScheme,
            textStyles,
          ),
          verticalSpace(7),
          _buildSettingsTile(
            localization.signOut,
            _handleLogout,
            colorScheme,
            textStyles,
            hasIcon: false,
            isSignOut: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    VoidCallback onTap,
    ColorScheme colorScheme,
    TextTheme textStyles, {
    bool hasIcon = true,
    bool isSignOut = false,
  }) {
    final WidgetStatesController statesController = WidgetStatesController();

    return InkWell(
      onTap: isSignOut && _isLoggingOut ? null : onTap,
      statesController: statesController,
      highlightColor: colorScheme.primary.withValues(alpha: 0.3),
      splashColor: colorScheme.primary.withValues(alpha: 0.3),
      child: Container(
        color: colorScheme.surface.withValues(alpha: 0.8),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textStyles.bodyMedium?.copyWith(
                color:
                    isSignOut
                        ? colorScheme.error
                        : (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : colorScheme.primary),
              ),
            ),
            if (isSignOut && _isLoggingOut)
              SizedBox(
                width: 16.w,
                height: 16.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.error,
                ),
              )
            else if (hasIcon)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : colorScheme.primary,
                size: 16.sp,
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
