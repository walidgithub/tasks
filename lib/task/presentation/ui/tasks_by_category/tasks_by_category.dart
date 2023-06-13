import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasks/task/presentation/ui/daily_tasks/daily_tasks_cubit/daily_tasks_cubit.dart';
import 'package:tasks/task/presentation/ui/daily_tasks/daily_tasks_cubit/daily_tasks_state.dart';
import '../../../shared/constant/constant_values_manager.dart';
import '../../../shared/constant/strings_manager.dart';
import '../../../shared/style/colors_manager.dart';
import '../../di/di.dart';
import '../../router/app_router.dart';
import '../../router/arguments.dart';
import '../daily_tasks/daily_tasks.dart';

class TasksByCategory extends StatefulWidget {
  const TasksByCategory({Key? key, required this.arguments}) : super(key: key);

  final TasksByCategoryArguments arguments;

  @override
  State<TasksByCategory> createState() => _TasksByCategoryState();
}

class _TasksByCategoryState extends State<TasksByCategory> {
  final DailyTasksCubit _dailyTasksCubit = sl<DailyTasksCubit>();

  var loadedTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.darkPrimary,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(widget.arguments.category!.length > 8 &&
                        int.parse(widget.arguments.countOfItems.toString()) > 99
                    ? '${widget.arguments.category!.substring(0, 7)}..'
                    : widget.arguments.category!.length > 10
                        ? '${widget.arguments.category!.substring(0, 7)}..'
                        : widget.arguments.category!),
                Row(
                  children: [
                    Text(
                        int.parse(widget.arguments.countOfItems.toString()) > 99
                            ? '(+99'
                            : '(${widget.arguments.countOfItems}'),
                    SizedBox(
                      width: AppConstants.smallDistance,
                    ),
                    Text('${AppStrings.items.tr()})'),
                  ],
                )
              ],
            ),
          ),
          leading: Bounceable(
              duration: const Duration(milliseconds: 300),
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 200));
              },
              child: const Icon(Icons.keyboard_return)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(widget.arguments.tasksDate
                      .toString()
                      .split(" ")[0]
                      .substring(0, 10))),
            ),
          ],
        ),
        body: bodyContent(context));
  }

  Widget bodyContent(BuildContext context) {
    return BlocBuilder<DailyTasksCubit, DailyTasksState>(
      bloc: _dailyTasksCubit
        ..executeLoadingTasksByCategory(
            widget.arguments.category!, widget.arguments.tasksDate!),
      builder: (context, state) {
        if (state is LoadingDailyTasksState) {
          return const CircularProgressIndicator();
        } else if (state is LoadedDailyTasksState) {
          loadedTasks = _dailyTasksCubit.dailyTasks;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: loadedTasks.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          key: ValueKey(loadedTasks[index]),
                          startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            // dismissible: DismissiblePane(onDismissed: (){},),
                            children: [
                              SlidableAction(
                                  onPressed: (context) => () {},
                                  flex: 2,
                                  backgroundColor: ColorManager.lightPrimary,
                                  foregroundColor: ColorManager.basic,
                                  icon: Icons.check,
                                  label: 'Done'),
                              SlidableAction(
                                  onPressed: (context) => () {},
                                  backgroundColor: ColorManager.accent,
                                  foregroundColor: ColorManager.basic,
                                  icon: Icons.edit,
                                  label: 'Edit'),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            // dismissible: DismissiblePane(onDismissed: (){print('Delete');},),
                            children: [
                              SlidableAction(
                                  onPressed: (context) => () {},
                                  backgroundColor: ColorManager.accent2,
                                  foregroundColor: ColorManager.basic,
                                  icon: Icons.delete,
                                  label: 'Delete'),
                            ],
                          ),
                          closeOnScroll: false,
                          // child: Container(),
                          child: DailyTasks(
                            arguments: DailyTasksArguments(
                                id: loadedTasks[index]['id'],
                                wheel: loadedTasks[index]['wheel'],
                                nestedVal: loadedTasks[index]['nestedVal'],
                                nested: loadedTasks[index]['nested'],
                                counterVal: loadedTasks[index]['counterVal'],
                                counter: loadedTasks[index]['counter'],
                                description: loadedTasks[index]['description'],
                                taskName: loadedTasks[index]['taskName'],
                                time: loadedTasks[index]['time'],
                                timer: loadedTasks[index]['timer'],
                                done: loadedTasks[index]['done'],
                                pinned: loadedTasks[index]['pinned']),
                          ),
                        );
                      },
                    ))
              ],
            ),
          );
        } else if (state is ErrorLoadingDailyTasksState) {
          return Text(state.errorText);
        } else {
          return Container();
        }
      },
    );
  }
}
