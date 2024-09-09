import 'package:day_schedule/pages/about.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  TimeOfDay _timeOfDay = TimeOfDay(hour: 20, minute: 00);
  bool isSwitched = false;

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  //Show Time Picker
  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        _timeOfDay = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer header
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF5E17EB),
              ),
              child: Image.asset('splash.png'),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                },
                child: ListTile(
                  trailing: const Icon(Icons.arrow_forward_ios),
                  leading: const Icon(Icons.info),
                  title: Text(
                    "A B O U T",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ),
            ),

            // TimeTabele BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListTile(
                leading: const Icon(Icons.calendar_month),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
                title: Text(
                  "T I M E T A B L E",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),

            //Notiication Switch
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListTile(
                leading: const Icon(Icons.notifications),
                trailing: OutlinedButton(
                    onPressed: _showTimePicker,
                    child: Text(
                      'Change Time',
                      style: TextStyle(color: Color(0xFF5E17EB)),
                    )),
                title: Text(
                  "Notify",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),

            //Time
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListTile(
                leading: const Icon(Icons.lock_clock),
                title: Text(
                  _timeOfDay.format(context).toString(),
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF5E17EB),
        title: Text(
          'My Schedular',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: createNewTask,
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF5E17EB),
        label: Text('add task'),
        icon: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
