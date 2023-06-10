import '../../../../domain/entities/daily_task_model.dart';

abstract class AddTaskState{}

class AddTaskInitial extends AddTaskState{}

class LoadPrevTaskInitial extends AddTaskState{
  DailyTaskModel taskData;

  LoadPrevTaskInitial(this.taskData);
}

class NewTaskSavedState extends AddTaskState{}

class NewTaskDaySavedState extends AddTaskState{}

class LoadingTasksState extends AddTaskState{}
class LoadedTasksState extends AddTaskState{}
class ErrorLoadingTasksState extends AddTaskState{
  String errorText;

  ErrorLoadingTasksState(this.errorText);
}


class LoadingTasksNamesState extends AddTaskState{}
class LoadedTasksNamesState extends AddTaskState{}
class ErrorLoadingTasksNamesState extends AddTaskState{
  String errorText;

  ErrorLoadingTasksNamesState(this.errorText);
}

class UpdateTaskState extends AddTaskState{}

class DeleteTaskState extends AddTaskState{}

class AddTaskErrorState extends AddTaskState{
  String errorText;

  AddTaskErrorState(this.errorText);
}