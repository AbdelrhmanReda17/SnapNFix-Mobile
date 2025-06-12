import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/usecases/submit_report_use_case.dart';
import 'package:geolocator/geolocator.dart';

part 'submit_report_state.dart';
part 'submit_report_cubit.freezed.dart';

class SubmitReportCubit extends Cubit<SubmitReportState> {
  final SubmitReportUseCase _submitReportUseCase;

  SubmitReportCubit(this._submitReportUseCase)
    : super(SubmitReportState.initial());

  void setAdditionalDetails(String value) async {
    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/mock_issue.jpg';
    final tempFile = File(tempPath);
    final byteData = await rootBundle.load('assets/images/issue1.jpg');
    await tempFile.writeAsBytes(
      byteData.buffer.asUint8List(
        byteData.offsetInBytes,
        byteData.lengthInBytes,
      ),
    );
    debugPrint('Temp file path: ${tempFile.path}');
    debugPrint(value);
    emit(state.copyWith(details: value, image: tempFile));
  }

  void setImage(File? image) {
    emit(state.copyWith(image: image));
  }

  void removeImage() {
    emit(state.copyWith(image: null));
  }

  void setSeverity(ReportSeverity severity) {
    emit(state.copyWith(severity: severity));
  }

  void setPosition(Position position) {
    emit(state.copyWith(position: position));
  }

  Future<void> submitReport(LocationService locationService) async {
    if (state.image == null) {
      emit(state.copyWith(error: "Please Provide an Image."));
      return;
    }
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    final position = await locationService.getCurrentPosition();
    emit(state.copyWith(position: position));

    List<String>? address = await locationService.getAddressFromCoordinates(
      position.latitude,
      position.longitude,
    );
    try {
      final result = await _submitReportUseCase.call(
        details: state.details ?? '',
        latitude: position.latitude,
        longitude: position.longitude,
        severity: state.severity,
        city: address?[0] ?? '',
        road: address?[1] ?? '',
        state: address?[2] ?? '',
        country: address?[3] ?? '',
        imagePath: state.image!.path,
      );

      result.when(
        success: (data) {
          resetState();
          emit(state.copyWith(isLoading: false, successMessage: data));
        },
        failure: (error) {
          emit(state.copyWith(isLoading: false, error: error.message));
        },
      );
      resetState();
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: "Failed to submit report - ${error.toString()}",
        ),
      );
    }
  }

  void resetState() {
    emit(
      state.copyWith(
        image: null,
        details: null,
        severity: state.severity,
        position: null,
        isLoading: false,
        error: null,
        successMessage: null,
      ),
    );
    emit(SubmitReportState.initial());
  }
}
