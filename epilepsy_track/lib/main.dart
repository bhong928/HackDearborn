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

//Defines a list to hold custom appointments
  List<Appointment> _customAppointments = [];

//calendar display
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
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
            headerHeight: 100,
            headerStyle: CalendarHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Color.fromARGB(255, 155, 44, 44),
                textStyle: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 4,
                    color: Color.fromARGB(255, 207, 207, 223),
                    fontWeight: FontWeight.w500)),
            allowAppointmentResize: true,
            onAppointmentResizeStart: resizeStart,
            onAppointmentResizeUpdate: resizeUpdate,
            onAppointmentResizeEnd: resizeEnd,
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
            //dataSource: EpilepsyLogging(getAppointments()),
            onTap: (calendarTapDetails) {
              // Handle the calendar tap event
              if (calendarTapDetails.targetElement ==
                  CalendarElement.calendarCell) {
                // Create a new custom appointment with the tapped date and time
                final newAppointment = Appointment(
                  startTime: calendarTapDetails.date!,
                  endTime: calendarTapDetails.date!.add(Duration(minutes: 30)),
                  subject: 'Seizure Log',
                  color: Colors.green,
                );

                // Add the new appointment to the list
                setState(() {
                  _customAppointments.add(newAppointment);
                });
              }
            },
            dataSource:
                EpilepsyLogging([...getAppointments(), ..._customAppointments]),
          ),
        ),
      ),
    );
  }
}

void resizeStart(AppointmentResizeStartDetails appointmentResizeStartDetails) {
  dynamic appointment = appointmentResizeStartDetails.appointment;
  CalendarResource? resource = appointmentResizeStartDetails.resource;
}

void resizeUpdate(
    AppointmentResizeUpdateDetails appointmentResizeUpdateDetails) {
  dynamic appointment = appointmentResizeUpdateDetails.appointment;
  DateTime? resizingTime = appointmentResizeUpdateDetails.resizingTime;
  Offset? resizingOffset = appointmentResizeUpdateDetails.resizingOffset;
  CalendarResource? resourceDetails = appointmentResizeUpdateDetails.resource;
}

void resizeEnd(AppointmentResizeEndDetails appointmentResizeEndDetails) {
  dynamic appointment = appointmentResizeEndDetails.appointment;
  DateTime? startTime = appointmentResizeEndDetails.startTime;
  DateTime? endTime = appointmentResizeEndDetails.endTime;
  CalendarResource? resourceDetails = appointmentResizeEndDetails.resource;
}

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 6, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 1));

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
}

class Meeting {
  Meeting(
    this.eventName,
    this.from,
    this.to,
    this.background,
    this.isAllDay,
  );

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
