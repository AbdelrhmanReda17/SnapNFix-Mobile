import 'package:flutter/material.dart';
import 'package:snapnfix/presentation/widgets/resolution_spotlight/data.dart';

class ResolutionSpotlightWidget extends StatefulWidget {
  const ResolutionSpotlightWidget({super.key});

  @override
  State<ResolutionSpotlightWidget> createState() =>
      _ResolutionSpotlightWidgetState();
}

class _ResolutionSpotlightWidgetState extends State<ResolutionSpotlightWidget> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Color _getIssueColor(String issueType) {
    switch (issueType.toLowerCase()) {
      case 'pothole':
        return Colors.orange.shade600;
      case 'garbage':
        return Colors.green.shade600;
      case 'defective manhole':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  IconData _getIssueIcon(String issueType) {
    switch (issueType.toLowerCase()) {
      case 'pothole':
        return Icons.warning;
      case 'garbage':
        return Icons.delete;
      case 'defective manhole':
        return Icons.construction;
      default:
        return Icons.report_problem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final stories = StaticHomeData.getResolutionStories();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing
    final isTablet = screenWidth > 600;
    final isLargeScreen = screenWidth > 900;
    final containerHeight =
        isTablet ? screenHeight * 0.40 : screenHeight * 0.37;
    final horizontalPadding = screenWidth * 0.04;
    final verticalPadding = screenHeight * 0.02;

    return Container(
      height: containerHeight.clamp(260.0, 400.0),
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding.clamp(8.0, 24.0),
      ),
      padding: EdgeInsets.all(verticalPadding.clamp(12.0, 20.0)),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, stories, isTablet, isLargeScreen),
          SizedBox(height: screenHeight * 0.005),
          _buildSubtitle(context, isTablet),
          SizedBox(height: screenHeight * 0.02),
          Expanded(child: _buildPageView(stories, isTablet, isLargeScreen)),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    List<ResolutionStory> stories,
    bool isTablet,
    bool isLargeScreen,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: Colors.green.shade600,
                size: isTablet ? 28 : 24,
              ),
              SizedBox(width: isTablet ? 12 : 8),
              Flexible(
                child: Text(
                  'Resolution Spotlight',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                    fontSize: isTablet ? 22 : 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        if (stories.length > 1) ...[
          SizedBox(width: isTablet ? 16 : 8),
          Row(
            children: List.generate(
              stories.length,
              (index) => Container(
                width: isTablet ? 10 : 8,
                height: isTablet ? 10 : 8,
                margin: EdgeInsets.symmetric(horizontal: isTablet ? 3 : 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentIndex == index
                          ? Colors.green.shade600
                          : Colors.grey.shade300,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context, bool isTablet) {
    return Text(
      'Recent success stories from your community',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.grey.shade600,
        fontSize: isTablet ? 14 : 12,
      ),
    );
  }

  Widget _buildPageView(
    List<ResolutionStory> stories,
    bool isTablet,
    bool isLargeScreen,
  ) {
    if (isLargeScreen && stories.length > 1) {
      // Show multiple cards side by side on large screens
      return _buildGridView(stories, isTablet);
    } else {
      // Standard PageView for mobile and tablet
      return PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return _buildStoryCard(
            context,
            stories[index],
            isTablet,
            isLargeScreen,
          );
        },
      );
    }
  }

  Widget _buildGridView(List<ResolutionStory> stories, bool isTablet) {
    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.2,
        mainAxisSpacing: 16,
      ),
      itemCount: stories.length,
      itemBuilder: (context, index) {
        return _buildStoryCard(context, stories[index], isTablet, true);
      },
    );
  }

  Widget _buildStoryCard(
    BuildContext context,
    ResolutionStory story,
    bool isTablet,
    bool isLargeScreen,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardMargin = isLargeScreen ? 8.0 : (isTablet ? 6.0 : 4.0);

    return Container(
      margin: EdgeInsets.only(right: cardMargin),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Before/After Images
              Expanded(
                flex: isTablet ? 4 : 3,
                child: _buildBeforeAfterImages(
                  story,
                  isTablet,
                  constraints.maxWidth,
                ),
              ),
              SizedBox(height: isTablet ? 16 : 12),
              // Story Details
              Expanded(
                flex: isTablet ? 3 : 2,
                child: _buildStoryDetails(
                  context,
                  story,
                  isTablet,
                  screenWidth,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBeforeAfterImages(
    ResolutionStory story,
    bool isTablet,
    double maxWidth,
  ) {
    final arrowSize = isTablet ? 28.0 : 24.0;
    final spacing = maxWidth > 300 ? 16.0 : 12.0;

    return Row(
      children: [
        Expanded(
          child: _buildImageContainer(
            'Before',
            story.beforeImageUrl,
            Colors.red.shade100,
            Colors.red.shade600,
            isTablet,
          ),
        ),
        SizedBox(width: spacing),
        Icon(
          Icons.arrow_forward,
          color: Colors.green.shade600,
          size: arrowSize,
        ),
        SizedBox(width: spacing),
        Expanded(
          child: _buildImageContainer(
            'After',
            story.afterImageUrl,
            Colors.green.shade100,
            Colors.green.shade600,
            isTablet,
          ),
        ),
      ],
    );
  }

  Widget _buildStoryDetails(
    BuildContext context,
    ResolutionStory story,
    bool isTablet,
    double screenWidth,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildIssueTypeChip(story, isTablet),
        SizedBox(height: isTablet ? 8 : 6),
        Flexible(
          child: Text(
            story.title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
              fontSize: isTablet ? 16 : 14,
            ),
            maxLines: isTablet ? 3 : 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: isTablet ? 6 : 4),
        _buildLocationRow(context, story, isTablet),
        SizedBox(height: isTablet ? 4 : 2),
        Text(
          story.resolutionTimeText,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.green.shade600,
            fontWeight: FontWeight.w500,
            fontSize: isTablet ? 13 : 11,
          ),
        ),
      ],
    );
  }

  Widget _buildIssueTypeChip(ResolutionStory story, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 10 : 8,
        vertical: isTablet ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: _getIssueColor(story.issueType).withOpacity(0.1),
        borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIssueIcon(story.issueType),
            size: isTablet ? 14 : 12,
            color: _getIssueColor(story.issueType),
          ),
          SizedBox(width: isTablet ? 6 : 4),
          Text(
            story.issueType,
            style: TextStyle(
              fontSize: isTablet ? 12 : 10,
              fontWeight: FontWeight.w600,
              color: _getIssueColor(story.issueType),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(
    BuildContext context,
    ResolutionStory story,
    bool isTablet,
  ) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: isTablet ? 14 : 12,
          color: Colors.grey.shade500,
        ),
        SizedBox(width: isTablet ? 6 : 4),
        Expanded(
          child: Text(
            story.location,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade600,
              fontSize: isTablet ? 13 : 11,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildImageContainer(
    String label,
    String imageUrl,
    Color bgColor,
    Color borderColor,
    bool isTablet,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(isTablet ? 12 : 8),
        border: Border.all(color: borderColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: isTablet ? 6 : 4),
            decoration: BoxDecoration(
              color: borderColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isTablet ? 12 : 8),
                topRight: Radius.circular(isTablet ? 12 : 8),
              ),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isTablet ? 13 : 11,
                  fontWeight: FontWeight.w600,
                  color: borderColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(isTablet ? 12 : 8),
                  bottomRight: Radius.circular(isTablet ? 12 : 8),
                ),
              ),
              child: Icon(
                Icons.image,
                color: Colors.grey.shade400,
                size: isTablet ? 40 : 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
