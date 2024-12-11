import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stepper/data.dart';
import 'package:stepper/widgets/normal_widgets.dart';

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

  bool isPronunciationAndMeaningVisible = false;

  @override
  initState() {
    super.initState();
    tanGoList.loadJsonArray(level).then(
          (value) => tanGoList.pickRandomTanGo().then(
                (_) => setState(
                  () {
                    step++;
                  },
                ),
              ),
        );
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
                          tanGoList.loadJsonArray(level).then(
                                (value) => tanGoList.pickRandomTanGo().then(
                                      (_) => setState(
                                        () {
                                          step++;
                                        },
                                      ),
                                    ),
                              );
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
                  hoverColor: Theme.of(context).colorScheme.onSurface,
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
                const Padding(padding: EdgeInsets.only(left: 5)),
                IconButton(
                  icon: Icon(
                    isPronunciationAndMeaningVisible
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    setState(() {
                      isPronunciationAndMeaningVisible =
                          !isPronunciationAndMeaningVisible;
                    });
                  },
                  hoverColor: Theme.of(context).colorScheme.onSurface,
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
                  hoverColor: Theme.of(context).colorScheme.onSurface,
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
                      FlexibleBlurContainer(
                          alwaysVisible: isPronunciationAndMeaningVisible,
                          child: Text(
                              step >= 0 ? tanGoList[step].pronunciation : "",
                              style:
                                  Theme.of(context).textTheme.headlineMedium)),
                      Text(
                        step >= 0 ? tanGoList[step].word : "",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      FlexibleBlurContainer(
                          alwaysVisible: isPronunciationAndMeaningVisible,
                          child: Text(step >= 0 ? tanGoList[step].meaning : "",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge)),
                    ],
                  )),
                ),
                const Padding(padding: EdgeInsets.only(left: 4)),
                IconButton(
                  icon: Icon(CupertinoIcons.chevron_right_circle_fill,
                      size: 40, color: Theme.of(context).colorScheme.secondary),
                  onPressed: () {
                    setState(() {
                      tanGoList.pickRandomTanGo().then(
                            (_) => setState(
                              () {
                                step++;
                              },
                            ),
                          );
                    });
                  },
                  hoverColor: Theme.of(context).colorScheme.onSurface,
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
