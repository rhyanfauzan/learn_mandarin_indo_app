// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter/services.dart';
import '../model/kosakata_model.dart';

class LmiService {
  //fetch content from json file
  Future<KosaKataModel> readWords(int index) async {
    final response =
        await rootBundle.loadString('assets/data/kosakata$index.json');
    if (response != null) {
      final data = await jsonDecode(response);

      print("berhasil fetch Words $index");
      print(data[2]);
      return KosaKataModel.fromJson(data[2]);
    } else {
      print("gagal fetch Words $index");
      return KosaKataModel.fromJson(jsonDecode(response));
    }
  }

  //fetch content from json file 20000
  Future<KosaKataModel> readWords20000() async {
    final response =
        await rootBundle.loadString('assets/data/kosakata20000.json');
    final data = await jsonDecode(response);

    print("berhasil fetch Words 20000");
    print(data[2]);
    return KosaKataModel.fromJson(data[2]);
  }
}
