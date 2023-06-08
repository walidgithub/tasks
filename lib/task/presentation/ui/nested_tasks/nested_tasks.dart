import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';
import 'package:tasks/task/shared/constant/strings_manager.dart';

import '../../../shared/constant/assets_manager.dart';
import '../../../shared/constant/constant_values_manager.dart';
import '../../../shared/style/colors_manager.dart';

class NestedTasks extends StatefulWidget {

  String taskName;
  String description;
  String time;
  bool timer;
  bool counter;
  bool wheel;
  int nested_id;
  bool done;

  NestedTasks({required this.taskName, required this.description, required this.time,
    required this.timer, required this.counter, required this.wheel, required this.nested_id, required this.done});

  @override
  State<NestedTasks> createState() => _NestedTasksState();
}

class _NestedTasksState extends State<NestedTasks> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(0, 8, 15, 10),
              decoration: (
                  BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 2.w, color: ColorManager.accent),
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white,
                            ColorManager.darkPrimary,
                          ]))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    widget.taskName,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  widget.done ? Icon(Icons.done,color: ColorManager.blueColor,) : Container(),
                                ],
                              ),
                              widget.counter ?
                              Bounceable(
                                duration: const Duration(milliseconds: 100),
                                onTap:() async {
                                  await Future.delayed(Duration(milliseconds: 100));
                                },
                                child: Container(
                                  width: 70.w,
                                  height: 40.h,
                                  decoration: (BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 2.w, color: ColorManager.accent),
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
                                          begin: Alignment.centerRight,
                                          end: Alignment.centerLeft,
                                          colors: [
                                            Colors.white,
                                            ColorManager.lightPrimary,
                                          ]))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(Icons.fingerprint_rounded),
                                      Text(
                                        "10",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ):Container(),

                              widget.wheel ?
                              Container(
                                  height: 100.h,
                                  width: 100.w,
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                        colors: [
                                          ColorManager.lightPrimary,
                                          Colors.white,
                                        ]),
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                    Border.all(color: ColorManager.accent, width: 2.0.w),
                                  ),
                                  child: ListWheelScrollView.useDelegate(
                                      onSelectedItemChanged: (value) {
                                        setState(() {
                                        });
                                      },
                                      perspective: 0.005,
                                      diameterRatio: 1.2,
                                      physics: FixedExtentScrollPhysics(),
                                      itemExtent: 40,
                                      childDelegate: ListWheelChildBuilderDelegate(
                                          childCount: 999,
                                          builder: (context, index) {
                                            return myCounter(index + 1);
                                          }))):Container(),

                              Row(
                                children: [
                                  Text(
                                    widget.time,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                  SizedBox(
                                    width: AppConstants.smallDistance,
                                  ),
                                  widget.timer ? const Icon(Icons.access_alarms_rounded, size: 15) : Container()
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: AppConstants.smallDistance,
                          ),
                          ReadMoreText(
                            widget.description,
                            style: TextStyle(
                                fontSize: 15.sp, color: ColorManager.darkBasicOverlay),
                            trimLines: 1,
                            colorClickableText: ColorManager.blueColor,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: AppStrings.readMore.tr(),
                            trimExpandedText: AppStrings.readLess.tr(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget myCounter(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorManager.darkbasic, width: 2.0.w),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8,0,0,0),
              child: Text(index.toString(),style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
            ),
            SvgPicture.asset(ImageAssets.scroll,
                color: ColorManager.basic, width: 25.w),
          ],
        ),
      ),
    );
  }
}

