import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(ScheduleApp());

class ScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule App',
      theme: ThemeData(
        primarySwatch: Colors.cyan, // Custom color for your theme
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
              backgroundImage: AssetImage('assets/profile.jpg'), // User image
            ),
          ),
        ],
      ),
      drawer: Drawer(
        // Drawer menu items
        child: ListView(
          children: [
            const DrawerHeader(
              child: const Text('Menu'),
            ),
            ListTile(
              title: const Text('Option 1'),
              onTap: () {
                // Handle tap
              },
            ),
            ListTile(
              title: const Text('Option 2'),
              onTap: () {
                // Handle tap
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
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
                              // Add this widget
                              width: 50, // Set a fixed width
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
                      )),
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
        'time': '11:35',
        'course': 'Mathematics',
        'topic': 'Chapter 1: Introduction',
        'instructor': 'Clark Kent'
      },
      // Add more schedules for each day here...
      {
        'time': '11:35',
        'course': 'Mathematics',
        'topic': 'Chapter 1: Introduction',
        'instructor': 'Clark Kent'
      },
      {
        'time': '11:35',
        'course': 'Mathematics',
        'topic': 'Chapter 1: Introduction',
        'instructor': 'Clark Kent'
      },
    ];

    return ListView.builder(
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        var schedule = schedules[index];
        bool isCurrentTime = checkIfCurrentTime(schedule['time']!);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isCurrentTime
                  ? const Color.fromARGB(255, 143, 0, 0)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  schedule['time']!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  schedule['course']!,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  schedule['topic']!,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
                Text(
                  schedule['instructor']!,
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Dummy function to check if current time matches schedule time
  bool checkIfCurrentTime(String time) {
    // Logic to check if current time is within the schedule's time frame
    return DateTime.now().hour == 11 &&
        DateTime.now().minute == 35; // For example
  }
}

