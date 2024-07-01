import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.compact,
      ),
      home: const WatchScreen(),
    );
  }
}

class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return TimerScreen(mode: mode);
          },
        );
      },
    );
  }
}

class TimerScreen extends StatefulWidget {
  final WearMode mode;

  const TimerScreen({required this.mode, super.key});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late Timer _timer;
  late int _count;
  late String _strCount;
  late String _status;

  @override
  void initState() {
    super.initState();
    _count = 0;
    _strCount = "00:00:00";
    _status = "Start";
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                'Cronómetro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            const Center(
              child: Icon(
                Icons.timer,
                size: 30.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Text(
                _strCount,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            _buildWidgetButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetButton() {
    if (widget.mode == WearMode.active) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            iconSize: 25.0,
            onPressed: () {
              if (_status == "Start") {
                _startTimer();
              } else if (_status == "Stop") {
                _timer.cancel();
                setState(() {
                  _status = "Continue";
                });
              } else if (_status == "Continue") {
                _startTimer();
              }
            },
            icon: Icon(Icons.play_arrow, color: Colors.white),
          ),
          const SizedBox(width: 10.0),
          IconButton(
            iconSize: 25.0,
            onPressed: () {
              if (_timer.isActive) {
                _timer.cancel();
                setState(() {
                  _count = 0;
                  _strCount = "00:00:00";
                  _status = "Start";
                });
              }
            },
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  void _startTimer() {
    _status = "Stop";
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _count += 1;
        int hour = _count ~/ 3600;
        int minute = (_count % 3600) ~/ 60;
        int second = (_count % 3600) % 60;
        _strCount = (hour < 10 ? "0" : "") + "$hour";
        _strCount += ":";
        _strCount += (minute < 10 ? "0" : "") + "$minute";
        _strCount += ":";
        _strCount += (second < 10 ? "0" : "") + "$second";
      });
    });
  }
}
