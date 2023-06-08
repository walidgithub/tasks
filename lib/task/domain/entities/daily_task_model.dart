import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
  int? nested;
  int? nestedVal;
  int? wheel;
  int? counter;
  int? counterVal;
  int? specificDate;
  String? pinnedDay;

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
    this.nested,
    this.wheel,
    this.nestedVal,
    this.counterVal,
    this.specificDate,
    this.pinnedDay,
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
    data["nested"] = nested;
    data["nestedVal"] = nestedVal;
    data["wheel"] = wheel;
    data["counter"] = counter;
    data["counterVal"] = counterVal;
    data["specificDate"] = specificDate;
    data["pinnedDay"] = pinnedDay;
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
    nested = map["nested"];
    nestedVal = map["nestedVal"];
    wheel = map["wheel"];
    counter = map["counter"];
    counterVal = map["counterVal"];
    specificDate = map["specificDate"];
    pinnedDay = map["pinnedDay"];
  }
}

