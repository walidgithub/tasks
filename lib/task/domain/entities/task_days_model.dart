class TaskDaysModel {
  int? id;
  String? nameOfDay;
  int? checkedDay;
  int? mainTaskId;

  TaskDaysModel({this.id, this.checkedDay, this.nameOfDay, this.mainTaskId});

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["id"] = id;
    data["nameOfDay"] = nameOfDay;
    data["checkedDay"] = checkedDay;
    data["mainTaskId"] = mainTaskId;
    return data;
  }

  TaskDaysModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    nameOfDay = map["nameOfDay"];
    checkedDay = map["checkedDay"];
    mainTaskId = map["mainTaskId"];
  }
}
