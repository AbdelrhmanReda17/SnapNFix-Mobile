import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class SubscribedAreasSection extends StatefulWidget {
  final ColorScheme colorScheme;
  final bool hasError;
  final Function(String) onSearch;
  final String? hintText;

  const SubscribedAreasSection({
    super.key,
    required this.colorScheme,
    required this.onSearch,
    this.hasError = false,
    this.hintText,
  });

  @override
  State<SubscribedAreasSection> createState() => _SubscribedAreasSectionState();
}

class _SubscribedAreasSectionState extends State<SubscribedAreasSection> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: widget.hasError
                  ? widget.colorScheme.error
                  : widget.colorScheme.outline,
              width: 1,
            ),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Search areas...',
              hintStyle: TextStyle(
                color: widget.colorScheme.onSurfaceVariant,
                fontSize: 16.sp,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: widget.colorScheme.onSurfaceVariant,
                size: 20.sp,
              ),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: widget.colorScheme.onSurfaceVariant,
                        size: 20.sp,
                      ),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
            style: TextStyle(
              color: widget.colorScheme.onSurface,
              fontSize: 16.sp,
            ),
          ),
        ),
        if (widget.hasError) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 16.sp,
                color: widget.colorScheme.error,
              ),
              SizedBox(width: 4.w),
              Text(
                'Error loading areas',
                style: TextStyle(
                  color: widget.colorScheme.error,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
        SizedBox(height: 24.h),
      ],
    );
  }
}
