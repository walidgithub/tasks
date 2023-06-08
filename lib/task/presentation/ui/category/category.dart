import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../shared/constant/constant_values_manager.dart';
import '../../../shared/style/colors_manager.dart';

class Category extends StatefulWidget {
  String name;
  double percent;

  Category({required this.name, required this.percent});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      duration: const Duration(milliseconds: 100),
      onTap: ()async{
        await Future.delayed(Duration(milliseconds: 150));
        setState(() {
        });
      },
      child: Container(
          margin: const EdgeInsets.fromLTRB(5,0,5,0),
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          // width: 150,
          // height: 50,
          decoration: BoxDecoration(
            color: ColorManager.basic,
              border: Border.all(
                color: ColorManager.accent,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text((widget.name), style: TextStyle(fontSize: 20.sp,color: ColorManager.darkbasic)),
                SizedBox(
                  width: AppConstants.smallDistance,
                ),
                CircularPercentIndicator(
                  radius: 25.0.h,
                  lineWidth: 5.0.w,
                  percent: widget.percent / 100,
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Countup(
                        begin: 0,
                        end: widget.percent,
                        duration: Duration(seconds: 5),
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      Text('%',style: TextStyle(fontSize: 10.sp),)
                    ],
                  ),
                  backgroundColor: ColorManager.accent,
                  progressColor: ColorManager.primary,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 6000,
                  curve: Curves.easeInOut,
                )
              ],
            ),
          )),
    );
  }

}
