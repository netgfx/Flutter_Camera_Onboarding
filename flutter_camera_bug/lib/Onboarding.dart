import 'dart:async';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:convert';

// pages //
import 'Page1.dart';
import 'CameraView.dart';
import 'Page2.dart';

class Onboarding extends StatefulWidget {
  Onboarding({required Key key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  final controller = PageController(initialPage: 0);

  ////
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        /// [PageView.scrollDirection] defaults to [Axis.horizontal].
        /// Use [Axis.vertical] to scroll vertically.
        scrollDirection: Axis.horizontal,
        controller: controller,
        children: [
          Center(
            child: Page1(
              key: UniqueKey(),
              pageController: controller,
            ),
          ),
          Center(
            child: Page2(
              key: UniqueKey(),
              pageController: controller,
            ),
          )
        ],
      ),
    );
  }
}
