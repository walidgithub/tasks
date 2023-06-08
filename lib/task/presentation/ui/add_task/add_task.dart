import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasks/task/shared/preferences/dbHelper.dart';
import '../../../domain/entities/daily_task_model.dart';
import '../../../domain/entities/task_days_model.dart';
import '../../../shared/constant/assets_manager.dart';
import '../../../shared/constant/constant_values_manager.dart';
import '../../../shared/constant/strings_manager.dart';
import '../../../shared/style/colors_manager.dart';

import 'package:table_calendar/table_calendar.dart';

import '../../di/di.dart';
import 'cubit/add_task_cubit.dart';
import 'cubit/add_task_state.dart';

class AddTask extends StatefulWidget {
  String? editType;

  AddTask({super.key, this.editType});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var _selectedTask;

  int? _counterValue = 0;

  final scrollController = ScrollController();

  final TextEditingController _taskNameEditingController =
      TextEditingController();

  final TextEditingController _descriptionEditingController =
      TextEditingController();

  final TextEditingController _categoryEditingController =
      TextEditingController();

  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  List<DropdownMenuItem<String>>? tasksItems;

  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  List allDays = [
    {
      'dayName': 'Sun',
      'checkValue': false,
    },
    {
      'dayName': 'Mon',
      'checkValue': false,
    },
    {
      'dayName': 'Tue',
      'checkValue': false,
    },
    {
      'dayName': 'Wed',
      'checkValue': false,
    },
    {
      'dayName': 'Thu',
      'checkValue': false,
    },
    {
      'dayName': 'Fri',
      'checkValue': false,
    },
    {
      'dayName': 'Sat',
      'checkValue': false,
    },
  ];

  bool _timer = false;

  void _changeToTimer(value) {
    setState(() {
      _timer = value;
    });
  }

  bool _specificDate = false;

  void _changeToSpecificDate(value) {
    setState(() {
      _specificDate = value;
      if (_specificDate) {
        _pinned = false;
        scrollController.animateTo(
            scrollController.position.maxScrollExtent + 120,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear);
      }
    });
  }

  bool _pinned = false;

  void _changeToPinned(value) {
    setState(() {
      _pinned = value;
      if (_pinned) {
        _specificDate = false;
        scrollController.animateTo(
            scrollController.position.maxScrollExtent + 120,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear);
      }
    });
  }

  bool _nested = false;

  void _changeToNested(value) {
    setState(() {
      _nested = value;
      if (_nested) {
        _counter = false;
        _wheel = false;
        scrollController.animateTo(
            scrollController.position.maxScrollExtent + 120,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear);
      }
    });
  }

  bool _counter = false;

  void _changeToCounter(value) {
    setState(() {
      _counter = value;
      if (_counter) {
        _nested = false;
        _wheel = false;
        scrollController.animateTo(
            scrollController.position.maxScrollExtent + 120,
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear);
      }
    });
  }

  bool _wheel = false;

  void _changeToWheel(value) {
    setState(() {
      _wheel = value;
      if (_counter) {
        _nested = false;
        _counter = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.darkPrimary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppStrings.create.tr()),
            ],
          ),
          leading: Bounceable(
              duration: const Duration(milliseconds: 300),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 200));
              },
              child: const Icon(Icons.keyboard_return)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                children: [
                  widget.editType == 'Edit'
                      ? Container()
                      : Row(
                          children: [
                            Bounceable(
                                duration: const Duration(milliseconds: 300),
                                onTap: () async {
                                  await Future.delayed(
                                      const Duration(milliseconds: 200));
                                },
                                child: const Icon(Icons.delete)),
                            SizedBox(
                              width: AppConstants.widthBetweenElements,
                            ),
                          ],
                        ),
                  Bounceable(
                      duration: const Duration(milliseconds: 300),
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 200));

                        // --------------------------------------------------------------------------

                        if (_pinned) {
                          // add new pinned task
                          DailyTaskModel dailyModel = DailyTaskModel(
                              category: _categoryEditingController.text,
                              date: DateTime.parse(
                                  today.toString().split(" ")[0]),
                              pinned: _pinned ? 1 : 0,
                              done: 0,
                              timer: _timer ? 1 : 0,
                              taskName: _taskNameEditingController.text,
                              description: _descriptionEditingController.text,
                              counter: _counter ? 1 : 0,
                              time: _timeOfDay.format(context).toString(),
                              counterVal: _counterValue,
                              nested: _nested ? 1 : 0,
                              nestedVal: 0,
                              specificDate: _specificDate ? 1 : 0,
                              wheel: _wheel ? 1 : 0);

                          await AddTaskCubit.get(context)
                              .addNewTask(dailyModel);

                          for (var selectedDay in allDays) {
                            if (selectedDay['checkValue']) {
                              // add task day
                              TaskDaysModel taskDays = TaskDaysModel(
                                  nameOfDay: selectedDay['dayName'],
                                  checkedDay: selectedDay['checkValue'] ? 1 : 0,
                                  mainTaskId: DbHelper.insertedNewTaskId);

                              await AddTaskCubit.get(context)
                                  .addTaskDay(taskDays);
                            }
                          }
                        } else {
                          // DateTime now = DateTime.now();
                          // String formattedDate = DateFormat('dd-MM-yyyy').format(now);

                          // add new task
                          DailyTaskModel dailyModel = DailyTaskModel(
                              category: _categoryEditingController.text,
                              date: DateTime.parse(
                                  today.toString().split(" ")[0]),
                              pinned: _pinned ? 1 : 0,
                              done: 0,
                              timer: _timer ? 1 : 0,
                              taskName: _taskNameEditingController.text,
                              description: _descriptionEditingController.text,
                              counter: _counter ? 1 : 0,
                              time: _timeOfDay.format(context).toString(),
                              counterVal: _counterValue,
                              nested: _nested ? 1 : 0,
                              nestedVal: 0,
                              specificDate: _specificDate ? 1 : 0,
                              wheel: _wheel ? 1 : 0);

                          await AddTaskCubit.get(context)
                              .addNewTask(dailyModel);

                          print('done');
                        }

                        // --------------------------------------------------------------------------
                      },
                      child: const Icon(Icons.done))
                ],
              ),
            )
          ],
        ),
        body: bodyContent());
  }

  Widget bodyContent() {
    return BlocProvider(
  create: (context) => sl<AddTaskCubit>(),
  child: BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        if (state is LoadingTasksState) {

          AddTaskCubit.get(context).getTasksNames();

        } else if (state is LoadedTasksState) {

          tasksItems = AddTaskCubit.get(context)
              .tasksNames
              .map((value) =>
              DropdownMenuItem<String>(value: value, child: Text(value)))
              .toList();

          if (kDebugMode) {
            print('tasksItems $tasksItems');
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                TextField(
                    onSubmitted: (_) {},
                    keyboardType: TextInputType.text,
                    controller: _taskNameEditingController,
                    decoration: InputDecoration(
                        hintText: AppStrings.taskName.tr(),
                        border: InputBorder.none)),
                SizedBox(
                  height: AppConstants.heightBetweenElements,
                ),
                TextField(
                    onSubmitted: (_) {},
                    keyboardType: TextInputType.text,
                    controller: _descriptionEditingController,
                    decoration: InputDecoration(
                        hintText: AppStrings.description.tr(),
                        border: InputBorder.none)),
                SizedBox(
                  height: AppConstants.heightBetweenElements,
                ),
                TextField(
                    onSubmitted: (_) {},
                    keyboardType: TextInputType.text,
                    controller: _categoryEditingController,
                    decoration: InputDecoration(
                        hintText: AppStrings.category.tr(),
                        border: InputBorder.none)),
                SizedBox(
                  height: AppConstants.heightBetweenElements,
                ),
                SwitchListTile(
                  title: Text(AppStrings.specificDate.tr(),
                      style: TextStyle(
                          color: ColorManager.darkPrimary, fontSize: 20.sp)),
                  activeTrackColor: ColorManager.lightPrimary,
                  activeColor: ColorManager.darkPrimary,
                  secondary: const Icon(Icons.date_range_outlined),
                  value: _specificDate,
                  onChanged: (value) {
                    _changeToSpecificDate(value);
                  },
                ),
                _specificDate
                    ? Column(
                        children: [
                          TableCalendar(
                            locale: "en_US",
                            rowHeight: 43.h,
                            headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true),
                            availableGestures:
                                AvailableGestures.horizontalSwipe,
                            selectedDayPredicate: (day) =>
                                isSameDay(day, today),
                            focusedDay: today,
                            calendarStyle: CalendarStyle(
                                selectedDecoration: BoxDecoration(
                                    color: ColorManager.darkPrimary,
                                    shape: BoxShape.circle),
                                todayDecoration: BoxDecoration(
                                    color: ColorManager.lightPrimary,
                                    shape: BoxShape.circle)),
                            firstDay: DateTime.utc(2023, 05, 01),
                            lastDay: DateTime.utc(2030, 3, 14),
                            onDaySelected: _onDaySelected,
                          ),
                          SizedBox(
                            height: AppConstants.heightBetweenElements,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(AppStrings.date.tr(),
                                  style: TextStyle(
                                      color: ColorManager.lightPrimary,
                                      fontSize: 20.sp)),
                              SizedBox(
                                width: AppConstants.widthBetweenElements,
                              ),
                              Text(today.toString().split(" ")[0],
                                  style: TextStyle(
                                      color: ColorManager.darkPrimary,
                                      fontSize: 20.sp)),
                            ],
                          ),
                          Divider(
                            color: ColorManager.darkPrimary,
                            thickness: 1,
                          )
                        ],
                      )
                    : Container(),
                SwitchListTile(
                  title: Text(
                    AppStrings.withTimer.tr(),
                    style: TextStyle(
                        color: ColorManager.darkPrimary, fontSize: 20.sp),
                  ),
                  secondary: const Icon(Icons.access_alarms_rounded),
                  value: _timer,
                  activeTrackColor: ColorManager.lightPrimary,
                  activeColor: ColorManager.darkPrimary,
                  onChanged: (value) {
                    _changeToTimer(value);
                  },
                ),
                _timer
                    ? Column(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                _showTimePicker();
                              },
                              child: Text(AppStrings.changeTime.tr(),
                                  style: TextStyle(
                                      color: ColorManager.darkPrimary,
                                      fontSize: 20.sp))),
                          SizedBox(
                            height: AppConstants.heightBetweenElements,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(AppStrings.time.tr(),
                                  style: TextStyle(
                                      color: ColorManager.lightPrimary,
                                      fontSize: 20.sp)),
                              SizedBox(
                                width: AppConstants.widthBetweenElements,
                              ),
                              //TimeOfDay.fromDateTime(DateFormat.jm().parse(map["time"]))
                              Text(_timeOfDay.format(context).toString(),
                                  style: TextStyle(
                                      color: ColorManager.darkPrimary,
                                      fontSize: 20.sp)),
                            ],
                          ),
                          Divider(
                            color: ColorManager.darkPrimary,
                            thickness: 1,
                          )
                        ],
                      )
                    : Container(),
                SwitchListTile(
                  title: Text(AppStrings.pinnedTask.tr(),
                      style: TextStyle(
                          color: ColorManager.darkPrimary, fontSize: 20.sp)),
                  activeTrackColor: ColorManager.lightPrimary,
                  activeColor: ColorManager.darkPrimary,
                  secondary: SvgPicture.asset(ImageAssets.pin_icon,
                      color: ColorManager.grey, width: 25.w),
                  value: _pinned,
                  onChanged: (value) {
                    _changeToPinned(value);
                  },
                ),
                _pinned
                    ? Column(
                        children: [
                          SizedBox(
                            height: AppConstants.heightBetweenElements,
                          ),
                          Container(
                            width: double.infinity,
                            height: 70.h,
                            margin: const EdgeInsets.only(right: 5),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 7,
                              itemBuilder: (BuildContext context, int index) {
                                return days(index);
                              },
                            ),
                          ),
                          Divider(
                            color: ColorManager.darkPrimary,
                            thickness: 1,
                          )
                        ],
                      )
                    : Container(),
                SwitchListTile(
                  title: Text(AppStrings.nestedTask.tr(),
                      style: TextStyle(
                          color: ColorManager.darkPrimary, fontSize: 20.sp)),
                  activeTrackColor: ColorManager.lightPrimary,
                  activeColor: ColorManager.darkPrimary,
                  secondary: const Icon(Icons.arrow_circle_right_outlined),
                  value: _nested,
                  onChanged: (value) {
                    _changeToNested(value);
                  },
                ),
                _nested
                    ? Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager.lightPrimary,
                                      width: 1.5.w),
                                  borderRadius: BorderRadius.circular(20)),
                              child: DropdownButton(
                                borderRadius: BorderRadius.circular(10),
                                itemHeight: 65.h,
                                underline: Container(),
                                items: tasksItems
                                    ?.map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            'hhhhhhhh',
                                            style: TextStyle(
                                                color: ColorManager.darkPrimary),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (selectedAccountType) {
                                  setState(() {
                                    _selectedTask = selectedAccountType;
                                  });
                                },
                                value: _selectedTask,
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Text(
                                      AppStrings.chooseParentTask.tr(),
                                      style: TextStyle(
                                          color: ColorManager.primary),
                                    ),
                                    SizedBox(
                                      width: AppConstants.smallDistance,
                                    )
                                  ],
                                ),
                                icon: Icon(
                                  Icons.arrow_drop_down_circle_outlined,
                                  color: ColorManager.primary,
                                ),
                                style: TextStyle(
                                    color: ColorManager.darkPrimary,
                                    fontSize: 20.sp),
                              )),
                          Divider(
                            color: ColorManager.darkPrimary,
                            thickness: 1,
                          )
                        ],
                      )
                    : Container(),
                SwitchListTile(
                  title: Text(AppStrings.withCounter.tr(),
                      style: TextStyle(
                          color: ColorManager.darkPrimary, fontSize: 20.sp)),
                  activeTrackColor: ColorManager.lightPrimary,
                  activeColor: ColorManager.darkPrimary,
                  secondary: const Icon(Icons.fingerprint_rounded),
                  value: _counter,
                  onChanged: (value) {
                    _changeToCounter(value);
                  },
                ),
                _counter
                    ? Container(
                        height: 100.h,
                        width: 80.w,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: ColorManager.accent, width: 2.0.w),
                        ),
                        child: ListWheelScrollView.useDelegate(
                            onSelectedItemChanged: (value) {
                              setState(() {
                                _counterValue = value + 1;
                              });
                            },
                            perspective: 0.005,
                            diameterRatio: 1.2,
                            physics: const FixedExtentScrollPhysics(),
                            itemExtent: 30,
                            childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 100,
                                builder: (context, index) {
                                  return myCounter(index + 1);
                                })))
                    : Container(),
                SwitchListTile(
                  title: Text(
                    AppStrings.sebha.tr(),
                    style: TextStyle(
                        color: ColorManager.darkPrimary, fontSize: 20.sp),
                  ),
                  secondary: SvgPicture.asset(ImageAssets.scroll,
                      color: ColorManager.grey, width: 25.w),
                  value: _wheel,
                  activeTrackColor: ColorManager.lightPrimary,
                  activeColor: ColorManager.darkPrimary,
                  onChanged: (value) {
                    _changeToWheel(value);
                  },
                ),
              ],
            ),
          ),
        );
      },
    ),
);
  }

  // Widget days(String dayName, bool checkValue, int index) {
  Widget days(int index) {
    return Column(
      children: [
        Text(
          allDays[index]['dayName'],
          style: TextStyle(color: ColorManager.darkPrimary, fontSize: 18.sp),
        ),
        Checkbox(
          value: allDays[index]['checkValue'],
          activeColor: ColorManager.darkPrimary,
          onChanged: (value) {
            setState(() {
              allDays[index]['checkValue'] = value;
            });
          },
        )
      ],
    );
  }

  Widget myCounter(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorManager.darkPrimary, width: 2.0.w),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(index.toString()),
            SvgPicture.asset(ImageAssets.scroll,
                color: ColorManager.darkPrimary, width: 25.w),
          ],
        ),
      ),
    );
  }
}
