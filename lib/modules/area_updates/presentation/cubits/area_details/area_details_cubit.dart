import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/index.dart';
import 'package:snapnfix/modules/area_updates/presentation/cubits/area_subscription_notifier.dart';

part 'area_details_state.dart';
part 'area_details_cubit.freezed.dart';

class AreaDetailsCubit extends Cubit<AreaDetailsState> {
  final GetAreaDetailsUseCase _getAreaDetailsUseCase;
  final ToggleAreaSubscriptionUseCase _toggleAreaSubscriptionUseCase;
  final AreaSubscriptionNotifier _subscriptionNotifier;
  List<AreaIssue> _allIssues = [];
  bool _hasMoreData = true;
  int _currentPage = 1;
  bool _isLoadingMore = false;

  AreaDetailsCubit({
    required GetAreaDetailsUseCase getAreaDetailsUseCase,
    required ToggleAreaSubscriptionUseCase toggleAreaSubscriptionUseCase,
    required AreaSubscriptionNotifier subscriptionNotifier,
  }) : _getAreaDetailsUseCase = getAreaDetailsUseCase,
       _toggleAreaSubscriptionUseCase = toggleAreaSubscriptionUseCase,
       _subscriptionNotifier = subscriptionNotifier,
       super(const AreaDetailsState.initial());

  Future<void> loadAreaDetails({
    required AreaInfo areaInfo,
    bool isSubscribed = false,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      if (isClosed) return;

      if (page == 1) {
        _allIssues.clear();
        _currentPage = 1;
        _hasMoreData = true;
        if (isClosed) return;
        emit(const AreaDetailsState.loading());
      } else {
        _isLoadingMore = true;
      }

      final result = await _getAreaDetailsUseCase.call(
        area: areaInfo,
        isSubscribed: isSubscribed,
        page: page,
        limit: limit,
      );

      if (isClosed) return;

      result.when(
        success: (areaDetails) {
          if (page == 1) {
            _allIssues = List.from(areaDetails.issues);
          } else {
            _allIssues.addAll(areaDetails.issues);
            _isLoadingMore = false;
          }

          _currentPage = page;
          _hasMoreData = areaDetails.hasNext;
          debugPrint(
            '📍 AreaDetailsCubit: Loaded ${_allIssues.length} issues for area ${areaInfo.name} (Page: $_currentPage, Has Next: $_hasMoreData)',
          );

          final updatedAreaDetails = AreaDetails(
            areaDetails.area,
            issues: _allIssues,
            healthMetrics: areaDetails.healthMetrics,
            isSubscribed: areaDetails.isSubscribed,
            hasNext: areaDetails.hasNext,
          );

          if (isClosed) return;
          emit(AreaDetailsState.loaded(updatedAreaDetails));
        },
        failure: (error) {
          _isLoadingMore = false;
          if (isClosed) return;
          emit(AreaDetailsState.error(error));
        },
      );
    } catch (e) {
      if (isClosed) return;
      _isLoadingMore = false;
      if (isClosed) return;
      emit(
        AreaDetailsState.error(
          ApiError(message: 'An unexpected error occurred'),
        ),
      );
    }
  }

  Future<void> refreshAreaDetails({
    required AreaInfo areaInfo,
    bool isSubscribed = false,
    int limit = 10,
  }) async {
    await loadAreaDetails(
      areaInfo: areaInfo,
      isSubscribed: isSubscribed,
      page: 1,
      limit: limit,
    );
  }

  Future<void> loadMoreIssues({
    required AreaInfo areaInfo,
    bool isSubscribed = false,
    int limit = 10,
  }) async {
    if (_isLoadingMore || !_hasMoreData) return;

    await loadAreaDetails(
      areaInfo: areaInfo,
      isSubscribed: isSubscribed,
      page: _currentPage + 1,
      limit: limit,
    );
  }

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData => _hasMoreData;

  Future<Result<bool, String>> toggleSubscription({
    required AreaInfo areaInfo,
    required bool currentSubscriptionStatus,
  }) async {
    try {
      if (isClosed) return Result.failure('Cubit is closed');

      // Show loading state
      final currentState = state;
      if (currentState is _Loaded) {
        if (isClosed) return Result.failure('Cubit is closed');
        emit(currentState.copyWith(isSubscriptionLoading: true));
      }

      final result = await _toggleAreaSubscriptionUseCase.call(
        areaInfo.id,
        currentSubscriptionStatus,
      );

      if (isClosed) return Result.failure('Cubit is closed');

      return result.when(
        success: (_) {
          // Update the subscription status locally
          if (currentState is _Loaded) {
            final updatedAreaDetails = AreaDetails(
              currentState.areaDetails.area,
              issues: currentState.areaDetails.issues,
              healthMetrics: currentState.areaDetails.healthMetrics,
              isSubscribed: !currentSubscriptionStatus,
              hasNext: currentState.areaDetails.hasNext,
            );

            if (isClosed) return Result.failure('Cubit is closed');
            emit(
              AreaDetailsState.loaded(
                updatedAreaDetails,
                isSubscriptionLoading: false,
              ),
            );

            // Notify the subscription change
            if (!currentSubscriptionStatus) {
              _subscriptionNotifier.notifySubscribed(areaInfo);
            } else {
              _subscriptionNotifier.notifyUnsubscribed(areaInfo);
            }
          }

          return Result.success(!currentSubscriptionStatus);
        },
        failure: (error) {
          // Restore the original state without loading
          if (currentState is _Loaded) {
            if (isClosed) return Result.failure('Cubit is closed');
            emit(currentState.copyWith(isSubscriptionLoading: false));
          }
          return Result.failure(error.message ?? 'Subscription failed');
        },
      );
    } catch (e) {
      // Restore the original state without loading
      final currentState = state;
      if (currentState is _Loaded) {
        if (isClosed) return Result.failure('Cubit is closed');
        emit(currentState.copyWith(isSubscriptionLoading: false));
      }
      return Result.failure('An unexpected error occurred: ${e.toString()}');
    }
  }

  void reset() {
    _allIssues.clear();
    _currentPage = 1;
    _hasMoreData = true;
    _isLoadingMore = false;
    if (isClosed) return;
    emit(const AreaDetailsState.initial());
  }
}
