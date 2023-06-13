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