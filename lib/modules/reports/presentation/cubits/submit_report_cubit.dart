import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/usecases/submit_report_use_case.dart';
import 'package:snapnfix/modules/reports/presentation/utils/report_timeout_manager.dart';
import 'package:geolocator/geolocator.dart';

part 'submit_report_state.dart';
part 'submit_report_cubit.freezed.dart';

class SubmitReportCubit extends Cubit<SubmitReportState> {
  final SubmitReportUseCase _submitReportUseCase;
  ReportTimeoutManager? _timeoutManager;

  SubmitReportCubit(this._submitReportUseCase)
    : super(SubmitReportState.initial());

  void setTimeoutManager(ReportTimeoutManager timeoutManager) {
    _timeoutManager = timeoutManager;
  }

  void _checkAndStartTimer() {
    // Start timer if state is not initial and timer is not already active
    if (!_isInitialState() && _timeoutManager != null && !_timeoutManager!.isTimerActive) {
      _timeoutManager!.onStateChanged();
    }
  }

  bool _isInitialState() {
    return state.image == null && 
           (state.comment == null || state.comment!.isEmpty) &&
           state.severity == ReportSeverity.low &&
           state.position == null &&
           !state.isLoading &&
           state.error == null &&
           state.successMessage == null;
  }

  void setAdditionalDetails(String value) async {
    emit(state.copyWith(comment: value));
    _checkAndStartTimer();
  }

  void setTempImage() async {
    final tempDir = await getTemporaryDirectory();
    final imageNames = ['issue1.jpg', 'issue2.jpg', 'issue3.jpg' , 'issue4.jpg'];
    final random = Random();
    final selectedImage = imageNames[random.nextInt(imageNames.length)];
    final tempPath = '${tempDir.path}/$selectedImage';
    final tempFile = File(tempPath);
    final byteData = await rootBundle.load('assets/images/$selectedImage');
    await tempFile.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    debugPrint('Temp file path: ${tempFile.path}');
    emit(state.copyWith(image: tempFile));
    _checkAndStartTimer();
  }

  void setImage(File? image) {
    emit(state.copyWith(image: image));
    _checkAndStartTimer();
  }

  void removeImage() {
    emit(state.copyWith(image: null));
    _checkAndStartTimer();
  }

  void setSeverity(ReportSeverity severity) {
    emit(state.copyWith(severity: severity));
    _checkAndStartTimer();
  }

  void setPosition(Position position) {
    emit(state.copyWith(position: position));
    _checkAndStartTimer();
  }

  Future<void> submitReport(LocationService locationService) async {
    if (state.image == null) {
      if (isClosed) return;
      emit(state.copyWith(error: "error_please_provide_image"));
      return;
    }

    if (isClosed) return;
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));

    final position = await locationService.getCurrentPosition();
    if (isClosed) return;
    emit(state.copyWith(position: position));

    List<String>? address = await locationService.getAddressFromCoordinates(
      position.latitude,
      position.longitude,
    );

    try {
      final result = await _submitReportUseCase.call(
        comment: state.comment ?? '',
        latitude: position.latitude,
        longitude: position.longitude,
        severity: state.severity,
        city: address?[0] ?? '',
        road: address?[1] ?? '',
        state: address?[2] ?? '',
        country: address?[3] ?? '',
        imagePath: state.image!.path,
      );

      if (isClosed) return;
      result.when(
        success: (data) {
          if (isClosed) return;
          resetState();
          emit(state.copyWith(isLoading: false, successMessage: data));
        },
        failure: (error) {
          if (isClosed) return;
          emit(state.copyWith(isLoading: false, error: error.message));
        },
      );
      resetState();
    } catch (error) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          error: "error_submit_report_failed",
        ),
      );
    }
  }

  void resetState() {
    emit(SubmitReportState.initial());
    // Reset timeout manager when state is reset
    _timeoutManager?.resetToInitialState();
  }
}
