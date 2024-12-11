import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TanGo {
  String word = "";
  String meaning = "";
  String pronunciation = "";
  int level = 0;

  TanGo.fromJson(Map<String, dynamic> json)
      : word = json["word"],
        meaning = json["meaning"],
        pronunciation = json["furigana"],
        level = json["level"];
}

class DailyTask {
  TanGoList tanGoList = TanGoList();
  final DateTime date;
  DailyTask({required this.date});
}

class TanGoList extends ModelList<TanGo> {
  List<dynamic> jsonArray = []; // 存储 JSON 数组,也就是原始数据

  /// 读取 JSON 数组
  Future<void> loadJsonArray(String level) async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/japanese/jlpt/$level.json');
      jsonArray = json.decode(jsonString); // 解析为 List
    } catch (e) {
      if (kDebugMode) {
        print('Error loading JSON: $e');
      }
    }
  }

  /// 随机抽取一个 単語 入栈
  Future<void> pickRandomTanGo() async {
    try {
      if (jsonArray.isNotEmpty) {
        Random random = Random();
        int randomIndex = random.nextInt(jsonArray.length);
        add(TanGo.fromJson(jsonArray[randomIndex]));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading JSON: $e');
      }
    }
  }

  TanGoList();
}

class ModelList<E> with ListMixin<E> {
  List<E> _list = [];

  @override
  int get length => _list.length;

  @override
  set length(int newLength) => _list.length = newLength;

  @override
  E operator [](int index) => _list[index];

  @override
  void operator []=(int index, E value) {
    _list[index] = value;
  }

  @override
  void insert(int index, E element) => _list.insert(index, element);

  @override
  void add(E element) => _list.add(element);

  @override
  void addAll(Iterable<E> iterable) => _list.addAll(iterable);

  @override
  bool remove(Object? element) => _list.remove(element);

  @override
  void clear() => _list.clear();
}
