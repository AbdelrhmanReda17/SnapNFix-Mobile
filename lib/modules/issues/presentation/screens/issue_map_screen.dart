import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snapnfix/core/index.dart';
import 'package:snapnfix/modules/issues/index.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issues_map.dart';

class IssueMapScreen extends StatefulWidget {
  const IssueMapScreen({super.key});

  @override
  State<IssueMapScreen> createState() => _IssueMapScreenState();
}

class _IssueMapScreenState extends State<IssueMapScreen> {
  bool _isInitialized = false;
  late IssuesMapCubit _issuesMapCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _issuesMapCubit = context.read<IssuesMapCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return LocationPermissionWidget(
      builder: (Position position) {
        if (!_isInitialized) {
          _isInitialized = true;
          _issuesMapCubit.initialize(position);
        }
        return BlocListener<IssuesMapCubit, IssuesMapState>(
          listenWhen:
              (previous, current) =>
                  previous.selectedIssueId != current.selectedIssueId &&
                  current.selectedIssueId != null &&
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
                    child: IssueMarkerDialog(
                      issueId: state.selectedIssueId!,
                      onTap: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ),
            ).then((_) {
              _issuesMapCubit.onIssueDetailClosed();
            });
          },
          child: BlocBuilder<IssuesMapCubit, IssuesMapState>(
            builder: (context, state) {
              return Scaffold(
                body: Stack(
                  children: [
                    // Loading State
                    if (state.status == MapStatus.loading) ...[
                      const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Loading map...'),
                          ],
                        ),
                      ),
                    ],

                    // Error State
                    if (state.status == MapStatus.error) ...[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.error ?? 'An error occurred',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed:
                                  () => _getCurrentPosition().then((pos) {
                                    if (pos != null) {
                                      _issuesMapCubit.initialize(pos);
                                    }
                                  }),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // Map Content
                    if (state.cameraPosition != null) ...[
                      IssuesMap(
                        initialCameraPosition: state.cameraPosition!,
                        myLocationEnabled: true,
                        markers: state.markers,
                        onMapCreated: _issuesMapCubit.onMapCreated,
                        onCameraMove: _issuesMapCubit.onCameraMove,
                        onBoundsChange: _issuesMapCubit.onBoundsChanged,
                        minMaxZoomPreference: state.minMaxZoomPreference,
                        cameraTargetBounds: state.cameraTargetBounds,
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<Position?> _getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not get current position: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
