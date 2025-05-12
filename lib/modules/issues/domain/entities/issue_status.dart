import 'package:flutter/material.dart';

enum IssueStatus {
  pending('Pending', Color.fromARGB(255, 233, 191, 2), Icons.hourglass_empty),
  inProgress('In Progress', Colors.green, Icons.build_circle_outlined),
  fixed('Fixed', Colors.blue, Icons.check_circle_outline);

  final String displayName;
  final Color color;
  final IconData icon;
  const IssueStatus(this.displayName, this.color, this.icon);

  @override
  String toString() {
    return displayName;
  }

  Color get backgroundColor => color.withValues(alpha: 0.15);
  Color get borderColor => color.withValues(alpha: 0.5);
}
