import '../../../../domain/entities/daily_task_model.dart';

abstract class DailyTasksState{}

class DailyTasksInitial extends DailyTasksState{}

class LoadPrevTaskInitial extends DailyTasksState{
  DailyTaskModel taskData;

  LoadPrevTaskInitial(this.taskData);
}

class LoadingDailyTasksState extends DailyTasksState{}
class LoadedDailyTasksState extends DailyTasksState{}
class ErrorLoadingDailyTasksState extends DailyTasksState{
  String errorText;

  ErrorLoadingDailyTasksState(this.errorText);
}

class UpdateTaskState extends DailyTasksState{}
class ErrorUpdateTaskState extends DailyTasksState{
  String errorText;

  ErrorUpdateTaskState(this.errorText);
}

class DeleteTaskState extends DailyTasksState{}
class ErrorDeleteTaskState extends DailyTasksState{
  String errorText;

  ErrorDeleteTaskState(this.errorText);
}

class MakeTaskDoneState extends DailyTasksState{}
class UnMakeTaskDoneState extends DailyTasksState{}
class ErrorMakeTaskDoneState extends DailyTasksState{
  String errorText;

  ErrorMakeTaskDoneState(this.errorText);
}