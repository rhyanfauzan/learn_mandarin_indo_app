// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';
import 'package:mandarin_indo_app/config/app_asset.dart';
import 'package:mandarin_indo_app/config/theme.dart';
import 'package:mandarin_indo_app/feature/widgets/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/model/kosakata_model.dart';
import '../../core/services/lmi_service.dart';
import 'word_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var prefs;
  int? mypageword;
  int? myindexword;
  LmiService lmiService = LmiService();
  late Future<KosaKataModel> selectFetch;

  initprefs() async {
    // Obtain shared preferences.
    prefs = await SharedPreferences.getInstance();

    setState(() {
      // Try reading data from the 'mypageword & myindexword' key. If it doesn't exist, returns null.
      mypageword = prefs.getInt('mypageword');
      myindexword = prefs.getInt('myindexword');
      print('mypageword $mypageword');
      print('myindexword $myindexword');
    });
  }

  @override
  void initState() {
    initprefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width - 0.2;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              AppAsset.ilChinese,
              width: mWidth,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Hello, \nWelcome Back!',
              style: blackTextStyle.copyWith(
                  fontSize: 24, fontWeight: bold, color: darkColor),
            ),
            Text(
              'What do you want to learn today?',
              style: greyTextStyle.copyWith(fontSize: 18, fontWeight: regular),
            ),
            const SizedBox(
              height: 40,
            ),
            CustomFilledButton(
              title: "Continue Learn",
              bgColor: greenColor,
              onPressed: () {
                if (mypageword != null && mypageword! <= 30) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WordsPage(
                        title: "$mypageword",
                        selectFetch: lmiService.readWords(mypageword!),
                        mypageword: mypageword!,
                        indexWord: prefs.getInt('myindexword') ?? 0);
                  }));
                } else if (mypageword != null && mypageword! == 31) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WordsPage(
                        title: "20000",
                        selectFetch: lmiService.readWords20000(),
                        mypageword: mypageword!,
                        indexWord: prefs.getInt('myindexword') ?? 0);
                  }));
                } else {
                  var snackBar = SnackBar(
                    backgroundColor: darkGreyColor,
                    content: Text(
                      "Anda belum menyimpan history belajar",
                      style: whiteTextStyle,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              slivers: [
                SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 5,
                  children: [
                    for (int index = 1; index <= 5; index++)
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WordsPage(
                              selectFetch: lmiService.readWords(index),
                              mypageword: index,
                              title: "$index",
                            );
                          }));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          color: blue400Color,
                          child: Text(
                            index.toString(),
                            style: whiteTextStyle.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFilledButton(
              title: "20000 Kata",
              bgColor: blue400Color,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WordsPage(
                    selectFetch: lmiService.readWords20000(),
                    mypageword: 31,
                    title: "20000 Kata",
                  );
                }));
              },
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
