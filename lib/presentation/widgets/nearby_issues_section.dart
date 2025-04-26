import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NearbyIssuesSection extends StatefulWidget {
  const NearbyIssuesSection({super.key});
  @override
  State<NearbyIssuesSection> createState() => _NearbyIssuesSectionState();
}
class _NearbyIssuesSectionState extends State<NearbyIssuesSection> {
  final List<Map<String, dynamic>> issues = [
    {
      'id': 1,
      'category': 'Defective Manhole',
      'location': 'Dokki street',
      'image': 'assets/images/issue1.jpg',
      'status': 'resolved',
    },
    {
      'id': 2,
      'category': 'Pothole',
      'location': 'Dokki street',
      'image': 'assets/images/issue2.jpg',
      'status': 'pending',
    },
    {
      'id': 3,
      'category': 'garbage',
      'location': 'Dokki street',
      'image': 'assets/images/issue3.jpg',
      'status': 'submitted',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: DraggableScrollableSheet(
            initialChildSize: issues.length == 1 ? 0.2 : 0.3,
            minChildSize: issues.length == 1 ? 0.2 : 0.3,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Drag handle
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 4.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: theme.colorScheme.primary,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '${issues.length} ${issues.length == 1 ? 'Issue' : 'Issues'} found near you',
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 16.h),
                        itemCount: issues.length,
                        itemBuilder: (context, index) {
                          return _buildIssueCard(issues[index], theme);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildIssueCard(Map<String, dynamic> issue, ThemeData theme) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Row(
        children: [
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(8.r)),
              image: DecorationImage(
                image: AssetImage(issue['image']),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.all(4.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(issue['status']),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  issue['status'].toString().toUpperCase(),
                  style: TextStyle(
                    color: theme.colorScheme.onPrimary,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    issue['category'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey, size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(
                        issue['location'],
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.9),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                minimumSize: Size(0, 30.h),
              ),
              child: Text(
                'Fast report',
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      case 'submitted':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
