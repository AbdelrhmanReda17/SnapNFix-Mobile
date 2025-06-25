import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/paginated_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/paginated_areas_list.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class AreaManagementScreen extends StatefulWidget {
  const AreaManagementScreen({super.key});

  @override
  State<AreaManagementScreen> createState() => _AreaManagementScreenState();
}

class _AreaManagementScreenState extends State<AreaManagementScreen> {
  late TextEditingController _searchController;
  bool _isSearching = false;
  bool _showSubscribedOnly = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<PaginatedAreasCubit>()
                ..initialize(subscribed: _showSubscribedOnly),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Areas'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                    context.read<PaginatedAreasCubit>().searchAreas('');
                  }
                });
              },
            ),
            BlocBuilder<PaginatedAreasCubit, PaginatedAreasState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<PaginatedAreasCubit>().refresh();
                  },
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh',
                );
              },
            ),
          ],
          bottom:
              _isSearching
                  ? PreferredSize(
                    preferredSize: Size.fromHeight(60.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search areas by name or state...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon:
                              _searchController.text.isNotEmpty
                                  ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      _searchController.clear();
                                      context
                                          .read<PaginatedAreasCubit>()
                                          .searchAreas('');
                                    },
                                  )
                                  : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                          // Debounce search
                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (_searchController.text == value) {
                              context.read<PaginatedAreasCubit>().searchAreas(
                                value,
                              );
                            }
                          });
                        },
                      ),
                    ),
                  )
                  : null,
        ),
        body: Column(
          children: [
            // Mode toggle
            Container(
              margin: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child:
                        BlocBuilder<PaginatedAreasCubit, PaginatedAreasState>(
                          builder: (context, state) {
                            return SegmentedButton<bool>(
                              segments: [
                                ButtonSegment<bool>(
                                  value: false,
                                  label: Text('All Areas'),
                                  icon: Icon(Icons.location_city),
                                ),
                                ButtonSegment<bool>(
                                  value: true,
                                  label: Text('Subscribed'),
                                  icon: Icon(Icons.notifications),
                                ),
                              ],
                              selected: {_showSubscribedOnly},
                              onSelectionChanged: (Set<bool> selection) {
                                final isSubscribed = selection.first;
                                setState(() {
                                  _showSubscribedOnly = isSubscribed;
                                });
                                context.read<PaginatedAreasCubit>().toggleMode(
                                  subscribed: isSubscribed,
                                );
                              },
                            );
                          },
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PaginatedAreasList(
                showSubscriptionButtons: true,
                onAreaTap: (area) {
                  context.push(
                    Routes.areaIssues,
                    extra: area,
                  );
                },
                emptyMessage:
                    _showSubscribedOnly
                        ? 'No subscribed areas found\nSubscribe to areas to see them here'
                        : 'No areas available',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
