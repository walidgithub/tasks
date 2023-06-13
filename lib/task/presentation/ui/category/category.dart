import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tasks/task/presentation/ui/homepage/home_cubit/home_cubit.dart';
import 'package:tasks/task/presentation/ui/homepage/home_cubit/home_state.dart';

import '../../../shared/constant/constant_values_manager.dart';
import '../../../shared/style/colors_manager.dart';
import '../../router/app_router.dart';
import '../../router/arguments.dart';

class Category extends StatefulWidget {
  final String name;
  final double percent;
  final int itemsCount;
  final String tasksDate;

  const Category(
      {super.key,
      required this.name,
      required this.percent,
      required this.itemsCount,
      required this.tasksDate});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Bounceable(
          duration: const Duration(milliseconds: 100),
          onTap: () async {
            await Future.delayed(const Duration(milliseconds: 150));
            // category info
            Navigator.of(context).pushReplacementNamed(Routes.tasksByCategory,
                arguments: TasksByCategoryArguments(
                    category: widget.name,
                    countOfItems: widget.itemsCount,
                    tasksDate: widget.tasksDate));

            // load tasks by category and date

          },
          child: Container(
              margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                    Text((widget.name),
                        style: TextStyle(
                            fontSize: 20.sp, color: ColorManager.darkbasic)),
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
                            duration: const Duration(seconds: 5),
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                          Text(
                            '%',
                            style: TextStyle(fontSize: 10.sp),
                          )
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
      },
    );
  }
}
