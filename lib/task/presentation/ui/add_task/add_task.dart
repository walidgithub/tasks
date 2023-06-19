import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasks/task/presentation/router/arguments.dart';
import 'package:tasks/task/shared/preferences/dbHelper.dart';
import '../../../domain/entities/daily_task_model.dart';
import '../../../domain/entities/task_days_model.dart';
import '../../../shared/constant/assets_manager.dart';
import '../../../shared/constant/constant_values_manager.dart';
import '../../../shared/constant/strings_manager.dart';
import '../../../shared/style/colors_manager.dart';

import 'package:table_calendar/table_calendar.dart';
import 'add_task_cubit/add_task_cubit.dart';
import 'add_task_cubit/add_task_state.dart';

class AddTask extends StatefulWidget {
  GoToTaskArguments arguments;

  AddTask({super.key, required this.arguments});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var oldTask;

  @override
  void initState() {
    if (widget.arguments.editType == 'Edit') {
      AddTaskCubit.get(context).loadTaskById(widget.arguments.id!);
    }
    super.initState();
  }

  var _selectedTask;
  var _selectedCategory;

  final FocusNode _taskFN = FocusNode();
  final FocusNode _descriptionFN = FocusNode();
  final FocusNode _categoryFN = FocusNode();

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

  Set<String>? tasksItemsScreen;
  Set<String>? categories;

  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  List taskDaysList = [
    {
      'nameOfDay': 'Sun',
      'checkedDay': false,
    },
    {
      'nameOfDay': 'Mon',
      'checkedDay': false,
    },
    {
      'nameOfDay': 'Tue',
      'checkedDay': false,
    },
    {
      'nameOfDay': 'Wed',
      'checkedDay': false,
    },
    {
      'nameOfDay': 'Thu',
      'checkedDay': false,
    },
    {
      'nameOfDay': 'Fri',
      'checkedDay': false,
    },
    {
      'nameOfDay': 'Sat',
      'checkedDay': false,
    },
  ];

  bool _addNewCategory = true;

  void _changeToAddNewCategory(value) {
    setState(() {
      _addNewCategory = value;
    });
  }

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

  Future<void> _changeToNested(value) async {
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
            children: [
              widget.arguments.editType == 'Edit'
                  ? Text(AppStrings.update.tr())
                  : Text(AppStrings.create.tr()),
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
                  widget.arguments.editType == 'Add'
                      ? Container()
                      : Row(
                          children: [
                            Bounceable(
                                duration: const Duration(milliseconds: 300),
                                onTap: () async {
                                  await Future.delayed(
                                      const Duration(milliseconds: 200));

                                  await AddTaskCubit.get(context)
                                      .deleteTask(widget.arguments.id!);
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

                        if (_taskNameEditingController.text == '') {
                          final snackBar = SnackBar(
                            content: Text(AppStrings.taskAlert.tr()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }

                        if (_descriptionEditingController.text == '') {
                          final snackBar = SnackBar(
                            content: Text(AppStrings.descriptionAlert.tr()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }

                        if (_categoryEditingController.text == '' &&
                            _addNewCategory == false) {
                          final snackBar = SnackBar(
                            content: Text(AppStrings.categoryAlert.tr()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        } else if (_selectedCategory == '' &&
                            _addNewCategory == false) {
                          final snackBar = SnackBar(
                            content: Text(AppStrings.categoryAlert.tr()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }

                        // --------------------------------------------------------------------------
                        if (_pinned) {
                          int checkedDaysCount = 0;
                          for (var selectedDay in taskDaysList) {
                            if (selectedDay['checkedDay'] == false) {
                              checkedDaysCount++;
                            }
                          }
                          if (checkedDaysCount == 7){
                            _pinned = false;
                          }
                        }

                          // -------------------------------------------------------------------------

                        if (_pinned) {
                          // add new pinned task
                          DailyTaskModel dailyModel = DailyTaskModel(
                              id: widget.arguments.editType! == 'Edit'
                                  ? widget.arguments.id
                                  : null,
                              category: _addNewCategory
                                  ? _selectedCategory
                                  : _categoryEditingController.text,
                              date: DateTime.parse(
                                  today.toString().split(" ")[0]),
                              pinned: 1,
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

                          if (widget.arguments.editType! == 'Edit') {
                            await AddTaskCubit.get(context)
                                .updateTask(dailyModel, widget.arguments.id!);
                          } else if (widget.arguments.editType! == 'Add') {
                            await AddTaskCubit.get(context)
                                .addNewTask(dailyModel);
                          }

                          if (widget.arguments.editType! == 'Edit') {
                            // delete before adding
                            await AddTaskCubit.get(context)
                                .deleteTaskDays(widget.arguments.id!);

                            for (var selectedDay in taskDaysList) {
                              if (selectedDay['checkedDay']) {
                                // add task day
                                TaskDaysModel taskDays = TaskDaysModel(
                                    nameOfDay: selectedDay['nameOfDay'],
                                    checkedDay:
                                        selectedDay['checkedDay'] ? 1 : 0,
                                    mainTaskId: widget.arguments.id);

                                await AddTaskCubit.get(context)
                                    .addTaskDay(taskDays);
                              }
                            }
                          } else if (widget.arguments.editType! == 'Add') {
                            for (var selectedDay in taskDaysList) {
                              if (selectedDay['checkedDay']) {
                                // add task day
                                TaskDaysModel taskDays = TaskDaysModel(
                                    nameOfDay: selectedDay['nameOfDay'],
                                    checkedDay:
                                        selectedDay['checkedDay'] ? 1 : 0,
                                    mainTaskId: DbHelper.insertedNewTaskId);

                                await AddTaskCubit.get(context)
                                    .addTaskDay(taskDays);
                              }
                            }
                          }
                        } else {
                          // DateTime now = DateTime.now();
                          // String formattedDate = DateFormat('dd-MM-yyyy').format(now);

                          // add new task
                          DailyTaskModel dailyModel = DailyTaskModel(
                              id: widget.arguments.editType! == 'Edit'
                                  ? widget.arguments.id
                                  : null,
                              category: _addNewCategory
                                  ? _selectedCategory
                                  : _categoryEditingController.text,
                              date: DateTime.parse(
                                  today.toString().split(" ")[0]),
                              pinned: 0,
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
                          if (widget.arguments.editType! == 'Edit') {
                            await AddTaskCubit.get(context)
                                .deleteTaskDays(widget.arguments.id!);

                            await AddTaskCubit.get(context)
                                .updateTask(dailyModel, widget.arguments.id!);
                          } else if (widget.arguments.editType! == 'Add') {
                            await AddTaskCubit.get(context)
                                .addNewTask(dailyModel);
                          }
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
    return BlocConsumer<AddTaskCubit, AddTaskState>(
      listener: (context, state) {
        // loading Tasks Names -----------------------------------------------------
        if (state is LoadingTasksNamesState) {
        } else if (state is ErrorLoadingTasksNamesState) {
        } else if (state is LoadedTasksNamesState) {
          tasksItemsScreen = AddTaskCubit.get(context).tasksNames;

          // loading Categories -----------------------------------------------------
        } else if (state is LoadingCategoriesState) {
        } else if (state is ErrorLoadingCategoriesState) {
        } else if (state is LoadedCategoriesState) {
          categories = AddTaskCubit.get(context).categories;

          // New Task -----------------------------------------------------
        } else if (state is NewTaskSavedState) {
          final snackBar = SnackBar(
            content: Text(AppStrings.successfullySaved.tr()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is AddTaskErrorState) {
          // Update Task -----------------------------------------------------
        } else if (state is UpdateTaskState) {
          final snackBar = SnackBar(
            content: Text(AppStrings.successfullyUpdated.tr()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is ErrorUpdateTaskState) {
          // Delete Task -----------------------------------------------------
        } else if (state is DeleteTaskState) {
          final snackBar = SnackBar(
            content: Text(AppStrings.successfullyDeleted.tr()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (state is ErrorDeleteTaskState) {
          // Show Task -----------------------------------------------------
        } else if (state is LoadingPrevTask) {
        } else if (state is LoadedPrevTask) {
          oldTask = state.taskData.toMap();

          getData(oldTask);
        } else if (state is ErrorLoadingPrevTask) {
          // Show Task Days -----------------------------------------------------
        } else if (state is LoadingPrevTaskDay) {
        } else if (state is LoadedPrevTaskDay) {
          for (var v in state.taskDayData) {
            fillDays(v.toMap());
          }
        } else if (state is ErrorLoadingPrevTaskDay) {}
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                TextField(
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_descriptionFN);
                    },
                    maxLength: 15,
                    autofocus: true,
                    focusNode: _taskFN,
                    keyboardType: TextInputType.text,
                    controller: _taskNameEditingController,
                    decoration: InputDecoration(
                        hintText: AppStrings.taskName.tr(),
                        border: InputBorder.none)),
                SizedBox(
                  height: AppConstants.heightBetweenElements,
                ),
                TextField(
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_categoryFN);
                    },
                    maxLength: 50,
                    focusNode: _descriptionFN,
                    keyboardType: TextInputType.text,
                    controller: _descriptionEditingController,
                    decoration: InputDecoration(
                        hintText: AppStrings.description.tr(),
                        border: InputBorder.none)),
                SizedBox(
                  height: AppConstants.heightBetweenElements,
                ),
                _addNewCategory
                    ? Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width -
                                  (AppConstants.smallDistance + 50.w + 18),
                              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager.lightPrimary,
                                      width: 1.5.w),
                                  borderRadius: BorderRadius.circular(20)),
                              child: DropdownButton(
                                borderRadius: BorderRadius.circular(10),
                                itemHeight: 60.h,
                                underline: Container(),
                                items: categories?.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (selectedCategory) {
                                  setState(() {
                                    _selectedCategory = selectedCategory!;
                                  });
                                },
                                value: _selectedCategory,
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Text(
                                      AppStrings.chooseCategory.tr(),
                                      style: TextStyle(
                                          color: ColorManager.primary,
                                          fontSize: 18),
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
                          SizedBox(
                            width: AppConstants.smallDistance,
                          ),
                          Bounceable(
                            duration: const Duration(milliseconds: 300),
                            onTap: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 200));
                              bool value = !_addNewCategory;
                              _changeToAddNewCategory(value);
                            },
                            child: Container(
                              height: 50.h,
                              width: 50.w,
                              padding: const EdgeInsets.all(0.8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: ColorManager.lightPrimary,
                                      width: 1.5.w)),
                              child: SvgPicture.asset(ImageAssets.addNew,
                                  color: ColorManager.darkPrimary, width: 20.w),
                            ),
                          )
                        ],
                      )
                    : Row(children: [
                        Expanded(
                          child: TextField(
                              maxLength: 15,
                              focusNode: _categoryFN,
                              keyboardType: TextInputType.text,
                              controller: _categoryEditingController,
                              decoration: InputDecoration(
                                  hintText: AppStrings.category.tr(),
                                  border: InputBorder.none)),
                        ),
                        SizedBox(
                          width: AppConstants.smallDistance,
                        ),
                        Bounceable(
                          duration: const Duration(milliseconds: 300),
                          onTap: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            bool value = !_addNewCategory;
                            _changeToAddNewCategory(value);
                          },
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.all(0.8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: ColorManager.lightPrimary,
                                    width: 1.5.w)),
                            child: SvgPicture.asset(ImageAssets.reload,
                                color: ColorManager.darkPrimary, width: 10.w),
                          ),
                        )
                      ]),
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
                                itemHeight: 60.h,
                                underline: Container(),
                                items: tasksItemsScreen?.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (selectedTask) {
                                  setState(() {
                                    _selectedTask = selectedTask!;
                                  });
                                },
                                value: _selectedTask,
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Text(
                                      AppStrings.chooseParentTask.tr(),
                                      style: TextStyle(
                                          color: ColorManager.primary,
                                          fontSize: 18),
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
    );
  }

  Widget days(int index) {
    return Column(
      children: [
        Text(
          taskDaysList[index]['nameOfDay'],
          style: TextStyle(color: ColorManager.darkPrimary, fontSize: 18.sp),
        ),
        Checkbox(
          value: taskDaysList[index]['checkedDay'],
          activeColor: ColorManager.darkPrimary,
          onChanged: (value) {
            setState(() {
              taskDaysList[index]['checkedDay'] = value;
            });
          },
        )
      ],
    );
  }

  List fillDays(var daysMap) {
    for (int index = 0; index < taskDaysList.length; index++) {
      if (taskDaysList[index]['nameOfDay'] == daysMap['nameOfDay']) {
        taskDaysList[index]['checkedDay'] = true;
      }
    }
    return taskDaysList;
  }

  void getData(var oldTask) {
    _taskNameEditingController.text = oldTask['taskName'];
    _descriptionEditingController.text = oldTask['description'];
    _selectedCategory = oldTask['category'];

    oldTask['timer'] == 1 ? _timer = true : _timer = false;
    // oldTask['timer'] == 1
    //     ? _timeOfDay = oldTask['time']
    //     : _timeOfDay = TimeOfDay.now();

    oldTask['specificDate'] == 1 ? _specificDate = true : _specificDate = false;
    oldTask['specificDate'] == 1
        ? today = oldTask['date']
        : today = DateTime.now();

    oldTask['pinned'] == 1 ? _pinned = true : _pinned = false;

    oldTask['nested'] == 1 ? _nested = true : _nested = false;
    // if nested get the name by id

    oldTask['counter'] == 1 ? _counter = true : _counter = false;
    oldTask['counter'] == 1
        ? _counterValue = oldTask['counterVal']
        : _counterValue = 0;


    oldTask['wheel'] == 1 ? _wheel = true : _wheel = false;
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
