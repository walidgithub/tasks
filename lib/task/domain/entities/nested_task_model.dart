class NestedTaskModel {
  int? id;
  int? mainTaskId;
  String? taskName;
  String? description;
  String? category;
  DateTime? date;
  DateTime? time;
  int? timer;
  int? pinned;
  int? done;
  int? wheel;
  int? counter;
  int? counterVal;
  int? specificDate;
  String? pinnedDay;

  NestedTaskModel({
    this.id,
    this.mainTaskId,
    this.taskName,
    this.description,
    this.category,
    this.date,
    this.time,
    this.timer,
    this.pinned,
    this.done,
    this.counter,
    this.wheel,
    this.counterVal,
    this.specificDate,
    this.pinnedDay,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["mainTaskId"] = mainTaskId;
    data["done"] = done;
    data["category"] = category;
    data["date"] = date?.toIso8601String();
    data["description"] = description;
    data["pinned"] = pinned;
    data["taskName"] = taskName;
    data["time"] = time?.toIso8601String();
    data["timer"] = timer;
    data["wheel"] = wheel;
    data["counter"] = counter;
    data["counterVal"] = counterVal;
    data["specificDate"] = specificDate;
    data["pinnedDay"] = pinnedDay;
    return data;
  }

  NestedTaskModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    mainTaskId = map["mainTaskId"];
    done = map["done"];
    category = map["category"];
    date = DateTime.parse(map["date"] as String);
    description = map["description"];
    pinned = map["pinned"];
    taskName = map["taskName"];
    time = DateTime.parse(map["time"] as String);
    timer = map["timer"];
    wheel = map["wheel"];
    counter = map["counter"];
    counterVal = int.parse(map["counterVal"]);
    specificDate = map["specificDate"];
    pinnedDay = map["pinnedDay"];
  }
}

