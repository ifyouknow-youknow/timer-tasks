import 'package:flutter/material.dart';
import 'package:timer_tasks/COMPONENTS/blur_view.dart';
import 'package:timer_tasks/COMPONENTS/border_view.dart';
import 'package:timer_tasks/COMPONENTS/button_view.dart';
import 'package:timer_tasks/COMPONENTS/future_view.dart';
import 'package:timer_tasks/COMPONENTS/iconbutton_view.dart';
import 'package:timer_tasks/COMPONENTS/image_view.dart';
import 'package:timer_tasks/COMPONENTS/main_view.dart';
import 'package:timer_tasks/COMPONENTS/padding_view.dart';
import 'package:timer_tasks/COMPONENTS/text_view.dart';
import 'package:timer_tasks/COMPONENTS/textfield_view.dart';
import 'package:timer_tasks/FUNCTIONS/colors.dart';
import 'package:timer_tasks/FUNCTIONS/misc.dart';
import 'package:timer_tasks/FUNCTIONS/nav.dart';
import 'package:timer_tasks/MODELS/DATAMASTER/datamaster.dart';
import 'package:timer_tasks/MODELS/constants.dart';
import 'package:timer_tasks/MODELS/firebase.dart';
import 'package:timer_tasks/MODELS/screen.dart';
import 'package:timer_tasks/VIEWS/group_tasks.dart';

class Groups extends StatefulWidget {
  final DataMaster dm;
  const Groups({super.key, required this.dm});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  TextEditingController _groupController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchGroups();
  }

  @override
  void dispose() {
    super.dispose();
    _groupController.dispose();
  }

  Future<List<dynamic>> _fetchGroups() async {
    final docs = await firebase_GetAllDocumentsQueried('${appName}_Groups', [
      {'field': 'userId', 'operator': '==', 'value': widget.dm.user['id']}
    ]);
    print(docs);
    return [
      {'name': 'Today', 'id': widget.dm.user['id']},
      ...docs
    ];
  }

  void onCreateGroup() async {
    if (_groupController.text.isNotEmpty) {
      setState(() {
        widget.dm.setTogglePopup(false);
        widget.dm.setToggleLoading(true);
      });
      final success = await firebase_CreateDocument(
        '${appName}_Groups',
        randomString(25),
        {'name': _groupController.text, 'userId': widget.dm.user['id']},
      );
      if (success) {
        widget.dm.setToggleLoading(false);
        _fetchGroups();
      }
    }
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
                  icon: Icons.add,
                  iconColor: hexToColor("#FF1F54"),
                  backgroundColor: hexToColor("#F6F8FA"),
                  width: 22,
                  onPress: () {
                    setState(() {
                      _groupController = TextEditingController();
                      widget.dm.setPopupChild(Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: 'Task Group Name:',
                            size: 20,
                            weight: FontWeight.w500,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          BorderView(
                            bottom: true,
                            bottomColor: Colors.black,
                            child: TextfieldView(
                              controller: _groupController,
                              placeholder:
                                  'ex. Math 104, About Page Dev, etc..',
                              backgroundColor: Colors.transparent,
                              paddingH: 0,
                              isCap: true,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonView(
                                child: TextView(
                                  text: 'close',
                                  size: 18,
                                ),
                                onPress: () {
                                  setState(() {
                                    widget.dm.setTogglePopup(false);
                                  });
                                },
                              ),
                              ButtonView(
                                  child: TextView(
                                    text: 'create',
                                    size: 18,
                                    weight: FontWeight.w500,
                                    color: hexToColor("#3490F3"),
                                  ),
                                  onPress: () {
                                    onCreateGroup();
                                  })
                            ],
                          )
                        ],
                      ));
                      widget.dm.setTogglePopup(true);
                    });
                  })
            ],
          ),
        ),
      ),
      //  MAIN
      PaddingView(
        child: Positioned.fill(
          child: SingleChildScrollView(
              child: FutureView(
                  future: _fetchGroups(),
                  childBuilder: (groups) {
                    return GridView.count(
                      padding: EdgeInsets.all(0),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      shrinkWrap:
                          true, // Allow the grid to take the minimum required height
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling inside the grid
                      children: [
                        for (var group in groups)
                          ButtonView(
                            onPress: () {
                              nav_Push(
                                  context,
                                  GroupTasks(
                                    dm: widget.dm,
                                    groupId: group['id'],
                                    groupName: group['name'],
                                  ), () {
                                setState(() {});
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageView(
                                  radius: 10,
                                  imagePath: 'assets/folder.png',
                                  objectFit: BoxFit.cover,
                                  width: double.infinity,
                                  height: getWidth(context) * 0.3,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                TextView(
                                  text: group['name'],
                                  size: 18,
                                  weight: FontWeight.w600,
                                  wrap: true,
                                ),
                              ],
                            ),
                          )
                      ],
                    );
                  },
                  emptyWidget: Center(
                    child: TextView(
                      text: 'No task groups yet.',
                    ),
                  ))),
        ),
      )
    ]);
  }
}
