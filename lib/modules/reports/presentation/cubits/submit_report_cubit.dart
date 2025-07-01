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
import 'package:geolocator/geolocator.dart';

part 'submit_report_state.dart';
part 'submit_report_cubit.freezed.dart';

class SubmitReportCubit extends Cubit<SubmitReportState> {
  final SubmitReportUseCase _submitReportUseCase;

  SubmitReportCubit(this._submitReportUseCase)
    : super(SubmitReportState.initial());

  void setAdditionalDetails(String value) async {
    emit(state.copyWith(comment: value));
  }

  void setTempImage() async {
    final tempDir = await getTemporaryDirectory();
    final imageNames = ['issue1.jpg', 'issue2.jpg', 'issue3.jpg'];
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
      if (isClosed) return;
      emit(state.copyWith(error: "Please Provide an Image."));
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
          error: "Failed to submit report - ${error.toString()}",
        ),
      );
    }
  }

  void resetState() {
    emit(
      state.copyWith(
        image: null,
        comment: null,
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
