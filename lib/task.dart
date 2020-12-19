import 'package:asstab/DBHelper.dart';


class Task {
  int id;
  String taskName;
  bool isComplete;
  Task(this.taskName , this.isComplete, [this.id]);

  Task.fromJson(Map map){
    this.id = map[DBhelper.taskIdColumnName];
    this.taskName = map[DBhelper.taskNameColumnName];
    this.isComplete = map[DBhelper.taskIsCompleteColumnName] == 1 ?true:false;
  }
  toJson() {
    return {
      DBhelper.taskIdColumnName : this.id,
      DBhelper.taskNameColumnName : this.taskName,
      DBhelper.taskIsCompleteColumnName : this.isComplete ? 1 : 0,
    };
  }


}