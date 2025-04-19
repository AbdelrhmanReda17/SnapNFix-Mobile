import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseDropdownField<T> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final T? value;
  final void Function(T? value) onChanged;
  final String Function(T item) itemLabelBuilder;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final Widget? icon;

  const BaseDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    this.value,
    required this.onChanged,
    required this.itemLabelBuilder,
    this.focusedBorder,
    this.enabledBorder,
    this.textStyle,
    this.hintStyle,
    this.backgroundColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color:
                backgroundColor ?? colorScheme.surface.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.3),
              width: 1.3,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<T>(
                value: value,
                items:
                    items.map<DropdownMenuItem<T>>((T item) {
                      return DropdownMenuItem<T>(
                        value: item,
                        child: Text(
                          itemLabelBuilder(item),
                          style:
                              textStyle ??
                              textStyles.bodyMedium?.copyWith(
                                color: colorScheme.primary,
                              ),
                        ),
                      );
                    }).toList(),
                onChanged: onChanged,
                hint: Text(
                  hintText,
                  style:
                      hintStyle ??
                      textStyles.bodyMedium?.copyWith(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                      ),
                ),
                isExpanded: true,
                icon:
                    icon ??
                    Icon(Icons.arrow_drop_down, color: colorScheme.primary),
                iconSize: 24.h,
                dropdownColor: colorScheme.surface,
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
