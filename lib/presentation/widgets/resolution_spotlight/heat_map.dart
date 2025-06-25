import 'package:flutter/material.dart';
import 'package:snapnfix/presentation/widgets/resolution_spotlight/data.dart';

class IssueHeatmapWidget extends StatelessWidget {
  const IssueHeatmapWidget({super.key});

  Color _getHeatColor(double intensity) {
    if (intensity >= 0.8) return Colors.red.shade600;
    if (intensity >= 0.6) return Colors.orange.shade600;
    if (intensity >= 0.4) return Colors.yellow.shade700;
    if (intensity >= 0.2) return Colors.lightGreen.shade600;
    return Colors.green.shade600;
  }

  IconData _getIssueIcon(String issueType) {
    switch (issueType.toLowerCase()) {
      case 'potholes':
        return Icons.warning;
      case 'garbage':
        return Icons.delete;
      case 'defective manholes':
        return Icons.construction;
      default:
        return Icons.report_problem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final heatSpots = StaticHomeData.getHeatSpots();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.map, color: Colors.blue.shade600, size: 24),
              const SizedBox(width: 8),
              Text(
                'Issue Heatmap',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Areas needing attention in your city',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          ...heatSpots.map((spot) => _buildHeatSpotItem(context, spot)),
          const SizedBox(height: 12),
          _buildLegend(context),
        ],
      ),
    );
  }

  Widget _buildHeatSpotItem(BuildContext context, HeatSpot spot) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getHeatColor(spot.intensity).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _getHeatColor(spot.intensity),
                width: 2,
              ),
            ),
            child: Icon(
              _getIssueIcon(spot.mostCommonIssue),
              color: _getHeatColor(spot.intensity),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spot.areaName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${spot.issueCount} issues • Mostly ${spot.mostCommonIssue}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getHeatColor(spot.intensity),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              spot.issueCount.toString(),
              style: TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildLegendItem('Low', Colors.green.shade600),
          _buildLegendItem('Medium', Colors.yellow.shade700),
          _buildLegendItem('High', Colors.orange.shade600),
          _buildLegendItem('Critical', Colors.red.shade600),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
