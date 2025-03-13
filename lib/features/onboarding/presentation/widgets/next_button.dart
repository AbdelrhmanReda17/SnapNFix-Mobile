import 'package:flutter/material.dart';
import 'package:snapnfix/core/theming/colors.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.isLastPage,
    required PageController controller,
  }) : _controller = controller;

  final bool isLastPage;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (isLastPage) {
        } else {
          _controller.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        }
      },
      child: Icon(Icons.arrow_forward, size: 32),
    );
  }
}
