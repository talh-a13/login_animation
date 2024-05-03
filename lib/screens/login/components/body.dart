import 'dart:async';
import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'land.dart';
import 'rounded_text_field.dart';
import 'sun.dart';
import 'tabs.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isFullSun = false;
  bool isDayMood = true;
  Duration _duration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isFullSun = true;
      });
    });
  }

  void changeMood(int activeTabNum) {
    if (activeTabNum == 0) {
      setState(() {
        isDayMood = true;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          isFullSun = true;
        });
      });
    } else {
      setState(() {
        isFullSun = false;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          isDayMood = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColors = [
      Color(0xFF8C2480),
      Color(0xFFCE587D),
      Color(0xFFFF9485),
      if (isFullSun) Color(0xFFFF9D80),
    ];
    var darkBgColors = [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ];
    return AnimatedContainer(
      duration: _duration,
      curve: Curves.easeInOut,
      width: double.infinity,
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDayMood ? lightBgColors : darkBgColors,
        ),
      ),
      child: Stack(
        children: [
          Sun(
            duration: _duration,
            isFullSun: isFullSun,
            key: UniqueKey(),
          ),
          Land(
            key: UniqueKey(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpacing(key: UniqueKey(), of: 50),
                  Tabs(
                    press: (value) {
                      changeMood(value);
                    },
                    key: UniqueKey(),
                  ),
                  VerticalSpacing(
                    key: UniqueKey(),
                  ),
                  Text(
                    "Good Morning",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ) ??
                        TextStyle(), // Add null check and provide a default TextStyle if null
                  ),
                  VerticalSpacing(
                    of: 10,
                    key: UniqueKey(),
                  ),
                  Text(
                    "Enter your Informations below",
                    style: TextStyle(color: Colors.white),
                  ),
                  VerticalSpacing(
                    of: 50,
                    key: UniqueKey(),
                  ),
                  RoundedTextField(
                    initialValue: "talhahussain@gmail.com",
                    hintText: "Email",
                    key: UniqueKey(),
                  ),
                  VerticalSpacing(
                    key: UniqueKey(),
                  ),
                  RoundedTextField(
                    initialValue: "talhadev",
                    hintText: "Password",
                    key: UniqueKey(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
