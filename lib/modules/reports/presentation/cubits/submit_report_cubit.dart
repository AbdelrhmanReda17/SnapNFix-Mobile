import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:snapnfix/core/infrastructure/location/location_service.dart';
import 'package:snapnfix/core/infrastructure/networking/api_error_handler.dart';
import 'package:snapnfix/modules/reports/data/model/report_model.dart';
import 'package:snapnfix/modules/reports/domain/entities/report_severity.dart';
import 'package:snapnfix/modules/reports/domain/usecases/submit_report_use_case.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

part 'submit_report_state.dart';
part 'submit_report_cubit.freezed.dart';

class SubmitReportCubit extends Cubit<SubmitReportState> {
  final SubmitReportUseCase _submitReportUseCase;
  final detailsController = TextEditingController();

  SubmitReportCubit(this._submitReportUseCase)
    : super(SubmitReportState.initial()) {
    detailsController.addListener(_updateDetails);
  }

  void _updateDetails() {
    emit(state.copyWith(details: detailsController.text));
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
      emit(state.copyWith(error: "Please provide an image."));
      return;
    }
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    final position = await locationService.getCurrentPosition();
    emit(state.copyWith(position: position));
    try {
      final result = await _submitReportUseCase.call(
        ReportModel(
          id: const Uuid().v4(),
          details: detailsController.text,
          severity: state.severity,
          image: state.image?.path ?? '',
          latitude: state.position!.latitude,
          longitude: state.position!.longitude,
          timestamp: DateTime.now().toIso8601String(),
          issueId: '',
        ),
      );

      result.when(
        success: (data) {
          emit(state.copyWith(isLoading: false, successMessage: data));
        },
        failure: (error) {
          emit(
            state.copyWith(
              isLoading: false,
              error: error.getAllErrorMessages(),
            ),
          );
        },
      );
      resetState();
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: ApiErrorHandler.handle(error).getAllErrorMessages(),
        ),
      );
    }
  }

  void resetState() {
    emit(SubmitReportState.initial());
    detailsController.clear();
  }

  @override
  Future<void> close() {
    detailsController.dispose();
    return super.close();
  }
}
