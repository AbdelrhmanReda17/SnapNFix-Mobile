import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:snapnfix/modules/issues/domain/entities/issue_severity.dart';

class IssueSeverityIconsIndicator extends StatelessWidget {
  final IssueSeverity severity;
  final double iconSize;
  final bool showLabel;
  final double spacing;

  const IssueSeverityIconsIndicator({
    super.key,
    required this.severity,
    this.iconSize = 18,
    this.showLabel = false,
    this.spacing = 4,
  });
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSirenIcons(),
        if (showLabel) ...[
          horizontalSpace(spacing),
          Text(
            severity.getLocalizedName(localization),
            style: TextStyle(
              color: _getSeverityColor(),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSirenIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSirenIcon(1),
        horizontalSpace(2),
        _buildSirenIcon(2),
        horizontalSpace(2),
        _buildSirenIcon(3),
      ],
    );
  }

  Widget _buildSirenIcon(int position) {
    final bool isActive = _isIconActive(position);
    return SvgPicture.asset(
      'assets/icons/siren-icon.svg',
      height: iconSize.r,
      width: iconSize.r,
      colorFilter: ColorFilter.mode(
        isActive ? _getSeverityColor() : Colors.grey.shade300,
        BlendMode.srcIn,
      ),
    );
  }

  bool _isIconActive(int position) {
    switch (severity) {
      case IssueSeverity.low:
        return position == 1;
      case IssueSeverity.medium:
        return position <= 2;
      case IssueSeverity.high:
        return true;
      default:
        return false;
    }
  }

  Color _getSeverityColor() {
    switch (severity) {
      case IssueSeverity.low:
        return IssueSeverity.low.color;
      case IssueSeverity.medium:
        return IssueSeverity.medium.color;
      case IssueSeverity.high:
        return IssueSeverity.high.color;
      case IssueSeverity.notSpecified:
        return IssueSeverity.notSpecified.color;
    }
  }
}
