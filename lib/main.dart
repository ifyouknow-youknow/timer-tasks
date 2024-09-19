import 'package:timer_tasks/VIEWS/login.dart';
import 'package:timer_tasks/VIEWS/playground.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timer_tasks/MODELS/DATAMASTER/datamaster.dart';
import 'package:timer_tasks/MODELS/firebase.dart';
import 'package:timer_tasks/VIEWS/groups.dart';
import 'package:timer_tasks/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "lib/.env");
  final dm = DataMaster();

  runApp(
    MaterialApp(
      home: Login(dm: dm),
    ),
    // initialRoute: "/",
    // routes: {
    //   // "/": (context) => const PlaygroundView(),
    // },
  );
}
