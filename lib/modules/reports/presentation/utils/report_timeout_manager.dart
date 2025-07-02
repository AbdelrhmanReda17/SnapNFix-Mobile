import 'dart:async';
import 'package:flutter/material.dart';

class ReportTimeoutManager {
  Timer? _inactivityTimer;
  Timer? _countdownTimer;
  static const int resetTimeInMinutes = 3;
  int secondsRemaining = resetTimeInMinutes * 60;
  bool _isTimerActive = false;
  bool _hasStateChanged = false;

  final ValueNotifier<int> timeRemainingNotifier = ValueNotifier(
    resetTimeInMinutes * 60,
  );

  // Stream controller to broadcast timeout events
  final StreamController<TimeoutEvent> _timeoutController =
      StreamController<TimeoutEvent>.broadcast();
  Stream<TimeoutEvent> get timeoutStream => _timeoutController.stream;

  bool get isTimerActive => _isTimerActive;
  bool get hasStateChanged => _hasStateChanged;

  void initialize() {
    // Don't start timer automatically - wait for state changes
    _resetCountdown();
  }

  void dispose() {
    cancelInactivityTimer();
    cancelCountdownTimer();
    _timeoutController.close();
    timeRemainingNotifier.dispose();
  }

  /// Start timer when state changes from initial state
  void onStateChanged() {
    debugPrint('State changed detected...');
    _hasStateChanged = true;

    // Only start timer if it's not already active
    if (!_isTimerActive) {
      startInactivityTimer();
    }
  }

  /// Reset timer and state when timeout occurs or manual reset
  void resetToInitialState() {
    debugPrint('Resetting to initial state...');
    _hasStateChanged = false;
    _isTimerActive = false;
    cancelInactivityTimer();
    cancelCountdownTimer();
    _resetCountdown();
  }

  void startInactivityTimer() {
    if (_isTimerActive) return; // Don't start if already active

    cancelInactivityTimer(); // Cancel any existing timer first
    _isTimerActive = true;

    // Reset the countdown
    _resetCountdown();
    startCountdownTimer();

    // Start a new timer
    _inactivityTimer = Timer(Duration(minutes: resetTimeInMinutes), () {
      debugPrint('Timeout occurred - triggering form reset');
      // Notify listeners of timeout
      _timeoutController.add(TimeoutEvent.formReset);
      _isTimerActive = false;
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
        debugPrint('Countdown finished - triggering form reset');
        _timeoutController.add(TimeoutEvent.formReset);
        _isTimerActive = false;
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

  void _resetCountdown() {
    secondsRemaining = resetTimeInMinutes * 60;
    timeRemainingNotifier.value = secondsRemaining;
  }

  String formatTime() {
    final minutes = secondsRemaining ~/ 60;
    final seconds = secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // For backward compatibility - but now it doesn't reset timer
  void checkIfTimeOutOpenedIfNotCreateOne() {
    // This method now does nothing - timer is controlled by state changes
    debugPrint('Button interaction detected - timer not affected');
  }

  // For backward compatibility - but now it doesn't reset timer
  void resetTimer() {
    // This method now does nothing - timer is controlled by state changes
    debugPrint('Reset timer called - timer not affected');
  }
}

enum TimeoutEvent { formReset, warningShown }
