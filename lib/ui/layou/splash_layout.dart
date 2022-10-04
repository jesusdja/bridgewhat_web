import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/main.dart';
import 'package:bridgewhat_web/widgets_utils/circular_progress_colors.dart';
import 'package:flutter/material.dart';

class SplashLayout extends StatelessWidget {
  const SplashLayout({Key? key}) : super(key: key);

  Future<bool> exit() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {

    sizeH = MediaQuery.of(context).size.height;
    sizeW = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: FittedBox(
            fit:BoxFit.contain,
            child: SizedBox(
              width: sizeW,
              height: sizeH,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    constraints: const BoxConstraints(minHeight: 200, minWidth: 200),
                    margin: EdgeInsets.symmetric(horizontal: sizeW * 0.2),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('assets/image/icon_app.png').image,
                            fit: BoxFit.fitHeight
                        )
                    ),
                  ),
                  circularProgressColors(widthContainer1: sizeW,widthContainer2: sizeH * 0.03,colorCircular: AcademyColors.primary)
                ],
              ),
            ),
          ),
        ),
        onWillPop: exit
    );
  }
}