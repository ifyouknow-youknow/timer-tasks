import 'package:flutter/material.dart';
import 'package:timer_tasks/COMPONENTS/border_view.dart';
import 'package:timer_tasks/COMPONENTS/button_view.dart';
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
import 'package:timer_tasks/VIEWS/groups.dart';

class Signup extends StatefulWidget {
  final DataMaster dm;
  const Signup({super.key, required this.dm});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
//
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void onSignUp() async {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      setState(() {
        widget.dm.alertMissingInfo();
      });
      return;
    }

    if (_passwordController.text.length < 8) {
      setState(() {
        widget.dm.setToggleAlert(true);
        widget.dm.setAlertTitle('8 characters minimum');
        widget.dm
            .setAlertText('Password must be at least 8 characters minimum.');
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        widget.dm.setToggleAlert(true);
        widget.dm.setAlertTitle('Passwords must match');
        widget.dm.setAlertText('Please make sure your passwords match.');
      });
      return;
    }

    setState(() {
      widget.dm.setToggleAlert(false);
      widget.dm.setToggleLoading(true);
    });

    final user =
        await auth_CreateUser(_emailController.text, _passwordController.text);

    if (user != null) {
      final success =
          await firebase_CreateDocument('${appName}_Users', user.uid, {
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'shareCode': randomString(8).toUpperCase()
      });
      if (success) {
        setState(() {
          widget.dm.setToggleLoading(false);
          nav_PushAndRemove(context, Groups(dm: widget.dm));
        });
      } else {
        setState(() {
          widget.dm.setToggleLoading(false);
          widget.dm.alertSomethingWrong();
        });
      }
    } else {
      setState(() {
        widget.dm.setToggleLoading(false);
        widget.dm.alertSomethingWrong();
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
            child: ButtonView(
          onPress: () {
            nav_Pop(context);
          },
          child: Row(
            children: [
              Icon(Icons.arrow_back),
              SizedBox(
                width: 6,
              ),
              TextView(
                text: 'back',
                size: 20,
                weight: FontWeight.w500,
              )
            ],
          ),
        )),
      ),
      // MAIN
      Expanded(
        child: PaddingView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: 'full name',
                size: 15,
              ),
              SizedBox(
                height: 6,
              ),
              TextfieldView(
                controller: _fullNameController,
                placeholder: 'ex. John Doe',
                backgroundColor: hexToColor("#F6F8FA"),
              ),
              SizedBox(
                height: 10,
              ),
              TextView(
                text: 'email',
                size: 15,
              ),
              SizedBox(
                height: 6,
              ),
              TextfieldView(
                controller: _emailController,
                placeholder: 'ex. jdoe@gmail.com',
                backgroundColor: hexToColor("#F6F8FA"),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10,
              ),
              TextView(
                text: 'password',
                size: 15,
              ),
              SizedBox(
                height: 6,
              ),
              TextfieldView(
                controller: _passwordController,
                placeholder: '8 characters minimum',
                backgroundColor: hexToColor("#F6F8FA"),
                isPassword: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextView(
                text: 'confirm password',
                size: 15,
              ),
              SizedBox(
                height: 6,
              ),
              TextfieldView(
                controller: _confirmPasswordController,
                placeholder: 'passwords must match',
                backgroundColor: hexToColor("#F6F8FA"),
                isPassword: true,
              )
            ],
          ),
        ),
      ),
      //
      PaddingView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ButtonView(
              paddingTop: 8,
              paddingBottom: 8,
              paddingLeft: 18,
              paddingRight: 18,
              radius: 100,
              backgroundColor: Colors.black,
              child: TextView(
                text: 'sign up',
                color: Colors.white,
                size: 18,
                weight: FontWeight.w500,
              ),
              onPress: () {
                onSignUp();
              },
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }
}
