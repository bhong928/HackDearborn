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
      title: 'Brain Wave',
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
  final CalendarController _controller = CalendarController();
  Color? _headerColor, _viewHeaderColor, _calendarColor;
//calendar display
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: SfCalendar(
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              shape: BoxShape.rectangle,
            ),
            cellBorderColor: Color.fromARGB(255, 0, 0, 0),
            backgroundColor: Color.fromARGB(255, 236, 246, 255),
            view: CalendarView.week,
            allowedViews: [
              CalendarView.day,
              CalendarView.month,
              CalendarView.schedule,
              CalendarView.week,
              CalendarView.timelineDay,
            ],
            viewHeaderStyle: ViewHeaderStyle(backgroundColor: _viewHeaderColor),
            showNavigationArrow: true,
            showDatePickerButton: true,
            showCurrentTimeIndicator: true,
            showWeekNumber: true,
            todayHighlightColor: Color.fromARGB(255, 97, 29, 57),
            firstDayOfWeek: 7,
            dataSource: EpilepsyLogging(getAppointments()),
          ),
        ),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 0, 10, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

//medication color
  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Take Medidcation',
      color: Color.fromARGB(255, 210, 166, 218),
      recurrenceRule: 'FREQ=DAILY;COUNT=365'));

  return meetings;
}

class EpilepsyLogging extends CalendarDataSource {
  EpilepsyLogging(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
