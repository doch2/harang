import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harang/controllers/nuripgController.dart';
import 'package:harang/themes/color_theme.dart';
import 'package:harang/themes/text_theme.dart';

//누리 놀이터 페이지
class NuriPlayGround extends GetWidget<NuripgController> {
  const NuriPlayGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 9,
                        width: 140,
                        color: mint,
                      ),
                    ),
                    Text(
                      "누리 놀이터",
                      style: np_title,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "코드",
                        style: np_subtitle,
                      ),
                      Obx(() => controller.isCompiling.value
                          ? loadingButton()
                          : buildCompileButton()),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: height * 0.25,
                    decoration: BoxDecoration(
                        color: Color(0xfff8FFFE),
                        border: Border.all(color: mint_shadow, width: 1),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: mint_shadow, blurRadius: 8)
                        ]),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusColor: Colors.amber,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "입력",
                    style: np_subtitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        color: Color(0xfff8FFFE),
                        border: Border.all(color: mint_shadow, width: 1),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: mint_shadow, blurRadius: 8)
                        ]),
                    child: TextField(
                      style: codetext,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusColor: Colors.amber,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "출력",
                    style: np_subtitle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: height * 0.17,
                    width: width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Color(0xfff8FFFE),
                        border: Border.all(color: mint_shadow, width: 1),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: mint_shadow, blurRadius: 8)
                        ]),
                    child: SingleChildScrollView(
                        child: Text(
                      "결과입니다",
                      style: codetext,
                    )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingButton() {
    return Hero(
        tag: "compilebutton",
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: mint, width: 1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: mint_shadow, blurRadius: 8)]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              color: mint,
            ),
          ),
        ));
  }

  GestureDetector buildCompileButton() {
    return GestureDetector(
      onTap: () {
        controller.isCompiling.value = true;
        Future.delayed(Duration(milliseconds: 2000))
            .then((value) => controller.isCompiling.value = false);
      },
      child: Hero(
        tag: "compilebutton",
        transitionOnUserGestures: true,
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: mint, width: 1),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(color: mint_shadow, blurRadius: 8)]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              Container(
                child: Icon(
                  Icons.play_circle,
                  color: mint,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "실행하기",
                style: np_btn,
              )
            ],
          ),
        ),
      ),
    );
  }
}
