import 'package:avatar_view/avatar_view.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io' as Platform;

class cameraWithMaskFilterScreen extends StatefulWidget {
  @override
  _cameraWithMaskFilterScreenState createState() => _cameraWithMaskFilterScreenState();
}

class _cameraWithMaskFilterScreenState extends State<cameraWithMaskFilterScreen> {
  CameraDeepArController cameraDeepArController;
  String platformVersion="Unknown";
  int currentPage=0;
  final vp=PageController(viewportFraction: .24);
  Effects currentEffects = Effects.none;
  Filters currentFilters = Filters.none;
  Masks currentMasks = Masks.none;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [

            // Deep AR Camera
            CameraDeepAr(
              onCameraReady: (isReady)
              {
                platformVersion = "Camera Status $isReady";
                print(platformVersion);
                setState(() {

                });
              },
              onImageCaptured: (path)
              {
                platformVersion = "Camera Status $path";
                print(platformVersion);
                setState(() {

                });
              },
              iosLicenceKey: "1d660320a860bdf999b1390059fdb7cc85579a43e8c3d81ccf207b20d744b4fd3e4e427fac48a06b",
              androidLicenceKey: "b5597a97052a4e9c5055051535ea29a5a299fbcb40fca1ab626a88451ea088e85259dc168b86c1e3",
              cameraDeepArCallback: (c) async
              {
                cameraDeepArController = c;
                setState(() {

                });
              },
            ),

            //Face Mask Filter - Image Buttons
            Align(
              alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 28.0, right: 28.0),
                        child: Expanded(
                          child: FlatButton(
                            child: Icon(Icons.camera_enhance),
                            color: Colors.white54,
                            padding: EdgeInsets.all(15.0),
                            onPressed: ()
                            {
                              if(null==cameraDeepArController)
                                {
                                  return;
                                }
                              cameraDeepArController.snapPhoto();
                            },
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection : Axis.horizontal,
                        child: Row(
                          children: List.generate(8, (page)
                          {
                            bool active = currentPage == page;

                            return Platform.Platform.isIOS
                                //ios app view
                              ? GestureDetector(
                              onTap: ()
                              {
                                currentPage = page;
                                cameraDeepArController.changeMask(page);
                                setState(() {

                                });
                              },
                              child: AvatarView(
                                radius: active ? 65:30,
                                borderColor: Colors.yellow,
                                borderWidth: 2,
                                isOnlyText: false,
                                avatarType: AvatarType.CIRCLE,
                                backgroundColor: Colors.red,
                                imagePath: "assets/ios/${page.toString()}.jpg",
                                placeHolder: Icon(Icons.person,size: 50,),
                                errorWidget: Container(child: Icon(Icons.error,size: 50,),),
                              ),
                            )

                                //android app view
                            :GestureDetector(
                              onTap: ()
                              {
                                currentPage = page;
                                cameraDeepArController.changeMask(page);
                                setState(() {

                                });
                              },
                              child: AvatarView(
                                radius: active ? 45:25,
                                borderColor: Colors.yellow,
                                borderWidth: 2,
                                isOnlyText: false,
                                avatarType: AvatarType.CIRCLE,
                                backgroundColor: Colors.red,
                                imagePath: "assets/android/${page.toString()}.jpg",
                                placeHolder: Icon(Icons.person,size: 50,),
                                errorWidget: Container(child: Icon(Icons.error,size: 50,),),
                              ),
                            );

                          }),
                        ),
                      )
                    ],
                  ),
                ),
            )
          ],

        ),
      ),
    );
  }
}
