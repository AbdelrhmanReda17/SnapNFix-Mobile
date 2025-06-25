import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class AreaSearchWidget extends StatefulWidget {
  final Function(String) onSearch;
  final String? hintText;
  final bool hasError;
  final ColorScheme colorScheme;

  const AreaSearchWidget({
    super.key,
    required this.onSearch,
    required this.colorScheme,
    this.hintText,
    this.hasError = false,
  });

  @override
  State<AreaSearchWidget> createState() => _AreaSearchWidgetState();
}

class _AreaSearchWidgetState extends State<AreaSearchWidget> {
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
    );
  }
} 