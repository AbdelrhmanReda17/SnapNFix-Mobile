import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:snapnfix/modules/area_updates/domain/entities/area_info.dart';

class AreaSubscriptionNotifier {
  static final AreaSubscriptionNotifier _instance = AreaSubscriptionNotifier._internal();
  factory AreaSubscriptionNotifier() => _instance;
  AreaSubscriptionNotifier._internal();

  final StreamController<AreaSubscriptionEvent> _controller = StreamController.broadcast();

  Stream<AreaSubscriptionEvent> get stream => _controller.stream;

  void notifySubscribed(AreaInfo areaInfo) {
    _controller.add(AreaSubscriptionEvent(areaInfo: areaInfo, isSubscribed: true));
    debugPrint('📢 Notified: Area ${areaInfo.id} (${areaInfo.name}) subscribed');
  }

  void notifyUnsubscribed(AreaInfo areaInfo) {
    _controller.add(AreaSubscriptionEvent(areaInfo: areaInfo, isSubscribed: false));
    debugPrint('📢 Notified: Area ${areaInfo.id} (${areaInfo.name}) unsubscribed');
  }

  void dispose() {
    _controller.close();
  }
}

class AreaSubscriptionEvent {
  final AreaInfo areaInfo;
  final bool isSubscribed;

  AreaSubscriptionEvent({
    required this.areaInfo,
    required this.isSubscribed,
  });
} 