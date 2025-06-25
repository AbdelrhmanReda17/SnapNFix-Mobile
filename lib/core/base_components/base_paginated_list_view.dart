import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Generic enhanced paginated view widget that handles:
/// - Pull to refresh
/// - Infinite scroll pagination
/// - Loading states
/// - Empty states
/// - Error states
/// - Custom item builders
class EnhancedPaginatedView<T> extends StatelessWidget {
  /// List of items to display
  final List<T> items;

  /// Whether the initial loading is in progress
  final bool isLoading;

  /// Whether more items are being loaded (pagination)
  final bool isLoadingMore;

  /// Whether all items have been loaded (end of pagination)
  final bool hasReachedEnd;

  /// Error message if any
  final String? error;

  /// Builder for individual items
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Callback for pull to refresh
  final Future<void> Function() onRefresh;

  /// Callback for loading more items (pagination)
  final VoidCallback? onLoadMore;

  /// Builder for empty state
  final Widget Function(BuildContext context)? emptyStateBuilder;

  /// Builder for error state
  final Widget Function(BuildContext context, String error)? errorStateBuilder;

  /// Builder for loading state (initial load)
  final Widget Function(BuildContext context)? loadingStateBuilder;

  /// Builder for pagination loading indicator
  final Widget Function(BuildContext context)? paginationLoadingBuilder;

  /// Padding around the list
  final EdgeInsetsGeometry? padding;

  /// Distance from bottom to trigger load more
  final double loadMoreThreshold;

  /// Whether to show refresh indicator
  final bool enableRefresh;

  /// Whether to enable infinite scroll
  final bool enableInfiniteScroll;

  /// Separator between items
  final Widget? separator;

  /// Custom scroll physics
  final ScrollPhysics? physics;

  /// Custom scroll controller
  final ScrollController? controller;

  /// Additional bottom padding for last item
  final double? bottomPadding;

  const EnhancedPaginatedView({
    super.key,
    required this.items,
    required this.isLoading,
    required this.itemBuilder,
    required this.onRefresh,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.error,
    this.onLoadMore,
    this.emptyStateBuilder,
    this.errorStateBuilder,
    this.loadingStateBuilder,
    this.paginationLoadingBuilder,
    this.padding,
    this.loadMoreThreshold = 200.0,
    this.enableRefresh = true,
    this.enableInfiniteScroll = true,
    this.separator,
    this.physics,
    this.controller,
    this.bottomPadding,
  });

  @override
  Widget build(BuildContext context) {
    // Show error state
    if (error != null && items.isEmpty) {
      return _buildErrorState(context);
    }

    // Show loading state for initial load
    if (isLoading && items.isEmpty) {
      return _buildLoadingState(context);
    }

    // Show empty state
    if (items.isEmpty && !isLoading) {
      return _buildEmptyState(context);
    }

    // Show the list with items
    return _buildList(context);
  }

  Widget _buildErrorState(BuildContext context) {
    if (errorStateBuilder != null) {
      return errorStateBuilder!(context, error!);
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 16.h),
            Text(
              error!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: onRefresh,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    if (loadingStateBuilder != null) {
      return loadingStateBuilder!(context);
    }

    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState(BuildContext context) {
    if (emptyStateBuilder != null) {
      return emptyStateBuilder!(context);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.list_alt_outlined,
            size: 48.sp,
            color: Theme.of(context).colorScheme.outline,
          ),
          SizedBox(height: 16.h),
          Text(
            'No items found',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    Widget listView = NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (enableInfiniteScroll &&
            onLoadMore != null &&
            !isLoadingMore &&
            !hasReachedEnd &&
            scrollInfo.metrics.pixels > 0 &&
            scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - loadMoreThreshold) {
          onLoadMore!();
          return true;
        }
        return false;
      },
      child: ListView.separated(
        controller: controller,
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        padding: _buildPadding(),
        itemCount: _getItemCount(),
        separatorBuilder: (context, index) {
          // Don't show separator before pagination loader
          if (index == items.length - 1 && isLoadingMore) {
            return const SizedBox.shrink();
          }
          return separator ?? SizedBox(height: 8.h);
        },
        itemBuilder: (context, index) {
          // Show pagination loading indicator
          if (index == items.length) {
            return _buildPaginationLoader(context);
          }

          final item = items[index];
          return itemBuilder(context, item, index);
        },
      ),
    );

    // Wrap with RefreshIndicator if enabled
    if (enableRefresh) {
      listView = RefreshIndicator(onRefresh: onRefresh, child: listView);
    }

    return listView;
  }

  EdgeInsetsGeometry _buildPadding() {
    EdgeInsetsGeometry defaultPadding = EdgeInsets.all(16.r);

    if (padding != null) {
      defaultPadding = padding!;
    }

    // Add bottom padding if specified
    if (bottomPadding != null) {
      if (defaultPadding is EdgeInsets) {
        return defaultPadding.copyWith(
          bottom: defaultPadding.bottom + bottomPadding!,
        );
      }
    }

    return defaultPadding;
  }

  int _getItemCount() {
    return items.length + (isLoadingMore ? 1 : 0);
  }

  Widget _buildPaginationLoader(BuildContext context) {
    if (paginationLoadingBuilder != null) {
      return paginationLoadingBuilder!(context);
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

/// Extension to add common builders for specific use cases
extension EnhancedPaginatedViewBuilders on EnhancedPaginatedView {
  /// Creates a grid version of the paginated view
  static Widget grid<T>({
    Key? key,
    required List<T> items,
    required bool isLoading,
    required Widget Function(BuildContext context, T item, int index)
    itemBuilder,
    required Future<void> Function() onRefresh,
    bool isLoadingMore = false,
    bool hasReachedEnd = false,
    String? error,
    VoidCallback? onLoadMore,
    Widget Function(BuildContext context)? emptyStateBuilder,
    Widget Function(BuildContext context, String error)? errorStateBuilder,
    Widget Function(BuildContext context)? loadingStateBuilder,
    Widget Function(BuildContext context)? paginationLoadingBuilder,
    EdgeInsetsGeometry? padding,
    double loadMoreThreshold = 200.0,
    bool enableRefresh = true,
    bool enableInfiniteScroll = true,
    ScrollPhysics? physics,
    ScrollController? controller,
    required int crossAxisCount,
    double mainAxisSpacing = 8.0,
    double crossAxisSpacing = 8.0,
    double childAspectRatio = 1.0,
  }) {
    return _EnhancedPaginatedGridView<T>(
      key: key,
      items: items,
      isLoading: isLoading,
      itemBuilder: itemBuilder,
      onRefresh: onRefresh,
      isLoadingMore: isLoadingMore,
      hasReachedEnd: hasReachedEnd,
      error: error,
      onLoadMore: onLoadMore,
      emptyStateBuilder: emptyStateBuilder,
      errorStateBuilder: errorStateBuilder,
      loadingStateBuilder: loadingStateBuilder,
      paginationLoadingBuilder: paginationLoadingBuilder,
      padding: padding,
      loadMoreThreshold: loadMoreThreshold,
      enableRefresh: enableRefresh,
      enableInfiniteScroll: enableInfiniteScroll,
      physics: physics,
      controller: controller,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
    );
  }
}

/// Grid version of the enhanced paginated view
class _EnhancedPaginatedGridView<T> extends StatelessWidget {
  final List<T> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String? error;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<void> Function() onRefresh;
  final VoidCallback? onLoadMore;
  final Widget Function(BuildContext context)? emptyStateBuilder;
  final Widget Function(BuildContext context, String error)? errorStateBuilder;
  final Widget Function(BuildContext context)? loadingStateBuilder;
  final Widget Function(BuildContext context)? paginationLoadingBuilder;
  final EdgeInsetsGeometry? padding;
  final double loadMoreThreshold;
  final bool enableRefresh;
  final bool enableInfiniteScroll;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  const _EnhancedPaginatedGridView({
    super.key,
    required this.items,
    required this.isLoading,
    required this.itemBuilder,
    required this.onRefresh,
    required this.crossAxisCount,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.error,
    this.onLoadMore,
    this.emptyStateBuilder,
    this.errorStateBuilder,
    this.loadingStateBuilder,
    this.paginationLoadingBuilder,
    this.padding,
    this.loadMoreThreshold = 200.0,
    this.enableRefresh = true,
    this.enableInfiniteScroll = true,
    this.physics,
    this.controller,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    // Show error state
    if (error != null && items.isEmpty) {
      return _buildErrorState(context);
    }

    // Show loading state for initial load
    if (isLoading && items.isEmpty) {
      return _buildLoadingState(context);
    }

    // Show empty state
    if (items.isEmpty && !isLoading) {
      return _buildEmptyState(context);
    }

    // Show the grid with items
    return _buildGrid(context);
  }

  Widget _buildErrorState(BuildContext context) {
    if (errorStateBuilder != null) {
      return errorStateBuilder!(context, error!);
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 16.h),
            Text(
              error!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: onRefresh,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    if (loadingStateBuilder != null) {
      return loadingStateBuilder!(context);
    }

    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildEmptyState(BuildContext context) {
    if (emptyStateBuilder != null) {
      return emptyStateBuilder!(context);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.grid_view_outlined,
            size: 48.sp,
            color: Theme.of(context).colorScheme.outline,
          ),
          SizedBox(height: 16.h),
          Text(
            'No items found',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    Widget gridView = NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (enableInfiniteScroll &&
            onLoadMore != null &&
            !isLoadingMore &&
            !hasReachedEnd &&
            scrollInfo.metrics.pixels > 0 &&
            scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - loadMoreThreshold) {
          onLoadMore!();
          return true;
        }
        return false;
      },
      child: GridView.builder(
        controller: controller,
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        padding: padding ?? EdgeInsets.all(16.r),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: items.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          // Show pagination loading indicator
          if (index == items.length) {
            return _buildPaginationLoader(context);
          }

          final item = items[index];
          return itemBuilder(context, item, index);
        },
      ),
    );

    // Wrap with RefreshIndicator if enabled
    if (enableRefresh) {
      gridView = RefreshIndicator(onRefresh: onRefresh, child: gridView);
    }

    return gridView;
  }

  Widget _buildPaginationLoader(BuildContext context) {
    if (paginationLoadingBuilder != null) {
      return paginationLoadingBuilder!(context);
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
