import 'package:flutter/material.dart';
import 'package:timer_tasks/COMPONENTS/border_view.dart';
import 'package:timer_tasks/COMPONENTS/button_view.dart';
import 'package:timer_tasks/COMPONENTS/checkbox_view.dart';
import 'package:timer_tasks/COMPONENTS/dropdown_view.dart';
import 'package:timer_tasks/COMPONENTS/future_view.dart';
import 'package:timer_tasks/COMPONENTS/iconbutton_view.dart';
import 'package:timer_tasks/COMPONENTS/image_view.dart';
import 'package:timer_tasks/COMPONENTS/main_view.dart';
import 'package:timer_tasks/COMPONENTS/padding_view.dart';
import 'package:timer_tasks/COMPONENTS/pill_view.dart';
import 'package:timer_tasks/COMPONENTS/slider_view.dart';
import 'package:timer_tasks/COMPONENTS/text_view.dart';
import 'package:timer_tasks/COMPONENTS/textfield_view.dart';
import 'package:timer_tasks/FUNCTIONS/colors.dart';
import 'package:timer_tasks/FUNCTIONS/misc.dart';
import 'package:timer_tasks/FUNCTIONS/nav.dart';
import 'package:timer_tasks/MODELS/DATAMASTER/datamaster.dart';
import 'package:timer_tasks/MODELS/constants.dart';
import 'package:timer_tasks/MODELS/firebase.dart';
import 'package:timer_tasks/MODELS/screen.dart';
import 'package:timer_tasks/VIEWS/task_timer.dart';

class GroupTasks extends StatefulWidget {
  final DataMaster dm;
  final String groupId;
  final String groupName;
  const GroupTasks(
      {super.key,
      required this.dm,
      required this.groupId,
      required this.groupName});

  @override
  State<GroupTasks> createState() => _GroupTasksState();
}

class _GroupTasksState extends State<GroupTasks> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  Future<List<dynamic>> _fetchTasks() async {
    final docs = await firebase_GetAllDocumentsOrderedQueried(
        '${appName}_Tasks',
        [
          {'field': 'groupId', 'operator': '==', 'value': widget.groupId},
        ],
        'date',
        'asc');
    return docs;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _detailsController.dispose();
    _durationController.dispose();
  }

  void onNewTask() async {
    setState(() {
      _titleController = TextEditingController();
      _detailsController = TextEditingController();
      _durationController = TextEditingController();
      _durationController.text = '0';
      widget.dm.setTogglePopup(true);
      widget.dm.setPopupChild(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: 'New Task',
              size: 20,
              weight: FontWeight.w600,
            ),
            TextView(
              text: 'task',
            ),
            BorderView(
              bottom: true,
              bottomColor: Colors.black,
              child: TextfieldView(
                controller: _titleController,
                backgroundColor: Colors.transparent,
                paddingH: 0,
                placeholder: 'ex. Complete About page.',
                multiline: true,
                minLines: 1,
                maxLines: 3,
                isCap: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextView(
              text: 'details',
            ),
            BorderView(
              bottom: true,
              bottomColor: Colors.black,
              child: TextfieldView(
                controller: _detailsController,
                backgroundColor: Colors.transparent,
                paddingH: 0,
                multiline: true,
                minLines: 3,
                maxLines: 5,
                placeholder:
                    'ex. Import the photos from the drive and paraphrase the final draft of their document.',
                isCap: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextView(
              text: 'time duration (minutes)',
            ),
            BorderView(
              bottom: true,
              bottomColor: Colors.black,
              child: TextfieldView(
                controller: _durationController,
                backgroundColor: Colors.transparent,
                paddingH: 0,
                keyboardType: TextInputType.number,
                placeholder: 'No decimal points',
                size: 30,
              ),
            ),
            TextView(
              text: 'no timer if setting at 0',
              color: hexToColor("#3490F3"),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonView(
                  child: PillView(
                      child: TextView(
                    text: 'cancel',
                  )),
                  onPress: () {
                    setState(() {
                      widget.dm.setTogglePopup(false);
                    });
                  },
                ),
                ButtonView(
                    paddingTop: 8,
                    paddingBottom: 8,
                    paddingLeft: 18,
                    paddingRight: 18,
                    radius: 100,
                    backgroundColor: hexToColor("#3490F3"),
                    child: TextView(
                      text: 'create',
                      color: Colors.white,
                      weight: FontWeight.w500,
                      size: 16,
                    ),
                    onPress: () {
                      onCreateTask();
                    })
              ],
            )
          ],
        ),
      );
    });
  }

  void onCreateTask() async {
    if (_titleController.text.isEmpty ||
        _detailsController.text.isEmpty ||
        _durationController.text.isEmpty) {
      setState(() {
        widget.dm.alertMissingInfo();
      });
      return;
    }

    setState(() {
      widget.dm.setTogglePopup(false);
      widget.dm.setToggleLoading(true);
    });

    final success =
        await firebase_CreateDocument('${appName}_Tasks', randomString(25), {
      'task': _titleController.text,
      'details': _detailsController.text.replaceAll("\n", 'jjj'),
      'date': DateTime.now().millisecondsSinceEpoch,
      'duration': int.parse(_durationController.text),
      'groupId': widget.groupId,
      'status': false
    });
    setState(() {
      widget.dm.setToggleLoading(false);
    });
  }

  //
  void onCheck(String taskId, bool status) async {
    if (!status) {
      firebase_UpdateDocument('${appName}_Tasks', taskId, {'status': false});
    } else {
      firebase_UpdateDocument('${appName}_Tasks', taskId, {'status': true});
    }
  }

  void onRemoveTask(String taskId) async {
    final success = await firebase_DeleteDocument('${appName}_Tasks', taskId);
    setState(() {});
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
                    text: '${widget.groupName}',
                    size: 26,
                    weight: FontWeight.w600,
                    wrap: true,
                    spacing: -1,
                  ),
                ],
              ),
              IconButtonView(
                  icon: Icons.add,
                  iconColor: hexToColor("#FF1F54"),
                  backgroundColor: hexToColor("#F6F8FA"),
                  width: 22,
                  onPress: () {
                    onNewTask();
                  })
            ],
          ),
        ),
      ),

      //
      Positioned.fill(
        child: SingleChildScrollView(
          child: FutureView(
            future: _fetchTasks(),
            childBuilder: (tasks) {
              return Column(
                children: [
                  for (var task in tasks)
                    ButtonView(
                      onPress: () {
                        if (task['duration'] != 0) {
                          nav_Push(
                              context, TaskTimer(dm: widget.dm, task: task),
                              () {
                            setState(() {});
                          });
                        }
                      },
                      child: BorderView(
                        bottom: true,
                        bottomColor: Colors.black26,
                        child: PaddingView(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CheckboxView(
                                  fillColor: hexToColor("#FF1F54"),
                                  width: 32,
                                  height: 32,
                                  defaultValue: task['status'],
                                  onChange: (value) {
                                    onCheck(task['id'], value);
                                  }),
                              SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: getWidth(context) * 0.85,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextView(
                                      text: task['task'],
                                      size: 18,
                                      weight: FontWeight.w600,
                                      wrap: true,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (task['duration'] > 0)
                                          TextView(
                                            text:
                                                '${task['duration'].toString()} minutes',
                                            color: hexToColor("#3490F3"),
                                            size: 15,
                                            weight: FontWeight.w500,
                                          )
                                        else
                                          TextView(
                                            text: task['details']
                                                .replaceAll('jjj', '\n'),
                                          ),
                                        ButtonView(
                                            child: Icon(
                                              Icons.delete_sweep_outlined,
                                              size: 32,
                                              color: hexToColor("#FF1F54"),
                                            ),
                                            onPress: () {
                                              onRemoveTask(task['id']);
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              );
            },
            emptyWidget: Expanded(
              child: Center(
                child: PaddingView(
                  child: Column(
                    children: [
                      ImageView(
                        imagePath: 'assets/graphics1.png',
                        width: getWidth(context) * 0.7,
                        height: getWidth(context) * 0.7,
                      ),
                      TextView(
                        text: 'no tasks yet.',
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
