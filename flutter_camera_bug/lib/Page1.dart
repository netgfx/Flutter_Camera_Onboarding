import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:camera/camera.dart';
import './LinePainter.dart';

import '../AuthData.dart';

//
import "../CameraView.dart";
import 'CameraView.dart';

class Page1 extends StatefulWidget {
  PageController pageController;
  Page1({required Key key, required this.pageController}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Image? frontPreview;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  void initState() {
    super.initState();

    print("page 1 init");
    _controller = CameraController(
        // Get a specific camera from the list of available cameras.
        Auth.shared.camera,
        // Define the resolution to use.
        ResolutionPreset.medium,
        enableAudio: false);

    // Next, initialize the controller. This returns a Future.
    initCamera();

    //openCamera();
  }

  void initCamera() async {
    _initializeControllerFuture = _controller.initialize();
    _initializeControllerFuture.then((value) => {
          _controller.setFlashMode(FlashMode.off),
          _controller.setFocusMode(FocusMode.auto),
          print("camera ready")
        });
  }

  void openCamera(BuildContext context) {
    var cameraResult = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraView(
                  key: UniqueKey(),
                  pageController: widget.pageController,
                  controller: _controller,
                  initializeControllerFuture: _initializeControllerFuture,
                  side: "frontImage",
                )));
    int frontImage;

    cameraResult.then((value) => {
          ///////////////

          ////////////////
        });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> navigateToPage(int pageIndex) async {
    if (widget.pageController.hasClients) {
      // send to SMS service
      widget.pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  Widget build(BuildContext context) {
    return Container(
        child: Container(
            child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.black,
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a snackbar')));
                    },
                  ),
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,

                              //fontWeight: FontWeight.bold,
                              //fontStyle: FontStyle.italic,
                              color: Color.fromARGB(240, 0, 0, 0)))
                    ],
                  ),
                  actions: [
                    // Icon(Icons.favorite),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 16),
                    //   child: Icon(Icons.search),
                    // ),
                    // Icon(Icons.more_vert),
                  ],
                  backgroundColor: Color.fromARGB(255, 229, 229, 229),
                ),
                backgroundColor: Colors.white,
                body: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return GestureDetector(
                      onTap: () {
                        // When running in iOS, dismiss the keyboard when any Tap happens outside a TextField
                        if (Platform.isIOS) hideKeyboard(context);
                      },
                      child: Container(
                          child: SingleChildScrollView(
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: viewportConstraints.maxHeight,
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          left: 16,
                                          right: 16,
                                          bottom: 16),
                                      child: Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Front",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      //fontStyle: FontStyle.italic,
                                                      color: Color.fromARGB(
                                                          240, 0, 0, 0))),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              frontPreview == null
                                                  ? Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: FittedBox(
                                                          fit: BoxFit.fitWidth,
                                                          child: ElevatedButton(
                                                            key: UniqueKey(),
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          65,
                                                                          75,
                                                                          178)),
                                                              textStyle: MaterialStateProperty.all<
                                                                      TextStyle>(
                                                                  TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16.0)),
                                                              padding: MaterialStateProperty.all(
                                                                  EdgeInsets.only(
                                                                      top: 20,
                                                                      bottom:
                                                                          20,
                                                                      left: 25,
                                                                      right:
                                                                          25)),
                                                            ),
                                                            onPressed: () {
                                                              openCamera(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Tap to add image',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )),
                                                    )
                                                  : Center(
                                                      child: SizedBox(
                                                          width:
                                                              viewportConstraints
                                                                  .maxWidth,
                                                          child: frontPreview)),
                                              SizedBox(
                                                height: 60,
                                              ),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: FittedBox(
                                                          fit: BoxFit.fitWidth,
                                                          child: ElevatedButton(
                                                            key: UniqueKey(),
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all<
                                                                          Color>(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          65,
                                                                          75,
                                                                          178)),
                                                              textStyle: MaterialStateProperty.all<
                                                                      TextStyle>(
                                                                  TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16.0)),
                                                              padding: MaterialStateProperty.all(
                                                                  EdgeInsets.only(
                                                                      top: 20,
                                                                      bottom:
                                                                          20,
                                                                      left: 25,
                                                                      right:
                                                                          25)),
                                                            ),
                                                            onPressed: () {
                                                              navigateToPage(5);
                                                            },
                                                            child: Text(
                                                              'Next',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )),
                                                    ),
                                                  ]),
                                            ]),
                                      ))))));
                }))));
  }
}
