import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/task/presentation/ui/add_task/cubit/add_task_state.dart';

import '../../../../domain/entities/daily_task_model.dart';
import '../../../../domain/entities/task_days_model.dart';
import '../../../../domain/repositories/task_repo_imp.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit(this.taskRepoImp) : super(AddTaskInitial()){
    emit(LoadingTasksState());
  }

  static AddTaskCubit get(context) => BlocProvider.of(context);

  TaskRepoImp taskRepoImp;

  List<String> tasksNames = ['gggggg','fffffff'];

  Future<void> addNewTask(DailyTaskModel dailyTaskModel) async {
    await taskRepoImp.addTask(dailyTaskModel);
    emit(NewTaskSavedState());
  }

  Future<void> addTaskDay(TaskDaysModel taskDays) async {
    await taskRepoImp.addTaskDay(taskDays);
    emit(NewTaskDaySavedState());
  }

  Future<List<String>> getTasksNames() async {
    final res;

    res = await taskRepoImp.getTasksNames().then((value) => {

      for (var i = 0; i < value.length; i++) {
        tasksNames.add(value[i].toString())
      }

    });

    emit(LoadedTasksState());

    return res;
  }

  // Future<List<DailyTaskModel>> getAllTasks(String category) async {
  //   final res = await taskRepoImp.getAllTasks('category');
  //   return res;
  // }
}
