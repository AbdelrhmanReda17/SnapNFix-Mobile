import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snapnfix/core/services/connectivity_service.dart';
import 'package:snapnfix/core/services/secure_storage_service.dart';
import 'package:snapnfix/features/reports/data/models/report_dto.dart';
import 'package:snapnfix/features/reports/data/models/report_severity.dart';
import 'package:snapnfix/features/reports/data/repository/add_report_repository.dart';
import 'package:uuid/uuid.dart';

part 'add_report_state.dart';
part 'add_report_cubit.freezed.dart';

class AddReportCubit extends Cubit<AddReportState> {
  final AddReportRepository addReportRepository;

  AddReportCubit(this.addReportRepository)
    : super(const AddReportState.initial());

  final detailsController = TextEditingController();
  final imageNotifier = ValueNotifier<File?>(null);
  final severityNotifier = ValueNotifier<ReportSeverity>(ReportSeverity.medium);
  final positionNotifier = ValueNotifier<Position?>(null);
  final formKey = GlobalKey<FormState>();

  Future<void> takePhoto() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (photo != null) {
        imageNotifier.value = File(photo.path);
        debugPrint('📸 Photo taken and saved at ${photo.path}');
      }
    } catch (e) {
      debugPrint('❌ Error taking photo: $e');
      emit(AddReportState.error(error: 'Error taking photo: ${e.toString()}'));
    }
  }

  Future<void> getCurrentPosition() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      setPosition(position);
    } catch (e) {
      debugPrint('❌ Error getting current position: $e');
      emit(
        AddReportState.error(error: 'Error getting location: ${e.toString()}'),
      );
    }
  }

  void setSeverity(ReportSeverity severity) {
    severityNotifier.value = severity;
  }

  void setPosition(Position? position) {
    positionNotifier.value = position;
  }

  Future<void> submitReport() async {
    emit(const AddReportState.loading());
    if (imageNotifier.value == null) {
      emit(
        const AddReportState.error(
          error: 'Please take a photo of the incident',
        ),
      );
      return;
    }

    if (positionNotifier.value == null) {
      emit(
        const AddReportState.error(
          error: 'Location data is required to submit a report',
        ),
      );
      return;
    }

    final report = ReportDTO(
      id: const Uuid().v4(),
      details: detailsController.text,
      latitude: positionNotifier.value!.latitude,
      longitude: positionNotifier.value!.longitude,
      imagePath: imageNotifier.value!.path,
      severity: severityNotifier.value.displayName,
      timestamp: DateTime.now().toIso8601String(),
    );
    final result = await addReportRepository.submitReport(report);

    result.when(
      success: (data) async {
        debugPrint(data);
        _resetForm();
        emit(AddReportState.success(data));
      },
      failure: (error) {
        debugPrint('❌ Failed to submit report: $error');
        emit(AddReportState.error(error: error));
      },
    );
  }

  void _resetForm() {
    detailsController.clear();
    imageNotifier.value = null;
    severityNotifier.value = ReportSeverity.low;
    positionNotifier.value = null;
  }

  @override
  Future<void> close() {
    detailsController.dispose();
    imageNotifier.dispose();
    severityNotifier.dispose();
    positionNotifier.dispose();
    return super.close();
  }
}
