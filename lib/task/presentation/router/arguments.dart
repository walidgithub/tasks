class TasksByCategoryArguments {
  String? category;
  int? countOfItems;
  String? tasksDate;
  String? tasksDay;

  TasksByCategoryArguments({
    this.category,
    this.countOfItems,
    this.tasksDate,
    this.tasksDay,
  });
}

class GoToTaskArguments {
  String? editType;
  int? id;

  GoToTaskArguments({
    this.editType,
    this.id,
  });
}

class DailyTasksArguments {
  int? id;
  String? taskName;
  String? description;
  String? time;
  int? timer;
  int? pinned;
  int? done;
  int? wheel;
  int? counter;
  int? counterVal;

  DailyTasksArguments({
    this.id,
    this.taskName,
    this.description,
    this.time,
    this.timer,
    this.pinned,
    this.done,
    this.counter,
    this.wheel,
    this.counterVal,
  });
}
