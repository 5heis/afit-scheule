import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF5E17EB),
                )),
            Text(
              'ABOUT DAY SCHEDULE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Text(
                'Introducing the ultimate todo list app that will change the way you organize your life! With our app, you can easily create tasks and manage your to-do list on-the-go. Whether you are a busy professional, a student, or a homemaker, our app is designed to help you stay organized and focused.\n\nWith our user-friendly interface, you can quickly add tasks to your list and mark them as completed when you finish them. You can also set due dates and reminders for each task, so you never miss an important deadline or appointment. Plus, our app allows you to categorize your tasks by priority, so you can focus on the most important tasks first.\n\nBut that\'s not all. Our app also offers a range of other features to help you manage your tasks more efficiently. For example, you can create sub-tasks and break down complex projects into smaller, more manageable tasks. You can also collaborate with others and share your to-do list with friends, family, or colleagues.\n\nOur app is also highly customizable, so you can personalize it to your liking. You can choose from a range of themes and colors to make the app look and feel exactly the way you want it to. And if you ever need help, our support team is always available to assist you.\n\nSo what are you waiting for? Download our app today and start organizing your life like a pro! Whether you need to manage your work, school, or personal life, our todo list app has got you covered. With its intuitive design and powerful features, you\'ll wonder how you ever lived without it.',
                style: TextStyle(fontSize: 18.0),
                maxLines: 20,
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
