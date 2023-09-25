// import 'package:flutter/material.dart';
// import 'package:workmanager/workmanager.dart';

// class WorkmangerTasks extends StatefulWidget {
//   @override
//   _WorkmangerTasksState createState() => _WorkmangerTasksState();
// }

// class _WorkmangerTasksState extends State<WorkmangerTasks> {

//   @override
//   void initState() {
//     Workmanager().registerPeriodicTask(
//       "1",
//       "periodic Notification",
//       frequency: Duration(minutes: 15),
//     );

//     Workmanager().registerPeriodicTask(
//       "2",
//       "periodic Notification at day",
//       frequency: Duration(days: 1),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Main Screen' ,style: TextStyle(fontSize: 70),textAlign: TextAlign.center,),
//       ),
//     );
//   }
// }