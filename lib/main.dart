import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(QuitSmokingApp());
}

class QuitSmokingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quit Smoking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InputPage(),
        '/calendar': (context) => CalendarPage(events: {}),
        '/smoked_date': (context) => SmokedDatePage(),
      },
    );
  }
}

class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/smoked_date');
              },
              child: Text('Smoked'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calendar', arguments: {'action': 'not_smoked'});
              },
              child: Text('Did Not Smoke'),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  final Map<DateTime, List<String>> events;

  CalendarPage({required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CalendarWidget(events: events),
        ),
      ),
    );
  }
}

class SmokedDatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Smoked Date'),
      ),
      body: Center(
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: DateTime.now(),
          calendarFormat: CalendarFormat.month,
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
          ),
          selectedDayPredicate: (day) {
            return false; // Disable selection
          },
        ),
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  final Map<DateTime, List<String>> events;

  CalendarWidget({required this.events});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) {
        return false; // Disable selection
      },
      eventLoader: (day) => events[day] ?? [],
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, _) {
          final bool isSmoked = events.containsKey(day) && events[day]!.contains('smoked');
          final bool isNotSmoked = events.containsKey(day) && events[day]!.contains('not_smoked');
          return Center(
            child: Container(
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSmoked ? Colors.red : isNotSmoked ? Colors.green : null,
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: events.containsKey(day) ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
