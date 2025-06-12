import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snapnfix/core/index.dart';
import 'package:snapnfix/modules/issues/index.dart';

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
            // showDialog(
            //   context: context,
            //   barrierDismissible: true,
            //   builder:
            //       (context) => Dialog(
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(16),
            //         ),
            //         insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            //         child: IssueMarkerDialog(
            //           issue: state.selectedIssue!,
            //           onReportTap: () {
            //             Navigator.pop(context);
            //           },
            //         ),
            //       ),
            // ).then((_) {
            //   _issuesMapCubit.onIssueDetailClosed();
            // });
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
                    ),
                    // MapControllers(
                    //   onSearchTap: () => IssueFilterSheet.show(context),
                    // ),
                    // if (state.filteredIssues.isNotEmpty) ...[
                    //   NearbyIssuesSection(
                    //     issues: state.filteredIssues,
                    //     onIssueSelected: (issue) async {
                    //       await _issuesMapCubit.onIssueTapped(
                    //         issue.latitude,
                    //         issue.longitude,
                    //       );
                    //     },
                    //   ),
                    // ],
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _issuesMapCubit.close();
    super.dispose();
  }
}
