import 'package:flutter/material.dart';

enum IssueStatus {
  pending('Pending', Colors.yellow),
  inProgress('In Progress', Colors.green),
  fixed('Fixed', Colors.blue);

  final String displayName;
  final Color color;
  const IssueStatus(this.displayName, this.color);
}
