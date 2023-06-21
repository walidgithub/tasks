class TaskDaysModel {
  int? id;
  String? nameOfDay;
  int? checkedDay;
  String? category;
  int? mainTaskId;

  TaskDaysModel(
      {this.id,
      this.checkedDay,
      this.nameOfDay,
      this.mainTaskId,
      this.category});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["nameOfDay"] = nameOfDay;
    data["checkedDay"] = checkedDay;
    data["mainTaskId"] = mainTaskId;
    data["category"] = category;
    return data;
  }

  TaskDaysModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    nameOfDay = map["nameOfDay"];
    checkedDay = map["checkedDay"];
    mainTaskId = map["mainTaskId"];
    category = map["category"];
  }
}

class MakeTaskDoneByDayModel {
  int? id;
  int? done;
  String? dayOfTask;
  String? date;

  MakeTaskDoneByDayModel({this.id, this.done, this.dayOfTask});
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["done"] = done;
    data["dayOfTask"] = dayOfTask;
    return data;
  }
}
