import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/subscribed_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/all_areas_cubit.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/subscribed_areas_list.dart';
import 'package:snapnfix/modules/area_updates/presentation/widgets/all_areas_list.dart';
import 'package:snapnfix/presentation/navigation/routes.dart';

class AreaManagementScreen extends StatefulWidget {
  final bool initialShowSubscribed;

  const AreaManagementScreen({super.key, this.initialShowSubscribed = false});

  @override
  State<AreaManagementScreen> createState() => _AreaManagementScreenState();
}

class _AreaManagementScreenState extends State<AreaManagementScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _searchController;
  late TabController _tabController;
  bool _isSearching = false;
  late SubscribedAreasCubit _subscribedAreasCubit;
  late AllAreasCubit _allAreasCubit;

    @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialShowSubscribed ? 0 : 1,
    );
    
    _subscribedAreasCubit = getIt<SubscribedAreasCubit>();
    _allAreasCubit = getIt<AllAreasCubit>();

    debugPrint('📍 Initializing AreaManagementScreen');

    // Initialize only the active tab's cubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialShowSubscribed) {
        debugPrint('🎯 Initializing subscribed areas tab only');
        _subscribedAreasCubit.initialize();
      } else {
        debugPrint('🎯 Initializing all areas tab only');
        _allAreasCubit.initialize();
      }
    });

    // Listen to tab changes and initialize the other cubit when needed
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;
  
    final currentIndex = _tabController.index;
    if (currentIndex == 0) {
      _subscribedAreasCubit.initialize();
    } else {
      _allAreasCubit.initialize();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _subscribedAreasCubit),
        BlocProvider.value(value: _allAreasCubit),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Text('Manage Areas'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                    _onSearchChanged('');
                  }
                });
              },
            ),
            IconButton(
              onPressed: _refreshCurrentTab,
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
            ),
          ],
        ),
        body: Column(
          children: [
            if (_isSearching)
              Container(
                padding: EdgeInsets.all(16.w),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search areas...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _onSearchChanged('');
                              },
                            )
                            : null,
                    filled: true,
                    fillColor: Theme.of(
                      context,
                    ).colorScheme.surfaceVariant.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (_searchController.text == value) {
                        _onSearchChanged(value);
                      }
                    });
                  },
                ),
              ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Theme.of(context).colorScheme.primary,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(
                    icon: Icon(Icons.notifications, size: 20),
                    text: 'Subscribed',
                  ),
                  Tab(icon: Icon(Icons.explore, size: 20), text: 'All Areas'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Subscribed Areas Tab
                  SubscribedAreasList(
                    onAreaTap: (area) {
                      context.push(Routes.areaIssues, extra: area);
                    },
                    emptyMessage:
                        'No subscribed areas found\nSubscribe to areas to see them here',
                  ),
                  // All Areas Tab
                  AllAreasList(
                    onAreaTap: (area) {
                      context.push(Routes.areaIssues, extra: area);
                    },
                    emptyMessage:
                        'No areas available\nTry refreshing or check your connection',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (_tabController.index == 0) {
      // Subscribed areas tab
      _subscribedAreasCubit.searchAreas(query);
    } else {
      // All areas tab
      _allAreasCubit.searchAreas(query);
    }
  }

  void _refreshCurrentTab() {
    if (_tabController.index == 0) {
      // Subscribed areas tab
      _subscribedAreasCubit.refresh();
    } else {
      // All areas tab
      _allAreasCubit.refresh();
    }
  }
}
