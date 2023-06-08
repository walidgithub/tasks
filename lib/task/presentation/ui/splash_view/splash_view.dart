import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasks/task/shared/style/colors_manager.dart';
import 'dart:math' as math;

import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../shared/component/splash_clipper.dart';
import '../../../shared/constant/assets_manager.dart';
import '../../../shared/constant/strings_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _isExpanded = false;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: bodyContent(size),
      ),
    );
  }

  Widget bodyContent(Size size) {
    return Column(
      children: [
        Stack(
          children: [
            ClipPath(
                clipper: SplashClipper(),
                child: SizedBox(
                    height: size.height - 110.h,
                    width: double.infinity,
                    child: Container(
                      color: ColorManager.lightPrimary,
                    ))),
            ClipPath(
              clipper: SplashClipper(),
              child: SizedBox(
                height: size.height - 120.h,
                width: double.infinity,
                child: Container(
                  color: ColorManager.darkPrimary,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50.0),
                        child:
                        Image.asset(ImageAssets.taskslogo, width: 110.w),
                      ),
                      Positioned(
                        left: -20.w,
                        top: 20.h,
                        child: Opacity(
                          opacity: 0.2,
                          child: Container(
                            height: 200.h,
                            width: 200.w,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorManager.lightPrimary),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -20.w,
                        top: 220.h,
                        child: Opacity(
                          opacity: 0.2,
                          child: Container(
                            height: 100.h,
                            width: 100.w,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorManager.lightPrimary),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20.w,
                        top: 325.h,
                        child: Opacity(
                          opacity: 0.2,
                          child: Container(
                            height: 70.h,
                            width: 70.w,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorManager.lightPrimary),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 70.w,
                        top: 395.h,
                        child: Opacity(
                          opacity: 0.2,
                          child: Container(
                            height: 40.h,
                            width: 40.w,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorManager.lightPrimary),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.linear,
                        top: 20.h,
                        left: _isExpanded ? 350.w : 550.w,
                        child: Transform.rotate(
                          angle: math.pi / -5,
                          child: Container(
                            width: 250.w,
                            height: 600.h,
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.w, color: ColorManager.primary),
                              borderRadius: BorderRadius.circular(50),
                              color: ColorManager.primary,
                              shape: BoxShape.rectangle,
                            ),
                            child: Align(
                              alignment: Alignment(-0.90, -0.93),
                              child: Transform.rotate(
                                angle: math.pi / 5.5,
                                child: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: ColorManager.secondAccent),
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: ColorManager.basic,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.linear,
                        top: 120.h,
                        left: _isExpanded ? 360.w : 550.w,
                        child: Transform.rotate(
                          angle: math.pi / -5,
                          child: Container(
                            width: 250.w,
                            height: 600.h,
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.w, color: ColorManager.lightPrimary),
                              borderRadius: BorderRadius.circular(50),
                              color: ColorManager.lightPrimary,
                              shape: BoxShape.rectangle,
                            ),
                            child: Align(
                              alignment: Alignment(-0.90, -0.93),
                              child: Transform.rotate(
                                angle: math.pi / 5.5,
                                child: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: ColorManager.darkPrimary),
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                      color: ColorManager.basic,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 2000),
                        curve: Curves.linear,
                        top: 210.h,
                        left: _isExpanded ? 370.w : 550.w,
                        child: Transform.rotate(
                          angle: math.pi / -5,
                          child: Container(
                            width: 250.w,
                            height: 600.h,
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.w, color: ColorManager.secondAccent),
                              borderRadius: BorderRadius.circular(50),
                              color: ColorManager.secondAccent,
                              shape: BoxShape.rectangle,
                            ),
                            child: Align(
                              alignment: Alignment(-0.90, -0.93),
                              child: Transform.rotate(
                                angle: math.pi / 5.5,
                                child: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: ColorManager.primary),
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: ColorManager.basic,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: TextAnimator(
                    AppStrings.spashText.tr(),
                    atRestEffect:
                        WidgetRestingEffects.pulse(effectStrength: 0.6),
                    style: Theme.of(context).textTheme.headline1,
                    incomingEffect:
                        WidgetTransitionEffects.incomingSlideInFromTop(
                            blur: const Offset(0, 20), scale: 2),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future startAnimation() async{
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _isExpanded = true;
    });
  }
}

