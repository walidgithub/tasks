import 'package:countup/countup.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:tasks/task/domain/entities/daily_task_model.dart';

import '../../../shared/constant/assets_manager.dart';
import '../../../shared/constant/constant_values_manager.dart';
import '../../../shared/constant/strings_manager.dart';
import '../../../shared/style/colors_manager.dart';
import '../../di/di.dart';
import '../../router/arguments.dart';
import 'daily_tasks_cubit/daily_tasks_cubit.dart';
import 'daily_tasks_cubit/daily_tasks_state.dart';

class DailyTasks extends StatefulWidget {
  final DailyTasksArguments arguments;

  const DailyTasks({super.key, required this.arguments});

  @override
  State<DailyTasks> createState() => _DailyTasksState();
}

class _DailyTasksState extends State<DailyTasks> {

  double checkDouble(dynamic value) {
    return 1 / value;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DailyTasksCubit>(),
      child: BlocConsumer<DailyTasksCubit, DailyTasksState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: Column(
              children: [
                Container(
                  // height: 75,
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
                    decoration: (BoxDecoration(
                        color: Colors.white,
                        border:
                        Border.all(width: 2.w, color: ColorManager.accent),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          widget.arguments.taskName!,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 18.sp),
                                        ),
                                        widget.arguments.done == 1
                                            ? Icon(
                                          Icons.done,
                                          color: ColorManager.blueColor,
                                        )
                                            : Container(),
                                      ],
                                    ),
                                    widget.arguments.counter == 1
                                        ? Bounceable(
                                      duration:
                                      const Duration(milliseconds: 100),
                                      onTap: () async {
                                        await Future.delayed(const Duration(
                                            milliseconds: 100));
                                      },
                                      child: Container(
                                        width: 70.w,
                                        height: 40.h,
                                        decoration: (BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 2.w,
                                                color: ColorManager.accent),
                                            borderRadius:
                                            BorderRadius.circular(40),
                                            gradient: LinearGradient(
                                                begin:
                                                Alignment.centerRight,
                                                end: Alignment.centerLeft,
                                                colors: [
                                                  Colors.white,
                                                  ColorManager.lightPrimary,
                                                ]))),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const Icon(
                                                Icons.fingerprint_rounded),
                                            Text(
                                              widget.arguments.counterVal
                                                  .toString(),
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),
                                    widget.arguments.wheel == 1
                                        ? Container(
                                        height: 100.h,
                                        width: 100.w,
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 10),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.centerRight,
                                              end: Alignment.centerLeft,
                                              colors: [
                                                ColorManager.lightPrimary,
                                                Colors.white,
                                              ]),
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                              color: ColorManager.accent,
                                              width: 2.0.w),
                                        ),
                                        child:
                                        ListWheelScrollView.useDelegate(
                                            onSelectedItemChanged:
                                                (value) {
                                              setState(() {});
                                            },
                                            perspective: 0.005,
                                            diameterRatio: 1.2,
                                            physics:
                                            const FixedExtentScrollPhysics(),
                                            itemExtent: 40,
                                            childDelegate:
                                            ListWheelChildBuilderDelegate(
                                                childCount: 999,
                                                builder:
                                                    (context, index) {
                                                  return myCounter(
                                                      index + 1);
                                                })))
                                        : Container(),
                                    Row(
                                      children: [
                                        Text(
                                          widget.arguments.time!,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        SizedBox(
                                          width: AppConstants.smallDistance,
                                        ),
                                        widget.arguments.timer == 1
                                            ? const Icon(
                                            Icons.access_alarms_rounded,
                                            size: 15)
                                            : Container()
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: AppConstants.smallDistance,
                                ),
                                ReadMoreText(
                                  widget.arguments.description!,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: ColorManager.darkBasicOverlay),
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
        },
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
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Text(
                index.toString(),
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            SvgPicture.asset(ImageAssets.scroll,
                color: ColorManager.basic, width: 25.w),
          ],
        ),
      ),
    );
  }
}
