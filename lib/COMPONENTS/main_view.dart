import 'package:flutter/material.dart';
import 'package:timer_tasks/COMPONENTS/alert_view.dart';
import 'package:timer_tasks/COMPONENTS/bubble_view.dart';
import 'package:timer_tasks/COMPONENTS/button_view.dart';
import 'package:timer_tasks/COMPONENTS/loading_view.dart';
import 'package:timer_tasks/COMPONENTS/popup_view.dart';
import 'package:timer_tasks/COMPONENTS/text_view.dart';
import 'package:timer_tasks/MODELS/DATAMASTER/datamaster.dart';

class MainView extends StatefulWidget {
  final DataMaster dm;
  final List<Widget> children;
  final Color backgroundColor;

  const MainView({
    super.key,
    required this.dm,
    required this.children,
    this.backgroundColor = Colors.white,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 46,
              ),
              ...widget.children,
            ],
          ),

          // ABSOLUTE
          if (widget.dm.toggleBubble) const BubbleView(),
          if (widget.dm.togglePopup) PopupView(child: widget.dm.popupChild),
          if (widget.dm.toggleAlert)
            AlertView(
              title: widget.dm.alertTitle,
              message: widget.dm.alertText,
              actions: [
                ButtonView(
                  child: const TextView(
                    text: 'Close',
                    wrap: false,
                  ),
                  onPress: () {
                    setState(() {
                      widget.dm.setToggleAlert(false);
                    });
                  },
                ),
                ...widget.dm.alertButtons
              ],
            ),
          if (widget.dm.toggleLoading) const LoadingView()
        ],
      ),
    );
  }
}
