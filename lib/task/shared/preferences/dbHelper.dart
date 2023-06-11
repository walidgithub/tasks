import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/task/domain/entities/nested_task_model.dart';
import 'package:tasks/task/domain/entities/task_days_model.dart';
import '../../domain/entities/daily_task_model.dart';

class DbHelper {
  Database? _db;

  static int? insertedNewTaskId;

  String dbdName = 'tasksDb5.db';

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDB(dbdName);
      return _db!;
    }
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: createDB);
  }

  Future createDB(Database db, int version) async {
    await db.execute(
        'create table tasks(id integer primary key autoincrement, taskName varchar(15), description varchar(255), category varchar(15), date TEXT NOT NULL, time TEXT NOT NULL, timer integer not null, pinned integer not null, counter integer not null, nested integer not null, wheel integer not null, nestedVal integer, counterVal integer, done integer not null, specificDate integer not null)');

    await db.execute(
        'create table nestedTasks(id integer primary key autoincrement, mainTaskId integer, taskName varchar(15), description varchar(255), category varchar(15), date TEXT NOT NULL, time TEXT NOT NULL, timer integer not null, pinned integer not null, counter integer not null, wheel integer not null, counterVal integer, done integer not null, specificDate integer not null)');

    await db.execute(
        'create table taskDays(id integer primary key autoincrement, mainTaskId integer, nameOfDay varchar(3), checkedDay integer not null)');

    // await db.execute(
    //     'create table categories(id integer primary key autoincrement, categoryName varchar(15), percent integer)');
  }

  // DailyTask----------------------------------------------------------------------------------------

  Future<DailyTaskModel> createTask(DailyTaskModel dailyTask) async {
    final db = _db!.database;

    insertedNewTaskId = await db.insert('tasks', dailyTask.toMap());

    return dailyTask;
  }

  Future<List<String>> getAllTasksNames() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final List<Map<String, dynamic>> tasksNames =
        await db.rawQuery('SELECT taskName FROM tasks');
    return List.generate(
        tasksNames.length, (index) => tasksNames[index]['taskName'].toString());
  }

  Future<List<String>> getDailyTasksCategories(String date) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final List<Map<String, dynamic>> tasksCategories =
        await db.rawQuery('SELECT * FROM tasks where date = ?', [date]);

    return List.generate(tasksCategories.length,
        (index) => tasksCategories[index]['category'].toString());
  }

  Future<double> getCategoriesPercent(String category) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    var task = await db.query('tasks');
    int tasksCount = task.length;

    var done = await db.query('tasks', where: "done = 1");
    int doneTasksCount = done.length;

    double percent = (doneTasksCount / tasksCount) * 100;

    return percent;
  }

  Future<int> getCountOfCategoryItems(String category, String date) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    var categories = await db.rawQuery('SELECT * FROM tasks where category = ? and date = ?', [category, date]);
    int tasksCount = categories.length;

    return tasksCount;
  }

  Future<DailyTaskModel> showTask(int id) async {
    final db = _db!.database;

    final maps = await db.query('tasks', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return DailyTaskModel.fromMap(maps.first);
    } else {
      throw Exception('Id not found');
    }
  }

  Future<List<DailyTaskModel>> showAllTasks(
      // String category, DateTime date) async {
      String category,
      String date) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;
    final result = await db.rawQuery(
        'SELECT * FROM tasks where date = ? and category = ? Order by id ASC',
        [date, category]);

    return result.map((map) => DailyTaskModel.fromMap(map)).toList();
  }

  Future<int> updateTask(DailyTaskModel dailyTask, int id) async {
    final db = _db!.database;

    return db
        .update('tasks', dailyTask.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTask(int id) async {
    final db = _db!.database;

    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // NestedTask ----------------------------------------------------------------------------------------

  Future<NestedTaskModel> createNestedTask(NestedTaskModel nestedTask) async {
    final db = _db!.database;

    await db.insert('nestedTasks', nestedTask.toMap());

    return nestedTask;
  }

  Future<NestedTaskModel> showNestedTask(int id) async {
    final db = _db!.database;

    final maps =
        await db.query('nestedTasks', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return NestedTaskModel.fromMap(maps.first);
    } else {
      throw Exception('Id not found');
    }
  }

  Future<List<NestedTaskModel>> showAllNestedTasks(int mainTaskId) async {
    final db = _db!.database;

    final result = await db.query('nestedTasks',
        where: 'mainTaskId = ?', whereArgs: [mainTaskId], orderBy: 'id ASC');

    return result.map((map) => NestedTaskModel.fromMap(map)).toList();
  }

  Future<int> updateNestedTask(NestedTaskModel nestedTask, int id) async {
    final db = _db!.database;

    return db.update('nestedTasks', nestedTask.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteNestedTask(int id) async {
    final db = _db!.database;

    return db.delete('nestedTasks', where: 'id = ?', whereArgs: [id]);
  }

  //  TaskDays ----------------------------------------------------------------------------------------

  Future<TaskDaysModel> createTaskDays(TaskDaysModel taskDays) async {
    final db = _db!.database;

    await db.insert('taskDays', taskDays.toMap());

    return taskDays;
  }

  Future<TaskDaysModel> showTaskDays(int mainTaskId) async {
    final db = _db!.database;

    final maps = await db
        .query('taskDays', where: 'mainTaskId = ?', whereArgs: [mainTaskId]);

    if (maps.isNotEmpty) {
      return TaskDaysModel.fromMap(maps.first);
    } else {
      throw Exception('Id not found');
    }
  }

  Future<int> updateTaskDays(TaskDaysModel taskDays, int id) async {
    final db = _db!.database;

    return db
        .update('taskDays', taskDays.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTaskDays(int mainTaskId) async {
    final db = _db!.database;

    return db
        .delete('taskDays', where: 'mainTaskId = ?', whereArgs: [mainTaskId]);
  }

  Future close() async {
    final db = _db!.database;

    db.close();
  }
}
