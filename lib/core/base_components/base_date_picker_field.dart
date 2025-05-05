import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseDatePickerField extends StatefulWidget {
  final String hintText;
  final String? initialValue;
  final ValueChanged<DateTime?>? onChanged;
  final String Function(DateTime date) dateFormatter;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final Widget? icon;

  const BaseDatePickerField({
    super.key,
    required this.hintText,
    this.initialValue,
    this.onChanged,
    required this.dateFormatter,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.textStyle,
    this.hintStyle,
    this.backgroundColor,
    this.icon,
  });

  @override
  State<BaseDatePickerField> createState() => _BaseDatePickerFieldState();
}

class _BaseDatePickerFieldState extends State<BaseDatePickerField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _selectedDate = DateTime.tryParse(widget.initialValue!);
    }
  }

  Future<void> _handleDatePicker() async {
    final DateTime? picked = await showCustomDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _handleDatePicker,
      child: Container(
        padding:
            widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? colorScheme.surface.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: colorScheme.primary.withOpacity(0.4),
            width: 1.3,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate != null
                  ? widget.dateFormatter(_selectedDate!)
                  : widget.hintText,
              style:
                  _selectedDate != null
                      ? widget.textStyle ?? textStyles.bodyMedium
                      : widget.hintStyle ??
                          textStyles.bodyMedium?.copyWith(
                            color: colorScheme.primary.withOpacity(0.4),
                          ),
            ),
            widget.icon ??
                Icon(
                  Icons.calendar_today,
                  size: 20.r,
                  color: colorScheme.primary,
                ),
          ],
        ),
      ),
    );
  }

  static Future<DateTime?> showCustomDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
  }) async {
    final ThemeData theme = Theme.of(context);

    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDatePickerMode: initialDatePickerMode,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      locale: locale,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      textDirection: textDirection,
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: ColorScheme.light(
              primary: theme.colorScheme.primary,
              onPrimary: theme.colorScheme.onPrimary,
              surface: theme.colorScheme.surface,
              onSurface: theme.colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
      initialEntryMode: initialEntryMode,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      fieldHintText: fieldHintText,
      fieldLabelText: fieldLabelText,
    );
  }
}
