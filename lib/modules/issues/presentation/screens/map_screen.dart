import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_cubit.dart';
import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_state.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/loading_overlay.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/map_screen_error.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/report_marker_detail.dart';

class IssueMapScreen extends StatefulWidget {
  const IssueMapScreen({super.key});

  @override
  State<IssueMapScreen> createState() => _IssueMapScreenState();
}

class _IssueMapScreenState extends State<IssueMapScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<IssuesMapCubit>().initialize();
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<IssuesMapCubit>().checkLocationPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IssuesMapCubit, IssuesMapState>(
      listenWhen:
          (previous, current) =>
              previous.selectedIssue != current.selectedIssue &&
              current.selectedIssue != null &&
              current.showIssueDetail,
      listener: (context, state) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder:
              (context) => Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                child: ReportMarkerDetail(
                  issue: state.selectedIssue!,
                  onReportTap: () {
                    Navigator.pop(context);
                    // TODO: Submit report action
                  },
                ),
              ),
        ).then((_) {
          context.read<IssuesMapCubit>().onIssueDetailClosed();
        });
      },
      child: BlocBuilder<IssuesMapCubit, IssuesMapState>(
        builder: (context, state) {
          if (state.status == MapStatus.error) {
            return MapScreenError(
              type: MapErrorType.general,
              onActionPressed:
                  () => context.read<IssuesMapCubit>().initialize(),
            );
          }
          return Stack(
            children: [
              if (!state.hasLocationPermission &&
                  state.status != MapStatus.loading)
                MapScreenError(
                  type: MapErrorType.permission,
                  onActionPressed:
                      () =>
                          context.read<IssuesMapCubit>().openLocationSettings(),
                )
              else if (state.cameraPosition != null &&
                  state.status != MapStatus.loading &&
                  state.hasLocationPermission) ...[
                _buildMap(context, state),
              ] else if (state.status == MapStatus.loading)
                const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMap(BuildContext context, IssuesMapState state) {
    if (state.cameraPosition == null) {
      return const Center(child: LoadingOverlay());
    }

    return RepaintBoundary(
      child: GoogleMap(
        initialCameraPosition: state.cameraPosition!,
        myLocationEnabled: state.hasLocationPermission,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.hybrid,
        markers: state.markers,
        onMapCreated: context.read<IssuesMapCubit>().onMapCreated,
        onCameraMove: context.read<IssuesMapCubit>().onCameraMove,
      ),
    );
  }
}
