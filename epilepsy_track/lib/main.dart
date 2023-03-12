import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Epilepsy App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Epilepsy App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
        @override
        Widget build (BuildContext cotext){
        return Scaffold(
          body: SfCalendar(
            view: CalendarView.month,
            firstDayOfWeek: 7,
            //initialDisplayDate: DateTime(2023,03,11,12,00),
            dataSource: EpilepsyLogging(getAppointments()),
          ),
        );
        }
  }

  List<Appointment> getAppointments(){
    List<Appointment> meetings=<Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 12,0,0); //12,0,0 is 6 pm
    final DateTime endTime = startTime.add(const Duration(hours:2));

    meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Take Medidcation',
      color: Colors.blue,
    recurrenceRule: 'FREQ=DAILY;COUNT=365'));

    return meetings;
  }

  class EpilepsyLogging extends CalendarDataSource{
EpilepsyLogging(List<Appointment> source){
  appointments = source;
}
  }
