// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_cubit.dart';
// import 'package:snapnfix/modules/issues/presentation/cubits/issues_map_state.dart';
// import 'package:snapnfix/modules/issues/presentation/widgets/loading_overlay.dart';
// import '../widgets/map_controls.dart';

// class IssueMapScreen extends StatefulWidget {
//   const IssueMapScreen({super.key});

//   @override
//   State<IssueMapScreen> createState() => _IssueMapScreenState();
// }

// class _IssueMapScreenState extends State<IssueMapScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<IssuesMapCubit>().initialize();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<IssuesMapCubit, IssuesMapState>(
//       listener: (context, state) {
//         if (state.error != null) {
//           _showErrorSnackBar(context, state.error!);
//         }
//       },
//       builder: (context, state) {
//         return Stack(
//           children: [
//             _buildMap(context, state),
//             if (state.status == MapStatus.loading) const LoadingOverlay(),
//             if (state.hasLocationPermission) const MapControls(),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildMap(BuildContext context, IssuesMapState state) {
//     if (state.cameraPosition == null) {
//       return const Center(child: Text('Initializing map...'));
//     }

//     return RepaintBoundary(
//       child: GoogleMap(
//         initialCameraPosition: state.cameraPosition!,
//         myLocationEnabled: state.hasLocationPermission,
//         myLocationButtonEnabled: false,
//         zoomControlsEnabled: false,
//         mapType: MapType.normal,
//         markers: state.markers,
//         // Reduce unnecessary rebuilds
//         onMapCreated: context.read<IssuesMapCubit>().onMapCreated,
//         // Add throttling for camera movements
//         onCameraMove: _throttleCameraMove(context),
//         onCameraIdle: context.read<IssuesMapCubit>().onCameraIdle,
//       ),
//     );
//   }

//   // Add throttling helper
//   Function(CameraPosition) _throttleCameraMove(BuildContext context) {
//     DateTime? lastCall;
//     return (CameraPosition position) {
//       final now = DateTime.now();
//       if (lastCall == null ||
//           now.difference(lastCall!) > const Duration(milliseconds: 150)) {
//         lastCall = now;
//         context.read<IssuesMapCubit>().onCameraMove(position);
//       }
//     };
//   }

//   void _showErrorSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         behavior: SnackBarBehavior.floating,
//         backgroundColor: Colors.red,
//         action: SnackBarAction(
//           label: 'Dismiss',
//           textColor: Colors.white,
//           onPressed: () {
//             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//           },
//         ),
//       ),
//     );
//   }
// }
