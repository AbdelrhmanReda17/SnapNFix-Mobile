import 'dart:async';
import 'package:flutter/material.dart';

class ReportTimeoutManager {
  Timer? _inactivityTimer;
  Timer? _countdownTimer;
  static const int resetTimeInMinutes = 3;
  int secondsRemaining = resetTimeInMinutes * 60;
  final ValueNotifier<int> timeRemainingNotifier = ValueNotifier(
    resetTimeInMinutes * 60,
  );

  // Stream controller to broadcast timeout events
  final StreamController<TimeoutEvent> _timeoutController =
      StreamController<TimeoutEvent>.broadcast();
  Stream<TimeoutEvent> get timeoutStream => _timeoutController.stream;

  void initialize() {
    startInactivityTimer();
    startCountdownTimer();
  }

  void dispose() {
    cancelInactivityTimer();
    cancelCountdownTimer();
    _timeoutController.close();
    timeRemainingNotifier.dispose();
  }

  void startInactivityTimer({BuildContext? context}) {
    cancelInactivityTimer(); // Cancel any existing timer first

    // Reset the countdown
    secondsRemaining = resetTimeInMinutes * 60;
    timeRemainingNotifier.value = secondsRemaining;

    // Start a new timer
    _inactivityTimer = Timer(Duration(minutes: resetTimeInMinutes), () {
      // Notify listeners of timeout
      _timeoutController.add(TimeoutEvent.formReset);
    });
  }

  void startCountdownTimer() {
    cancelCountdownTimer();

    // Update countdown every second
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
        timeRemainingNotifier.value = secondsRemaining;

        // Add warning event when 30 seconds remaining
        if (secondsRemaining == 30) {
          _timeoutController.add(TimeoutEvent.warningShown);
        }
      } else {
        // When countdown reaches zero, trigger the form reset event
        _timeoutController.add(TimeoutEvent.formReset);
        cancelCountdownTimer();
      }
    });
  }

  void cancelInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  void cancelCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  void resetTimer() {
    startInactivityTimer();
  }

  String formatTime() {
    final minutes = secondsRemaining ~/ 60;
    final seconds = secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

enum TimeoutEvent { formReset, warningShown }
