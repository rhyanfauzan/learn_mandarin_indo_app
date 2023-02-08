// ignore_for_file: must_be_immutable, avoid_print, prefer_typing_uninitialized_variables

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/theme.dart';

class CardWords extends StatefulWidget {
  CardWords({
    Key? key,
    this.nomor,
    this.pinyin,
    this.chinese = '',
    this.translate = '',
  }) : super(key: key);
  String? nomor;
  String? pinyin;
  String? chinese;
  String? translate;

  @override
  State<CardWords> createState() => _CardWordsState();
}

class _CardWordsState extends State<CardWords> {
  int indexColor = 0;
  Color bgWord = whiteColor;
  var prefs;
  final List<Color> bgWords = [
    redColor,
    purpleColor,
    primaryColor,
    limeColor,
    primary50Color,
    yellowPastelColor,
    creamColor,
    pinkColor,
    orangeColor,
    yellowColor,
    greenColor,
    darkRedColor,
    darkToscaColor,
    brownColor,
    lightBrownColor,
  ];

  initprefs() async {
    // Obtain shared preferences.
    prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('indexColor') != null) {
      indexColor = prefs.getInt('indexColor');
      bgWord = bgWords[indexColor];
    }
  }

  @override
  void initState() {
    initprefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    print("mWidth $mWidth");
    double fontSizeChinese;
    double fontSize;
    if (mWidth < 600) {
      fontSize = 28;
      fontSizeChinese = 48;
    } else {
      fontSize = 60;
      fontSizeChinese = 70;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: bgWord,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () async {
                  if (indexColor == bgWords.length - 1) {
                    indexColor = 0;
                    await prefs.setInt('indexColor', indexColor);
                    setState(() {
                      bgWord = bgWords[indexColor];
                    });
                  } else {
                    indexColor++;
                    await prefs.setInt('indexColor', indexColor);
                    setState(() {
                      bgWord = bgWords[indexColor];
                    });
                  }
                  print("bgWord $bgWord");
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Icon(
                    Icons.format_color_fill_rounded,
                    size: 24,
                    color: darkColor,
                  ),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: 20, vertical: 10),
              //   decoration: const BoxDecoration(
              //       color: primary50Color,
              //       borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(6),
              //           bottomRight: Radius.circular(20))),
              //   child: Text(
              //     nomor ?? '-',
              //     style: blackTextStyle.copyWith(
              //         fontSize: 20, fontWeight: medium, color: darkColor),
              //   ),
              // ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: mWidth / 2,
                  child: AutoSizeText(widget.chinese ?? '',
                      minFontSize: 20,
                      maxFontSize: 70,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: blackTextStyle.copyWith(
                          fontSize: fontSizeChinese, fontWeight: bold)),
                ),
                // Text(
                //   '${widget.chinese}',
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                //   style:
                //       blackTextStyle.copyWith(fontSize: 36, fontWeight: bold),
                // ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: mWidth / 2,
                  child: AutoSizeText(widget.pinyin ?? '',
                      minFontSize: 14,
                      maxFontSize: 70,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: blackTextStyle.copyWith(
                          fontSize: fontSize, fontWeight: regular)),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: mWidth / 2,
                  child: AutoSizeText(widget.translate ?? '',
                      minFontSize: 20,
                      maxFontSize: 70,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: blackTextStyle.copyWith(
                          fontSize: fontSize, fontWeight: regular)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
