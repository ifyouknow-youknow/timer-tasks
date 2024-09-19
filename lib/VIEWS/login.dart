import 'package:flutter/material.dart';
import 'package:timer_tasks/COMPONENTS/border_view.dart';
import 'package:timer_tasks/COMPONENTS/button_view.dart';
import 'package:timer_tasks/COMPONENTS/image_view.dart';
import 'package:timer_tasks/COMPONENTS/main_view.dart';
import 'package:timer_tasks/COMPONENTS/padding_view.dart';
import 'package:timer_tasks/COMPONENTS/pager_view.dart';
import 'package:timer_tasks/COMPONENTS/roundedcorners_view.dart';
import 'package:timer_tasks/COMPONENTS/text_view.dart';
import 'package:timer_tasks/COMPONENTS/textfield_view.dart';
import 'package:timer_tasks/FUNCTIONS/colors.dart';
import 'package:timer_tasks/FUNCTIONS/nav.dart';
import 'package:timer_tasks/MODELS/DATAMASTER/datamaster.dart';
import 'package:timer_tasks/MODELS/firebase.dart';
import 'package:timer_tasks/MODELS/screen.dart';
import 'package:timer_tasks/VIEWS/signup.dart';
import 'package:timer_tasks/VIEWS/groups.dart';

class Login extends StatefulWidget {
  final DataMaster dm;
  const Login({super.key, required this.dm});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
//
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void init() async {
    setState(() {
      setState(() {
        widget.dm.setToggleLoading(true);
      });
    });
    final loggedIn = await widget.dm.checkUser('Users');
    if (loggedIn) {
      setState(() {
        widget.dm.setToggleLoading(false);
      });
      nav_PushAndRemove(context, Groups(dm: widget.dm));
    } else {
      setState(() {
        widget.dm.setToggleLoading(false);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void onSignIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        widget.dm.alertMissingInfo();
      });
      return;
    }

    setState(() {
      widget.dm.setToggleLoading(true);
    });
    final user =
        await auth_SignIn(_emailController.text, _passwordController.text);
    if (user != null) {
      setState(() {
        widget.dm.setToggleLoading(false);
      });
      nav_PushAndRemove(context, Groups(dm: widget.dm));
    } else {
      setState(() {
        widget.dm.setToggleLoading(false);
      });
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
              ButtonView(
                child: Row(
                  children: [
                    TextView(
                      text: 'sign up',
                      size: 20,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(Icons.arrow_forward),
                  ],
                ),
                onPress: () {
                  nav_Push(
                    context,
                    Signup(dm: widget.dm),
                  );
                },
              )
            ],
          ),
        ),
      ),
      // MAIN
      Expanded(
          child: ImageView(
        imagePath: 'assets/swirl1.jpg',
        width: double.infinity,
        objectFit: BoxFit.contain,
      )),
      PaddingView(
        child: SizedBox(
          height: 120,
          child: PagerView(activeDotColor: hexToColor("#FF1F54"), children: [
            PaddingView(
              child: Center(
                child: TextView(
                  text: 'Store your tasks on our cloud instead on your device.',
                  size: 20,
                  weight: FontWeight.w500,
                  wrap: true,
                ),
              ),
            ),
            PaddingView(
              child: Center(
                child: TextView(
                  text: 'Share your tasks with other people.',
                  size: 20,
                  weight: FontWeight.w500,
                  wrap: true,
                ),
              ),
            ),
            PaddingView(
              child: Center(
                child: TextView(
                  text: 'Access tasks on other devices.',
                  size: 20,
                  weight: FontWeight.w500,
                  wrap: true,
                ),
              ),
            )
          ]),
        ),
      ),
      PaddingView(
        child: Column(
          children: [
            TextfieldView(
              controller: _emailController,
              placeholder: 'Email',
              backgroundColor: hexToColor("#F6F8FA"),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10,
            ),
            TextfieldView(
              controller: _passwordController,
              placeholder: 'Password',
              backgroundColor: hexToColor("#F6F8FA"),
              isPassword: true,
            ),
            SizedBox(
              height: 10,
            ),
            PaddingView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonView(
                      child: TextView(
                        text: 'forgot password?',
                        size: 14,
                      ),
                      onPress: () async {
                        setState(() {
                          widget.dm.setToggleLoading(true);
                        });
                        final success =
                            await auth_ForgotPassword(_emailController.text);
                        if (success) {
                          setState(() {
                            widget.dm.setToggleLoading(false);
                            widget.dm.setToggleAlert(true);
                            widget.dm.setAlertTitle('Success!');
                            widget.dm.setAlertText(
                                'An email has been set to reset your password.');
                          });
                        } else {
                          setState(() {
                            widget.dm.setToggleLoading(false);
                            widget.dm.setToggleAlert(true);
                            widget.dm.setAlertTitle('Missing Email');
                            widget.dm
                                .setAlertText('Please provide a valid email.');
                          });
                        }
                      }),
                  ButtonView(
                    backgroundColor: Colors.black,
                    paddingTop: 8,
                    paddingBottom: 8,
                    paddingLeft: 18,
                    paddingRight: 18,
                    radius: 100,
                    child: TextView(
                      text: 'login',
                      size: 18,
                      color: Colors.white,
                    ),
                    onPress: () {
                      onSignIn();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),

      SizedBox(
        height: 10,
      )
    ]);
  }
}
