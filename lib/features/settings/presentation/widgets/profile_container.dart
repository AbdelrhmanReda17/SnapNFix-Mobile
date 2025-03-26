import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:snapnfix/core/theming/colors.dart';
import 'package:snapnfix/core/theming/text_styles.dart';
import 'package:snapnfix/features/authentication/data/models/user.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 148.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      color: ColorsManager.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Settings",
            style: TextStyles.font24Normal(TextColor.whiteColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: ColorsManager.quaternaryColor,
                    child:
                        user.profileImage != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: Image.network(
                                user.profileImage!,
                                width: 60.w,
                                height: 60.h,
                                fit: BoxFit.cover,
                              ),
                            )
                            : Text(
                              user.name[0],
                              style: TextStyle(
                                color: ColorsManager.primaryColor,
                              ),
                            ),
                  ),
                  SizedBox(width: 12.w),
                  SizedBox(
                    width: 200.w,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: "Hello\n",
                        style: TextStyles.font16Normal(TextColor.whiteColor),
                        children: [
                          TextSpan(
                            text: user.name,
                            style: TextStyles.font16Normal(
                              TextColor.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                iconSize: 20.r,
                icon: Icon(Icons.edit, color: ColorsManager.quaternaryColor),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
