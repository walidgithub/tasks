import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../shared/constant/constant_values_manager.dart';
import '../../../shared/constant/strings_manager.dart';
import '../../../shared/style/colors_manager.dart';
import '../daily_tasks/daily_tasks.dart';

class TasksByCategory extends StatefulWidget {
  const TasksByCategory({Key? key}) : super(key: key);

  @override
  State<TasksByCategory> createState() => _TasksByCategoryState();
}

class _TasksByCategoryState extends State<TasksByCategory> {

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.darkPrimary,
          title:
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Relegion'),
                Row(
                  children: [
                    Text('(10'),
                    SizedBox(
                      width: AppConstants.smallDistance,
                    ),
                    Text('${AppStrings.items.tr()})'),
                  ],
                )
              ],
            ),
          ),
          leading:
          Bounceable(
              duration: const Duration(milliseconds: 300),
              onTap:() async {
                await Future.delayed(Duration(milliseconds: 200));
              },
              child: const Icon(Icons.keyboard_return)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(today.toString().split(" ")[0])),
            ),
          ],
        ),
        body: bodyContent()
    );
  }

  Widget bodyContent(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(5,10,5,10),
              child:
              ListView.builder(
                scrollDirection: Axis.vertical,
                // itemCount: taskslist.length,
                itemCount: 1,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Slidable(
                    // key: ValueKey(taskslist[index]),
                    key: ValueKey(1),
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
                    child: Container(),
                    // child: DailyTasks(
                    //   address: taskslist[index].taskName,
                    //   description: taskslist[index].description,
                    //   time: taskslist[index].time,
                    //   timer: taskslist[index].timer,
                    //   pinned: taskslist[index].pinned,
                    //   counter: taskslist[index].counter,
                    //   nested: taskslist[index].nested,
                    //   wheel: taskslist[index].wheel,
                    //   nestedVal: taskslist[index].nestedVal,
                    //   counterVal: taskslist[index].counterVal,
                    //   done: taskslist[index].done,
                    // ),
                  );
                },
              )

          )
        ],
      ),
    );
  }
}
