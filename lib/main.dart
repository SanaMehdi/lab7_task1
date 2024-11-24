import 'package:flutter/material.dart';

void main() {
  runApp(const TimerApp());
}

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _remainingTime = 10; // Initial countdown time
  bool _isRunning = false; // Flag to indicate timer state

  // Function to start the timer
  Future<void> _startTimer() async {
    if (_isRunning) return; // Prevent multiple timers
    setState(() {
      _isRunning = true;
    });

    while (_remainingTime > 0) {
      await Future.delayed(const Duration(seconds: 1)); // Wait for 1 second
      setState(() {
        _remainingTime--; // Decrease the countdown
      });
    }

    setState(() {
      _isRunning = false; // Reset running state when timer ends
    });

    // Optional: Show a message when the timer finishes
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Time's up!")),
    );
  }

  // Function to reset the timer
  void _resetTimer() {
    setState(() {
      _remainingTime = 10; // Reset the countdown
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer App"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display remaining time
            Text(
              'Time Remaining: $_remainingTime seconds',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Start button
            ElevatedButton(
              onPressed: _isRunning ? null : _startTimer,
              child: const Text("Start Timer"),
            ),
            const SizedBox(height: 10),

            // Reset button
            ElevatedButton(
              onPressed: _resetTimer,
              child: const Text("Reset Timer"),
            ),
          ],
        ),
      ),
    );
  }
}
