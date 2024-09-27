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
    List<Map<String, String>> schedules = [
      {
        'time': '02:40',
        'course': 'Mathematics',
        'topic': 'Chapter 1: Introduction',
        'instructor': 'Clark Kent'
      },
      {
        'time': '10:00',
        'course': 'Science',
        'topic': 'Chapter 2: Physics',
        'instructor': 'Bruce Wayne'
      },
      {
        'time': '11:35',
        'course': 'History',
        'topic': 'Ancient Civilizations',
        'instructor': 'Diana Prince'
      },
    ];

    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        var schedule = schedules[index];
        bool isCurrentTime = checkIfCurrentTime(schedule['time']!);

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time Column
              Container(
                width: 60, // Fixed width for time
                child: Text(
                  schedule['time']!,
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
                        style:  TextStyle(
                          fontSize: 14,
                          color:  isCurrentTime
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(255, 3, 3, 3),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        schedule['topic']!,
                        style:  TextStyle(
                          fontSize: 12,
                          color:  isCurrentTime
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(255, 3, 3, 3),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        schedule['instructor']!,
                        style: TextStyle(
                          fontSize: 12,
                          color:  isCurrentTime
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

bool checkIfCurrentTime(String time) {
  // Get today's date
  DateTime now = DateTime.now();

  // Parse the given time string (e.g., '10:00') into a DateTime object for today
  final scheduleTime = DateTime(
    now.year,
    now.month,
    now.day,
    int.parse(time.split(":")[0]), // hour
    int.parse(time.split(":")[1]), // minute
  );

  // Define a time range (e.g., 15 minutes before and after the schedule time)
  final lowerBound = scheduleTime.subtract(Duration(minutes: 15));
  final upperBound = scheduleTime.add(Duration(minutes: 15));

  // Check if the current time falls within the range
  return now.isAfter(lowerBound) && now.isBefore(upperBound);
}
}
