import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timer_tasks/COMPONENTS/border_view.dart';
import 'package:timer_tasks/COMPONENTS/button_view.dart';
import 'package:timer_tasks/COMPONENTS/circleprogress_view.dart';
import 'package:timer_tasks/COMPONENTS/iconbutton_view.dart';
import 'package:timer_tasks/COMPONENTS/main_view.dart';
import 'package:timer_tasks/COMPONENTS/padding_view.dart';
import 'package:timer_tasks/COMPONENTS/text_view.dart';
import 'package:timer_tasks/FUNCTIONS/colors.dart';
import 'package:timer_tasks/FUNCTIONS/nav.dart';
import 'package:timer_tasks/MODELS/DATAMASTER/datamaster.dart';
import 'package:timer_tasks/MODELS/constants.dart';
import 'package:timer_tasks/MODELS/firebase.dart';

class TaskTimer extends StatefulWidget {
  final DataMaster dm;
  final Map<String, dynamic> task;

  const TaskTimer({super.key, required this.dm, required this.task});

  @override
  State<TaskTimer> createState() => _TaskTimerState();
}

class _TaskTimerState extends State<TaskTimer> with WidgetsBindingObserver {
  int totalSeconds = 0;
  int elapsed = 0;
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Add observer for app lifecycle
    totalSeconds = (widget.task['duration'] ?? 0) * 60;
    elapsed = totalSeconds; // Set elapsed to total time initially
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel(); // Cancel timer when widget is disposed
    }
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // Do nothing, keep the timer running
    } else if (state == AppLifecycleState.resumed) {
      // No need to explicitly resume since the timer is never paused
    }
  }

  // Function to format the time in HH:MM:SS format
  String formatTime() {
    int hours = elapsed ~/ 3600;
    int minutes = (elapsed % 3600) ~/ 60;
    int seconds = elapsed % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  // Function to handle when the timer finishes
  void onFinish() async {
    final success = await firebase_UpdateDocument(
        '${appName}_Tasks', widget.task['id'], {'status': true});
    if (success) {
      sendPushNotification(widget.dm.user['token'], 'Time is up!',
          'You have just completed your task.');
      nav_Pop(context);
    }
  }

  // Start or resume the timer
  void startTimer() {
    if (!isRunning) {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (elapsed > 0) {
            elapsed--;
          } else {
            timer.cancel();
            isRunning = false;
            onFinish(); // Call onFinish() when time reaches 0
          }
        });
      });
      isRunning = true;
    }
  }

  // Pause the timer
  void pauseTimer() {
    if (timer != null) {
      timer!.cancel();
      isRunning = false;
    }
  }

  // Stop the timer and reset
  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    setState(() {
      elapsed = totalSeconds; // Reset to total time
      isRunning = false;
    });
  }

  // Calculate percentage for CircleProgressView
  double getProgressPercentage() {
    if (totalSeconds == 0) return 0;
    return (elapsed / totalSeconds) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      // TOP
      BorderView(
        bottom: true,
        bottomColor: Colors.black12,
        child: PaddingView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 32,
                    color: hexToColor("#FF1F54"),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextView(
                    text: 'Timer Tasks',
                    size: 26,
                    weight: FontWeight.w600,
                    wrap: true,
                    spacing: -1,
                  ),
                ],
              ),
              IconButtonView(
                  icon: Icons.close,
                  iconColor: hexToColor("#FF1F54"),
                  backgroundColor: hexToColor("#F6F8FA"),
                  width: 22,
                  onPress: () {
                    nav_Pop(context);
                  })
            ],
          ),
        ),
      ),
      // MAIN - Show formatted time and CircleProgressView
      SizedBox(
        height: 20,
      ),
      SizedBox(
        width: 300,
        height: 300,
        child: Center(
          child: Stack(
            children: [
              CircleProgressView(
                percentage: getProgressPercentage(),
                size: 300,
                thickness: 30,
                color: hexToColor("#3490F3"),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: Center(
                  child: PaddingView(
                    child: TextView(
                      text: formatTime(),
                      size: 40,
                      weight: FontWeight.w700,
                      spacing: -1,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // Timer controls
      SizedBox(
        height: 20,
      ),
      PaddingView(
        paddingTop: 0,
        paddingBottom: 0,
        child: Row(
          children: [
            ButtonView(
              paddingTop: 10,
              paddingBottom: 10,
              paddingLeft: 20,
              paddingRight: 20,
              radius: 100,
              backgroundColor: hexToColor("#FF1F54"),
              child: TextView(
                text: 'Restart',
                color: Colors.white,
                size: 18,
                weight: FontWeight.w500,
              ),
              onPress: stopTimer,
            ),
            SizedBox(
              width: 10,
            ),
            ButtonView(
              paddingTop: 10,
              paddingBottom: 10,
              paddingLeft: 20,
              paddingRight: 20,
              radius: 100,
              backgroundColor: hexToColor("#EDEDED"),
              child: TextView(
                text: 'Pause',
                size: 18,
                weight: FontWeight.w500,
              ),
              onPress: pauseTimer,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ButtonView(
                paddingTop: 10,
                paddingBottom: 10,
                paddingLeft: 20,
                paddingRight: 20,
                radius: 100,
                backgroundColor: hexToColor("#3490F3"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextView(
                      text: 'Start',
                      color: Colors.white,
                      size: 18,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                onPress: startTimer,
              ),
            ),
          ],
        ),
      ),
      //
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: SingleChildScrollView(
          child: PaddingView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                    text: 'Task',
                    size: 18,
                    weight: FontWeight.w500,
                    color: Colors.black45,
                  ),
                  TextView(
                    text: widget.task['task'],
                    size: 26,
                    weight: FontWeight.w500,
                    wrap: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextView(
                    text: 'Details',
                    size: 18,
                    weight: FontWeight.w500,
                    color: Colors.black45,
                  ),
                  TextView(
                    text: widget.task['details'].replaceAll('jjj', '\n'),
                    size: 18,
                    weight: FontWeight.w500,
                    wrap: true,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
