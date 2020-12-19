
import 'package:asstab/new_task.dart';
import 'package:asstab/task.dart';
import 'package:asstab/taskWedget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DBHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TabBarPage(User('ghadeer', 'ghadeer@gamil.com')),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TabBarPage extends StatefulWidget{
    User user;
  TabBarPage(this.user);
  
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with SingleTickerProviderStateMixin {
  TabController tabController ;
  List<Task> tasks ;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer( child: Column(
          children: [
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  child: Text(widget.user.name[0].toUpperCase()),
                ),
                accountName: Text(widget.user.name),
                accountEmail: Text(widget.user.email)),
         
          ],
        ),),
      appBar: AppBar(
        title: Text('Todo'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'All Tasks',
            ),Tab(
              text: 'Complete Tasks',
            ),Tab(
              text: 'Incomplete Tasks',
            ),
          ],
          isScrollable: true,),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [AllTasks(tasks),CompleteTasks(),IncompleteTasks()],
            ),
          ),
                 Container(
                 margin:EdgeInsets.only(bottom: 20),
                
                 child: FloatingActionButton(
                 child:Icon(Icons.add ),
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return NewTasks();
                        },
                    ));

        }),
        
      ) ]));
  
  }
}

class AllTasks extends StatefulWidget{
  List<Task> tasks ;
  AllTasks(this.tasks);

  @override
  _AllTasksState createState() => _AllTasksState();
}


class _AllTasksState extends State<AllTasks> {

    deleteFun(e){
    setState(() {});
    DBhelper.dbHelper.deleteTask(e);
  }
  Widget getTaskWidgets(List<Task> data)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < data.length; i++){
      list.add(TaskWidget(data[i] , deleteFun ));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Task>>(
        future: DBhelper.dbHelper.selectAllTask(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            List<Task> data =snapshot.data;

            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),

    );
  }
}

class CompleteTasks extends StatefulWidget{
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  myFun() {
    setState(() {

    });
  }
  deleteFun(e){
    setState(() {});
    DBhelper.dbHelper.deleteTask(e);
  }
  Widget getTaskWidgets(List<Task> data)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < data.length; i++){
      list.add(TaskWidget(data[i] , deleteFun , myFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Task>>(
        future: DBhelper.dbHelper.selectSpecificTask(1),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            List<Task> data =snapshot.data;
            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),
    );
  }
}


class IncompleteTasks extends StatefulWidget{
  @override
  _IncompleteTasksState createState() => _IncompleteTasksState();
}

class _IncompleteTasksState extends State<IncompleteTasks> {
  myFun() {
    setState(() {

    });
  }
  deleteFun(e){
    setState(() {});
    DBhelper.dbHelper.deleteTask(e);
  }
  Widget getTaskWidgets(List<Task> data)
  {
    List<Widget> list = new List<Widget>();
    for(var i = 0; i < data.length; i++){
      list.add(TaskWidget(data[i] , deleteFun , myFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Task>>(
        future: DBhelper.dbHelper.selectSpecificTask(0),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            List<Task> data =snapshot.data;
            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),
    );
  }
}


 class User {
  String name;
  String email;
  User(this.name, this.email);
}
