import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stepper/data.dart';

class CasualMemorize extends StatefulWidget {
  const CasualMemorize({super.key});

  @override
  State<CasualMemorize> createState() => CasualMemorizeState();
}

class CasualMemorizeState extends State<CasualMemorize> {
  TanGoList tanGoList = TanGoList();
  int step = -1;
  String level = "N5";
  static List<String> levelList = ["N1", "N2", "N3", "N4", "N5", "all"];

  List<dynamic> jsonArray = []; // 存储 JSON 数组
  // 读取 JSON 数组
  Future<void> loadJsonArray() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/japanese/jlpt/$level.json');
      setState(() {
        jsonArray = json.decode(jsonString); // 解析为 List
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error loading JSON: $e');
      }
    }
  }

  // 随机抽取一个 単語 ,并前进一步
  void pickRandomTanGoAndStep() {
    if (jsonArray.isNotEmpty) {
      Random random = Random();
      int randomIndex = random.nextInt(jsonArray.length);
      setState(() {
        tanGoList.add(TanGo.fromJson(jsonArray[randomIndex]));
        step++;
      });
    }
  }

  @override
  initState() {
    super.initState();
    loadJsonArray().then((value) => pickRandomTanGoAndStep());
  }

  void showPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: ListWheelScrollView(
            itemExtent: 50,
            children: levelList
                .map((level) => GestureDetector(
                    child: Text(level),
                    onTap: () {
                      if (level != this.level) {
                        setState(() {
                          step = -1;
                          tanGoList.clear();
                          this.level = level;
                          loadJsonArray().then((value) {
                            pickRandomTanGoAndStep();
                          });
                        });
                      }
                      Navigator.of(context).pop();
                    }))
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.home_rounded,
                      color: Theme.of(context).colorScheme.secondary),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Padding(padding: EdgeInsets.only(left: 5)),
                GestureDetector(
                  behavior: HitTestBehavior.opaque, // 扩展点击区域
                  child: Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        level,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(
                      () {
                        showPicker();
                      },
                    );
                  },
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(CupertinoIcons.chevron_left_circle_fill,
                      size: 40, color: Theme.of(context).colorScheme.secondary),
                  onPressed: () {
                    step > 0
                        ? setState(() {
                            step--;
                          })
                        : null;
                  },
                  splashColor: Colors.transparent, // 去除水滴纹
                  highlightColor: Colors.transparent, // 去除高亮色
                ),
                const Padding(padding: EdgeInsets.only(left: 4)),
                Container(
                  height: MediaQuery.of(context).size.height - 170,
                  width: MediaQuery.of(context).size.width - 120,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(40)),
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(step >= 0 ? tanGoList[step].pronunciation : "",
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text(
                        step >= 0 ? tanGoList[step].word : "",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(step >= 0 ? tanGoList[step].meaning : "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  )),
                ),
                const Padding(padding: EdgeInsets.only(left: 4)),
                IconButton(
                  icon: Icon(CupertinoIcons.chevron_right_circle_fill,
                      size: 40, color: Theme.of(context).colorScheme.secondary),
                  onPressed: () {
                    setState(() {
                      pickRandomTanGoAndStep();
                    });
                  },
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
