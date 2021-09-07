import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/material.dart';

// TODO : 정규식 표현 적고 스타일링
final Map<String, TextStyle> map = {
  r"@.\w+": TextStyle(color: Colors.blue),
  '(만약|이라면|아니라면|순서대로|상수|함수|형용사|동사|구조체)': const TextStyle(color: Colors.red),
  '꾸러미': TextStyle(
    color: Colors.green,
  ),
  '(와|과|으로|로|을|를|은|는|이|가|의)': TextStyle(
    color: Colors.purple,
  ),
  r'\\d': TextStyle(
    fontStyle: FontStyle.italic,
  ),
  r'(^[]$)': TextStyle(
    color: Colors.yellow,
  ),
  r'({|})': TextStyle(
    color: Colors.yellow,
  ),
  '(없음|참|거짓)': TextStyle(color: Colors.amber, shadows: kElevationToShadow[2]),
  r'(?<=\\[.*?\\])[가-힣]*?': TextStyle(
    color: Colors.white,
  ),
  r'(?<=((동사|함수|구조체)(.*?\\[.*?\\].*?)? ))[가-힣 ]*?:': TextStyle(
    color: Colors.blue,
  ),
};

class NuriHighLighter extends TextEditingController {
  final Pattern pattern = RegExp(
      map.keys.map((key) {
        return key;
      }).join('|'),
      multiLine: true);

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    List<TextSpan> children = [];
    String? patternMatched;
    TextStyle? nuriStyle;

    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        nuriStyle = map[match[0]] ??
            map[map.keys.firstWhere(
              (e) {
                bool ret = false;
                RegExp(e).allMatches(text)
                  ..forEach((element) {
                    if (element.group(0) == match[0]) {
                      patternMatched = e;
                      ret = true;
                    }
                  });
                return ret;
              },
            )];
        children.add(TextSpan(
          text: match[0],
          style: style!.merge(nuriStyle),
        ));
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );

    return TextSpan(style: style, children: children);
  }
}
