import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';
import 'package:harang/utils/root.dart';

class RequirePermission extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffF8C0FC),
              Color(0xffF6E1FA),
              Color(0xffF4EBFD),
              Color(0xffEFDEFB),
              Color(0xffEDB1F1)
            ]
        )
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: _width * 0.218,
                height: _width * 0.218,
                margin: EdgeInsets.only(bottom: _height * 0.06),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: _width * 0.175,
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 9,
                      width: 300,
                      color: Color(0xffEDB1F1),
                    ),
                  ),
                  Text(
                      "???????????? ?????? ??????",
                      style: permissionPage_title
                  )
                ],
              ),
              SizedBox(height: _height * 0.05),
              Text(
                "????????? ?????? ????????? ?????? ????????? ?????? ?????????\n????????? ????????? ?????????.",
                style: permissionPage_description,
                textAlign: TextAlign.center,
              ),
              Container(
                width: _width * 0.752,
                height: _height * 0.2,
                margin: EdgeInsets.only(top: _height * 0.04, bottom: _height * 0.1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "?????? ?????? ??????",
                          style: permissionPage_boxTitle
                        ),
                        SizedBox(width: _width * 0.04),
                        FlutterSwitch(
                          height: _height * 0.035,
                          width: _width * 0.12,
                          padding: 2.0,
                          toggleSize: _width * 0.05,
                          borderRadius: 16.0,
                          activeColor: Colors.lightBlue,
                          value: false,
                          onToggle: (value) {},
                        ),
                      ],
                    ),
                    SizedBox(height: _height * 0.015),
                    Text(
                      "????????? ?????? ?????? ?????? ????????? ?????? ???????????????\n??????????????? ????????? ?????????, ?????? ?????? ??? ??????\n?????? ???????????? ???????????????.",
                      style: permissionPage_boxDescription,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => getUsageAccessPermission(),
                child: Container(
                  width: _width * 0.562,
                  height: _height * 0.075,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color(0xB3FFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: hallOfFame_shadow,
                          offset: Offset(-4, 4),
                          blurRadius: 20,
                        )
                      ]
                  ),
                  child: Text(
                    "?????? ???????????? ??????",
                    style: permissionPage_buttonText,
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Future<void> getUsageAccessPermission() async {
    await AppUsage.getAppUsage(DateTime.now(), DateTime.now()); //???????????? ?????? ????????? ???????????? ?????????????????? ??????, ?????? ????????? ????????? ???????????? AppUsage ????????? ????????? ?????????.

    Get.offAll(Root());
  }

}