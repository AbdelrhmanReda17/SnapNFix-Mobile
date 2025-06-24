import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/index.dart';

part 'area_subscription_state.freezed.dart';

@freezed
class AreaSubscriptionState with _$AreaSubscriptionState {
  const factory AreaSubscriptionState.initial() = _Initial;

  const factory AreaSubscriptionState.loading() = _Loading;

  const factory AreaSubscriptionState.loaded({
    required List<String> subscribedAreas,
    @Default(false) bool isRefreshing,
  }) = _Loaded;

  const factory AreaSubscriptionState.error({
    required ApiError error,
    required List<String> cachedAreas,
  }) = _Error;
}
