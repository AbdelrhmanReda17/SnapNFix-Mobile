import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseDropdownField<T> extends StatefulWidget {
  final String hintText;
  final List<T> items;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
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
    this.initialValue,
    this.onChanged,
    required this.itemLabelBuilder,
    this.focusedBorder,
    this.enabledBorder,
    this.textStyle,
    this.hintStyle,
    this.backgroundColor,
    this.icon,
  });

  @override
  State<BaseDropdownField<T>> createState() => _BaseDropdownFieldState<T>();
}

class _BaseDropdownFieldState<T> extends State<BaseDropdownField<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  void _handleValueChanged(T? value) {
    setState(() => _selectedValue = value);
    widget.onChanged?.call(value);
  }

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
                widget.backgroundColor ?? colorScheme.surface.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: colorScheme.primary.withOpacity(0.3),
              width: 1.3,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<T>(
                value: _selectedValue,
                items:
                    widget.items.map<DropdownMenuItem<T>>((T item) {
                      return DropdownMenuItem<T>(
                        value: item,
                        child: Text(
                          widget.itemLabelBuilder(item),
                          style:
                              widget.textStyle ??
                              textStyles.bodyMedium?.copyWith(
                                color: colorScheme.primary,
                              ),
                        ),
                      );
                    }).toList(),
                onChanged: _handleValueChanged,
                hint: Text(
                  widget.hintText,
                  style:
                      widget.hintStyle ??
                      textStyles.bodyMedium?.copyWith(
                        color: colorScheme.primary.withOpacity(0.3),
                      ),
                ),
                isExpanded: true,
                icon:
                    widget.icon ??
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
