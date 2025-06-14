import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/index.dart';
import 'package:snapnfix/modules/reports/presentation/widgets/fast_report/fast_report_dialog.dart';

class IssueMarkerDialog extends StatefulWidget {
  final String issueId;
  final VoidCallback onTap;

  const IssueMarkerDialog({
    super.key,
    required this.issueId,
    required this.onTap,
  });

  @override
  State<IssueMarkerDialog> createState() => _IssueMarkerDialogState();
}

class _IssueMarkerDialogState extends State<IssueMarkerDialog> {
  Issue? _issue;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchIssueDetails();
    });
  }

  Future<void> _fetchIssueDetails() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final dataSource = getIt<GetIssueDetailsUseCase>();
      final result = await dataSource.call(widget.issueId);

      result.when(
        success: (issue) {
          setState(() {
            _issue = issue;
            _isLoading = false;
          });
        },
        failure: (error) {
          setState(() {
            _error = error.message;
            _isLoading = false;
          });
        },
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isLoading)
            _buildLoadingView()
          else if (_error != null)
            ..._buildErrorView()
          else if (_issue != null)
            _buildIssueContent(_issue!)
          else
            const Text("No issue data available"),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return const CircularProgressIndicator();
  }

  List<Widget> _buildErrorView() {
    return [
      const Icon(Icons.error_outline, color: Colors.red, size: 48),
      const SizedBox(height: 8),
      Text('$_error'),
      const SizedBox(height: 16),
      ElevatedButton(
        onPressed: _fetchIssueDetails,
        child: const Text('Try Again'),
      ),
    ];
  }

  Widget _buildIssueContent(Issue issue) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.onSurface.withValues(alpha: .1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IssueCard(
            issue: issue,
            showReportButton: true,
            onReportTap: () async {
            final success = await FastReportDialog.show(
              context: context,
              issueId: widget.issueId,
              onSuccess: widget.onTap,
            );
            if (success == true) {
              widget.onTap();
            }
          },
          ),
        ],
      ),
    );
  }
}
