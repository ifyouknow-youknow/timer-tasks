import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timer_tasks/COMPONENTS/accordion_view.dart';
import 'package:timer_tasks/COMPONENTS/bargraph_view.dart';
import 'package:timer_tasks/COMPONENTS/blur_view.dart';
import 'package:timer_tasks/COMPONENTS/button_view.dart';
import 'package:timer_tasks/COMPONENTS/calendar_view.dart';
import 'package:timer_tasks/COMPONENTS/checkbox_view.dart';
import 'package:timer_tasks/COMPONENTS/circleprogress_view.dart';
import 'package:timer_tasks/COMPONENTS/dropdown_view.dart';
import 'package:timer_tasks/COMPONENTS/fade_view.dart';
import 'package:timer_tasks/COMPONENTS/iconbutton_view.dart';
import 'package:timer_tasks/COMPONENTS/loading_view.dart';
import 'package:timer_tasks/COMPONENTS/main_view.dart';
import 'package:timer_tasks/COMPONENTS/map_view.dart';
import 'package:timer_tasks/COMPONENTS/padding_view.dart';
import 'package:timer_tasks/COMPONENTS/pager_view.dart';
import 'package:timer_tasks/COMPONENTS/pill_view.dart';
import 'package:timer_tasks/COMPONENTS/progress_view.dart';
import 'package:timer_tasks/COMPONENTS/qrcode_view.dart';
import 'package:timer_tasks/COMPONENTS/roundedcorners_view.dart';
import 'package:timer_tasks/COMPONENTS/segmented_view.dart';
import 'package:timer_tasks/COMPONENTS/slider_view.dart';
import 'package:timer_tasks/COMPONENTS/switch_view.dart';
import 'package:timer_tasks/COMPONENTS/text_view.dart';
import 'package:timer_tasks/FUNCTIONS/colors.dart';
import 'package:timer_tasks/FUNCTIONS/date.dart';
import 'package:timer_tasks/FUNCTIONS/media.dart';
import 'package:timer_tasks/FUNCTIONS/misc.dart';
import 'package:timer_tasks/FUNCTIONS/recorder.dart';
import 'package:timer_tasks/FUNCTIONS/server.dart';
import 'package:timer_tasks/MODELS/coco.dart';
import 'package:timer_tasks/MODELS/constants.dart';
import 'package:timer_tasks/MODELS/DATAMASTER/datamaster.dart';
import 'package:timer_tasks/MODELS/firebase.dart';
import 'package:timer_tasks/MODELS/screen.dart';
import 'package:record/record.dart';

class PlaygroundView extends StatefulWidget {
  final DataMaster dm;
  const PlaygroundView({super.key, required this.dm});

  @override
  State<PlaygroundView> createState() => _PlaygroundViewState();
}

class _PlaygroundViewState extends State<PlaygroundView> {
  @override
  Widget build(BuildContext context) {
    return MainView(dm: widget.dm, children: [
      const PaddingView(
        child: Center(
          child: TextView(
            text: "Nothing defeats the Bagel.",
            size: 22,
            weight: FontWeight.w600,
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      ButtonView(
          child: PillView(
            child: TextView(
              text: 'Press Me',
            ),
          ),
          onPress: () {
            setState(() {
              widget.dm.praiseTheBagel();
            });
          }),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
