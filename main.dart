import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For parsing time strings

void main() => runApp(ScheduleApp());

class ScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: ScheduleScreen(),
    );
  }
}

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedDay = 3; // Default to Wednesday
  final List<String> days = ["S", "M", "T", "W", "TH", "F", "SA"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 190, 190, 190),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 190, 190, 190),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Option 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Option 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Juan Dela Cruztzy",
              style: TextStyle(fontSize: 40),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: days.asMap().entries.map((entry) {
                        int index = entry.key;
                        String day = entry.value;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedDay = index;
                            });
                          },
                          child: SizedBox(
                            width: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: selectedDay == index
                                    ? const Color.fromARGB(255, 143, 0, 0)
                                    : Colors.grey,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(
                                  child: Text(
                                    day,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: ScheduleList(selectedDay: selectedDay),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ScheduleList extends StatelessWidget {
  final int selectedDay;

  ScheduleList({required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    // List of schedules with 'start_time' and 'end_time'
    List<Map<String, dynamic>> schedules = [
      {
        'start_time': '02:30',
        'end_time': '03:15',
        'course': 'Mathematics',
        'topic': 'Chapter 1: Introduction',
        'instructor': 'Clark Kent',
        'day_of_week': 0 // Sunday
      },      {
        'start_time': '03:15',
        'end_time': '04:00',
        'course': 'Mathematics',
        'topic': 'Chapter 1: Introduction',
        'instructor': 'Clark Kent',
        'day_of_week': 0 // Sunday
      },
      {
        'start_time': '10:00',
        'end_time': '11:00',
        'course': 'Science',
        'topic': 'Chapter 2: Physics',
        'instructor': 'Bruce Wayne',
        'day_of_week': 3 // Wednesday
      },
      {
        'start_time': '11:35',
        'end_time': '12:30',
        'course': 'History',
        'topic': 'Ancient Civilizations',
        'instructor': 'Diana Prince',
        'day_of_week': 3 // Wednesday
      },
      {
        'start_time': '09:00',
        'end_time': '10:00',
        'course': 'Math',
        'topic': 'Algebra',
        'instructor': 'Albert Einstein',
        'day_of_week': 1 // Monday
      },
    ];

    // Filter schedules based on the selected day
    List<Map<String, dynamic>> filteredSchedules = schedules
        .where((schedule) => schedule['day_of_week'] == selectedDay)
        .toList();

    return ListView.builder(
      itemCount: filteredSchedules.length,
      itemBuilder: (context, index) {
        var schedule = filteredSchedules[index];
        bool isCurrentTime = checkIfCurrentTime(
            schedule['start_time']!, schedule['end_time']!);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time Column
              Container(
                width: 60, // Fixed width for time
                child: Text(
                  schedule['start_time']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10), // Space between time and container
              // Schedule Detail Container
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isCurrentTime
                        ? const Color.fromARGB(255, 143, 0, 0)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schedule['course']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: isCurrentTime
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(255, 3, 3, 3),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        schedule['topic']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: isCurrentTime
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(255, 3, 3, 3),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        schedule['instructor']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: isCurrentTime
                              ? const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(255, 3, 3, 3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool checkIfCurrentTime(String startTime, String endTime) {
    // Get today's date
    DateTime now = DateTime.now();

    // Parse the start_time and end_time string into DateTime objects for today
    final scheduleStartTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(startTime.split(":")[0]), // hour
      int.parse(startTime.split(":")[1]), // minute
    );

    final scheduleEndTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(endTime.split(":")[0]), // hour
      int.parse(endTime.split(":")[1]), // minute
    );

    // Define a time range (15 minutes before the start_time and up to the end_time)
    final lowerBound = scheduleStartTime.subtract(Duration(minutes: 15));
    final upperBound = scheduleEndTime;

    // Check if the current time falls within the range (15 minutes before start_time and before end_time)
    return now.isAfter(lowerBound) && now.isBefore(upperBound);
  }
}
