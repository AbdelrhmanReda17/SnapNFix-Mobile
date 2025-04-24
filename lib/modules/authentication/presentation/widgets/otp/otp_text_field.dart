import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpTextField extends StatefulWidget {
  final int numberOfFields;
  final Color borderColor;
  final bool showFieldAsBox;
  final Function(String) onCodeChanged;

  const OtpTextField({
    super.key,
    required this.numberOfFields,
    required this.borderColor,
    required this.showFieldAsBox,
    required this.onCodeChanged,
  });

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  List<FocusNode> focusNodes = [];
  List<TextEditingController> textControllers = [];
  String currentCode = "";

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.numberOfFields; i++) {
      focusNodes.add(FocusNode());
      textControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateCurrentCode() {
    currentCode = "";
    for (var controller in textControllers) {
      currentCode += controller.text;
    }
    widget.onCodeChanged(currentCode);

    // bool allFilled = true;
    // for (var controller in textControllers) {
    //   if (controller.text.isEmpty) {
    //     allFilled = false;
    //     break;
    //   }
    // }
    
    // if (allFilled) {
    //   // widget.onSubmit(currentCode);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        widget.numberOfFields,
        (index) => SizedBox(
          width: 50.w,
          height: 60.h,
          child: TextFormField(
            controller: textControllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: theme.textTheme.headlineMedium,
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor),
                  borderRadius: BorderRadius.circular(8.r),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.borderColor, width: 2.w),
                  borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),  
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < widget.numberOfFields - 1) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              }
              _updateCurrentCode();
            },
          ),
        ),
      ),
    );
  }
}