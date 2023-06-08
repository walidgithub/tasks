import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks/task/shared/style/colors_manager.dart';
import 'package:tasks/task/presentation/ui/add_task/add_task.dart';

import '../../../shared/constant/assets_manager.dart';
import '../../../shared/constant/strings_manager.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: OnBoardingSlider(
          finishButtonText: AppStrings.onBordingButton.tr(),
          onFinish: () {
            // Navigator.push(
            //   context,
            //   CupertinoPageRoute(
            //     builder: (context) => const RegisterPage(),
            //   ),
            // );
          },
          finishButtonStyle: FinishButtonStyle(
            backgroundColor: ColorManager.accent,
          ),
          skipTextButton: Text(
            AppStrings.skip.tr(),
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorManager.darkPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),

          controllerColor: ColorManager.primary,
          headerBackgroundColor: ColorManager.basic,
          pageBackgroundColor: ColorManager.basic,

          totalPage: 4,

          background: [
            Image.asset(
              ImageAssets.dart,
              width: MediaQuery.of(context).size.width,
              height: 350.h,
            ),
            Image.asset(
              ImageAssets.create_task,
              width: MediaQuery.of(context).size.width,
              height: 350.h,
            ),
            Image.asset(
              ImageAssets.manage_easily,
              width: MediaQuery.of(context).size.width,
              height: 350.h,
            ),
            Image.asset(
              ImageAssets.go_ahead,
              width: MediaQuery.of(context).size.width,
              height: 350.h,
            ),
          ],
          speed: 1.8,
          pageBodies: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 400.h,
                  ),
                  Text(
                    AppStrings.onBordingTitle1.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorManager.darkPrimary,
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    AppStrings.onBordingBody1.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 400.h,
                  ),
                  Text(
                    AppStrings.onBordingTitle2.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorManager.darkPrimary,
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    AppStrings.onBordingBody2.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 400.h,
                  ),
                  Text(
                    AppStrings.onBordingTitle3.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorManager.darkPrimary,
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    AppStrings.onBordingBody3.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 400.h,
                  ),
                  Text(
                    AppStrings.onBordingTitle4.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorManager.darkPrimary,
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    AppStrings.onBordingBody4.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 18.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
