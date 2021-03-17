import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:camera/camera.dart';
import './LinePainter.dart';
import 'AuthData.dart';

class CameraView extends StatefulWidget {
  late Future<void> initializeControllerFuture;
  PageController pageController;
  late CameraController controller;
  String side = "frontImage";
  CameraView(
      {required Key key,
      required this.initializeControllerFuture,
      required this.pageController,
      required this.controller,
      required this.side})
      : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  void initState() {
    super.initState();
    print(widget.controller.description);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void takePicture() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await widget.initializeControllerFuture;

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final image = await widget.controller.takePicture();
      if (image == null) return;
      var _image = await image.readAsBytes();
      String base64Image = base64Encode(_image);
      String fileName = image.path.split("/").last;
      Navigator.pop(context, ["arguments"]);
      print(fileName);
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * widget.controller.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    final deviceRatio = size.width / size.height;
    final xScale = widget.controller.value.aspectRatio / deviceRatio;
    final yScale = 1.0;
// Modify the yScale if you are in Landscape

    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Container(
            child: Stack(children: [
          ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: CustomPaint(
                  foregroundPainter: LinePainter(),
                  child: Transform.scale(
                      scale: scale,
                      child: Center(
                        child: CameraPreview(widget.controller),
                      )))),
          Positioned(
              top: 50,
              width: viewportConstraints.maxWidth,
              child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    iconSize: 32,
                    icon: Icon(Icons.close),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context, ["arguments"]);
                    },
                  ))),
          Positioned(
              bottom: 50,
              width: viewportConstraints.maxWidth,
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: ElevatedButton(
                      key: UniqueKey(),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 20, bottom: 20, left: 25, right: 25)),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(
                                color: Color.fromARGB(255, 65, 75, 178),
                                fontSize: 16.0)),
                        side: MaterialStateProperty.all<BorderSide>(BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 65, 75, 178),
                        )),
                      ),
                      onPressed: () {
                        takePicture();
                      },
                      child: Text(
                        'Take Photo',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 65, 75, 178)),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ))
        ]));
      }),
    );
  }
}
