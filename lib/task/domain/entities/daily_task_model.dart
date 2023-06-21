class DailyTaskModel {
  int? id;
  String? taskName;
  String? description;
  String? category;
  DateTime? date;
  String? time;
  int? timer;
  int? pinned;
  int? done;
  int? wheel;
  int? counter;
  int? counterVal;
  int? specificDate;

  DailyTaskModel({
    this.id,
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
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["done"] = done;
    data["category"] = category;
    data["date"] = date?.toIso8601String();
    data["description"] = description;
    data["pinned"] = pinned;
    data["taskName"] = taskName;
    data["time"] = time.toString();
    data["timer"] = timer;
    data["wheel"] = wheel;
    data["counter"] = counter;
    data["counterVal"] = counterVal;
    data["specificDate"] = specificDate;
    return data;
  }

  DailyTaskModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    done = map["done"];
    category = map["category"];
    date = DateTime.parse(map["date"] as String);
    description = map["description"];
    pinned = map["pinned"];
    taskName = map["taskName"];
    time = map["time"];
    timer = map["timer"];
    wheel = map["wheel"];
    counter = map["counter"];
    counterVal = map["counterVal"];
    specificDate = map["specificDate"];
  }
}

class MakeTaskDoneModel {
  int? id;
  int? done;

  MakeTaskDoneModel({this.id, this.done});
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["done"] = done;
    return data;
  }
}
