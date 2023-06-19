import '../../../../domain/entities/daily_task_model.dart';
import '../../../../domain/entities/task_days_model.dart';

abstract class AddTaskState{}

class AddTaskInitial extends AddTaskState{}

// ---------------------------------------------------------
class LoadingPrevTask extends AddTaskState{}
class LoadedPrevTask extends AddTaskState{
  DailyTaskModel taskData;

  LoadedPrevTask(this.taskData);
}
class ErrorLoadingPrevTask extends AddTaskState{
  String errorText;

  ErrorLoadingPrevTask(this.errorText);
}

// ---------------------------------------------------------
class LoadingPrevTaskDay extends AddTaskState{}
class LoadedPrevTaskDay extends AddTaskState{
  List<TaskDaysModel> taskDayData;

  LoadedPrevTaskDay(this.taskDayData);
}
class ErrorLoadingPrevTaskDay extends AddTaskState{
  String errorText;

  ErrorLoadingPrevTaskDay(this.errorText);
}

// ---------------------------------------------------------
class NewTaskSavedState extends AddTaskState{}
class AddTaskErrorState extends AddTaskState{
  String errorText;

  AddTaskErrorState(this.errorText);
}

// ---------------------------------------------------------
class NewTaskDaySavedState extends AddTaskState{}
class AddTaskDayErrorState extends AddTaskState{
  String errorText;

  AddTaskDayErrorState(this.errorText);
}

// ---------------------------------------------------------
class LoadingTasksNamesState extends AddTaskState{}
class LoadedTasksNamesState extends AddTaskState{}
class ErrorLoadingTasksNamesState extends AddTaskState{
  String errorText;

  ErrorLoadingTasksNamesState(this.errorText);
}

// ---------------------------------------------------------
class LoadingCategoriesState extends AddTaskState{}
class LoadedCategoriesState extends AddTaskState{}
class ErrorLoadingCategoriesState extends AddTaskState{
  String errorText;

  ErrorLoadingCategoriesState(this.errorText);
}

// ---------------------------------------------------------
class UpdateTaskState extends AddTaskState{}
class ErrorUpdateTaskState extends AddTaskState{
  String errorText;

  ErrorUpdateTaskState(this.errorText);
}

// ---------------------------------------------------------
class DeleteTaskState extends AddTaskState{}
class ErrorDeleteTaskState extends AddTaskState{
  String errorText;

  ErrorDeleteTaskState(this.errorText);
}

// ---------------------------------------------------------
class DeleteTaskDaysState extends AddTaskState{}
class ErrorDeleteTaskDaysState extends AddTaskState{
  String errorText;

  ErrorDeleteTaskDaysState(this.errorText);
}