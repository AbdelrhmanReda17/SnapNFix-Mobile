import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/utils/helpers/spacing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_details/images_slider/slider_image_item.dart';
import 'package:snapnfix/modules/issues/presentation/widgets/issue_details/images_slider/image_slider_indicator.dart';

class IssueImageSlider extends StatefulWidget {
  final List<String> images;

  const IssueImageSlider({super.key, required this.images});

  @override
  State<IssueImageSlider> createState() => _IssueImageSliderState();
}

class _IssueImageSliderState extends State<IssueImageSlider> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 250.h,
            viewportFraction: 0.85,
            enlargeCenterPage: true,
            enableInfiniteScroll: widget.images.length > 1,
            autoPlay: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            enlargeStrategy: CenterPageEnlargeStrategy.height,
          ),
          items:
              widget.images.isEmpty
                  ? [_buildErrorImagePlacehoder(context, colorScheme)]
                  : widget.images
                      .asMap()
                      .entries
                      .map(
                        (entry) => SliderImageItem(
                          image: entry.value,
                          index: entry.key,
                        ),
                      )
                      .toList(),
        ),

        verticalSpace(16.h),

        if (widget.images.length > 1)
          ImageSliderIndicator(
            itemCount: widget.images.length,
            currentIndex: _currentIndex,
            onDotTapped: (index) {
              _carouselController.animateToPage(index);
            },
          ),
      ],
    );
  }

  Widget _buildErrorImagePlacehoder(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 48.r,
              color: colorScheme.onSurfaceVariant,
            ),
            verticalSpace(8),
            Text(
              AppLocalizations.of(context)!.imagesNotAvaiable,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
