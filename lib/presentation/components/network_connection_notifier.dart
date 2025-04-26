import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/base_components/base_toast.dart';
import 'package:snapnfix/core/dependency_injection/dependency_injection.dart';
import 'package:snapnfix/core/infrastructure/connectivity/connectivity_service.dart';

class NetworkConnectionNotifier extends StatefulWidget {
  const NetworkConnectionNotifier({super.key});

  @override
  State<NetworkConnectionNotifier> createState() =>
      _NetworkConnectionNotifierState();
}

class _NetworkConnectionNotifierState extends State<NetworkConnectionNotifier> {
  final ConnectivityService _connectionService = getIt<ConnectivityService>();
  bool? _previousStatus;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _connectionService.getNetworkStream,
      builder: (context, snapshot) {
        final isConnected = snapshot.data ?? false;

        if (_previousStatus != null && isConnected != _previousStatus) {
          _previousStatus = isConnected;

          Future.microtask(() {
            BaseToast.show(
              context: context,
              message: isConnected ? 'You are online' : 'You are offline',
              type: isConnected ? ToastType.success : ToastType.error,
              duration: const Duration(seconds: 2),
            );
          });
        }

        _previousStatus = isConnected;
        return const SizedBox.shrink();
      },
    );
  }
}
