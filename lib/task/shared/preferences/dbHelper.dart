import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/task/domain/entities/nested_task_model.dart';
import 'package:tasks/task/domain/entities/task_days_model.dart';
import '../../domain/entities/daily_task_model.dart';

class DbHelper {
  Database? _db;

  static int? insertedNewTaskId;

  String dbdName = 'tasksDb6.db';

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

  // Task Operations----------------------------------------------------------------------------------------

  Future<DailyTaskModel> createTask(DailyTaskModel dailyTask) async {
    final db = _db!.database;

    insertedNewTaskId = await db.insert('tasks', dailyTask.toMap());

    return dailyTask;
  }

  Future<int> updateTask(DailyTaskModel dailyTask, int id) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db
        .update('tasks', dailyTask.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<int> toggleDone(MakeTaskDoneModel makeItTask, int id) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db
        .update('tasks', makeItTask.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<int> togglePinned(TogglePinnedModel togglePinned, int id) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db
        .update('tasks', togglePinned.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteTask(int id) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
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

  Future<List<String>> getAllCategories() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final List<Map<String, dynamic>> categories =
    await db.rawQuery('SELECT category FROM tasks');
    return List.generate(
        categories.length, (index) => categories[index]['category'].toString());
  }

  Future<DailyTaskModel> showTask(int id) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final maps = await db.query('tasks', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return DailyTaskModel.fromMap(maps.first);
    } else {
      throw Exception('Id not found');
    }
  }

  // Home----------------------------------------------------------------------------------------
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

  Future<int> getCountOfCategoryItems(String category, String date) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    var categories = await db.rawQuery('SELECT * FROM tasks where category = ? and date = ?', [category, date]);
    int tasksCount = categories.length;

    return tasksCount;
  }

  Future<double> getCategoriesPercent(String category, String date, [int doneTask = 1]) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    var task = await db.rawQuery('SELECT * FROM tasks where category = ? and date = ?', [category, date]);
    int tasksCount = task.length;

    var done = await db.rawQuery('SELECT * FROM tasks where category = ? and date = ? and done = ?', [category, date, doneTask]);
    int doneTasksCount = done.length;

    double percent = (doneTasksCount / tasksCount) * 100;

    return percent;
  }

  Future<double> getHomePercent(String date, [int doneTask = 1]) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    var task = await db.rawQuery('SELECT * FROM tasks where date = ?', [date]);
    int tasksCount = task.length;

    if (tasksCount == 0){
      return 0;
    }

    var done = await db.rawQuery('SELECT * FROM tasks where date = ? and done = ?', [date, doneTask]);
    int doneTasksCount = done.length;

    double percent = (doneTasksCount / tasksCount) * 100;

    return percent;
  }
  // Daily Tasks ---------------------------------------------------------------------------

  Future<List<DailyTaskModel>> loadDailyTasksByCategory(
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

  // NestedTask ----------------------------------------------------------------------------------------

  Future<NestedTaskModel> createNestedTask(NestedTaskModel nestedTask) async {
    final db = _db!.database;

    await db.insert('nestedTasks', nestedTask.toMap());

    return nestedTask;
  }

  Future<NestedTaskModel> showNestedTask(int id) async {
    if (_db == null) {
      await initDB(dbdName);
    }

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
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    final result = await db.query('nestedTasks',
        where: 'mainTaskId = ?', whereArgs: [mainTaskId], orderBy: 'id ASC');

    return result.map((map) => NestedTaskModel.fromMap(map)).toList();
  }

  Future<int> updateNestedTask(NestedTaskModel nestedTask, int id) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db.update('nestedTasks', nestedTask.toMap(),
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteNestedTask(int id) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db.delete('nestedTasks', where: 'id = ?', whereArgs: [id]);
  }

  //  TaskDays ----------------------------------------------------------------------------------------

  Future<TaskDaysModel> createTaskDays(TaskDaysModel taskDays) async {
    final db = _db!.database;

    await db.insert('taskDays', taskDays.toMap());

    return taskDays;
  }

  Future<List<TaskDaysModel>> showTaskDays(int mainTaskId) async {

    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;
    final result = await db.rawQuery(
        'SELECT * FROM taskDays where mainTaskId = ?',
        [mainTaskId]);

    return result.map((map) => TaskDaysModel.fromMap(map)).toList();
  }

  Future<int> deleteTaskDays(int mainTaskId) async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    return db
        .delete('taskDays', where: 'mainTaskId = ?', whereArgs: [mainTaskId]);
  }

  // Others -----------------------------------------------------------------------------------------------

  Future close() async {
    if (_db == null) {
      await initDB(dbdName);
    }

    final db = _db!.database;

    db.close();
  }
}
