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
            debugPrint(
              'IssueMapScreen: Selected issue ID changed: ${state.selectedIssueId}',
            );
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
                      onTap: () {
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
              return Stack(
                children: [
                  if (state.status == MapStatus.loading) ...[
                    const Center(child: CircularProgressIndicator()),
                  ],
                  if (state.status == MapStatus.error) ...[
                    Center(child: Text(state.error ?? 'An error occurred')),
                  ],
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

                    // Location control button
                    Positioned(
                      right: 16,
                      bottom: 100,
                      child: FloatingActionButton(
                        heroTag: 'location',
                        mini: true,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.my_location,
                          color:
                              state.isFollowingUser ? Colors.blue : Colors.grey,
                        ),
                        onPressed:
                            () => _getCurrentPosition().then((position) {
                              if (position != null) {
                                _issuesMapCubit.centerOnUserLocation(position);
                              }
                            }),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<Position?> _getCurrentPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not get current position')),
      );
      return null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
