import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  bool _isFirstCheck = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _connectionService.getNetworkStream,
      builder: (context, snapshot) {
        bool? isConnected = snapshot.data;

        if (_isFirstCheck && isConnected != null) {
          _isFirstCheck = false;
          _previousStatus = isConnected;

          if (isConnected != _previousStatus && isConnected) {
            _showNetworkToast(context, isConnected);
          }
          return const SizedBox.shrink();
        }

        if (_previousStatus != null &&
            isConnected != _previousStatus &&
            isConnected != null) {
          _previousStatus = isConnected;
          _showNetworkToast(context, isConnected);
        }
        _previousStatus = isConnected;
        return const SizedBox.shrink();
      },
    );
  }

  void _showNetworkToast(BuildContext context, bool isConnected) {
    Future.microtask(() {
      final localization = AppLocalizations.of(context)!;

      BaseToast.show(
        context: context,
        message:
            isConnected
                ? localization.connectedToInternet
                : localization.noInternetConnection,
        type: isConnected ? ToastType.success : ToastType.error,
        duration: const Duration(seconds: 2),
      );
    });
  }
}
