import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaintSteps extends StatefulWidget {
  const PaintSteps({super.key});

  @override
  State<PaintSteps> createState() => PaintStepsState();
}

class PaintStepsState extends State<PaintSteps> {
  int _currentStep = 0;

  String currentLevel = "N1";
  int currentTime = 180;
  int currentStudyTimes = 6;

  static List<String> levelList = ["N1", "N2", "N3", "N4", "N5", "all"];
  static List<int> timeList = [180, 160, 140, 120, 100, 80, 60, 40, 20];
  static List<int> studyTimesPerWeek = [6, 5, 4, 3, 2, 1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: Stepper(
                controlsBuilder:
                    (BuildContext context, ControlsDetails controlsDetails) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: controlsDetails.onStepCancel,
                          child: const Text('上一步'),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: controlsDetails.onStepContinue,
                          child: const Text('下一步'),
                        ),
                      ],
                    ),
                  );
                },
                stepIconBuilder: (index, stepperState) {
                  switch (stepperState) {
                    case StepState.editing:
                      return Icon(
                        CupertinoIcons.hand_raised_fill,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSecondary,
                      );
                    case StepState.complete:
                      return Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSecondary,
                      );
                    case StepState.indexed:
                      return Text('${index + 1}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ));
                    case StepState.disabled:
                      return Text('${index + 1}');
                    case StepState.error:
                      return const Center(child: Text('!'));
                  }
                },
                type: StepperType.horizontal,
                currentStep: _currentStep,
                stepIconMargin: const EdgeInsets.all(0),
                elevation: 0,
                onStepContinue: () {
                  if (_currentStep < 3) {
                    setState(() {
                      _currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (_currentStep > 0) {
                    setState(() {
                      _currentStep -= 1;
                    });
                  }
                },
                steps: [
                  Step(
                    title: const Text(''),
                    content: Column(children: [
                      Text('选择学习内容',
                          style: Theme.of(context).textTheme.displaySmall),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height:
                            (MediaQuery.of(context).size.width - 60) / 3 * 2 +
                                30,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, //横轴三个子widget
                            childAspectRatio: 1.0, //宽高比为1时，子widget
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 30,
                          ),
                          children: levelList
                              .map(
                                (level) => GestureDetector(
                                  child: Container(
                                    decoration: level == currentLevel
                                        ? BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )
                                        : const BoxDecoration(),
                                    child: Center(
                                      child: Text(level,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      currentLevel = level;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ]),
                    isActive: _currentStep >= 0,
                    state: _currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text(''),
                    content: Column(children: [
                      Text('学习总天数',
                          style: Theme.of(context).textTheme.displaySmall),
                      const SizedBox(height: 60),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height:
                            (MediaQuery.of(context).size.width - 60) / 3 * 3 +
                                30,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, //横轴三个子widget
                            childAspectRatio: 1.0, //宽高比为1时，子widget
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 30,
                          ),
                          children: timeList
                              .map(
                                (time) => GestureDetector(
                                  child: Container(
                                    decoration: time == currentTime
                                        ? BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )
                                        : const BoxDecoration(),
                                    child: Center(
                                      child: Text(time.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      currentTime = time;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ]),
                    isActive: _currentStep >= 1,
                    state: _currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text(''),
                    content: Column(children: [
                      Text('一周学习几天',
                          style: Theme.of(context).textTheme.displaySmall),
                      const SizedBox(height: 60),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height:
                            (MediaQuery.of(context).size.width - 60) / 3 * 2 +
                                30,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, //横轴三个子widget
                            childAspectRatio: 1.0, //宽高比为1时，子widget
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 30,
                          ),
                          children: studyTimesPerWeek
                              .map(
                                (time) => GestureDetector(
                                  child: Container(
                                    decoration: time == currentStudyTimes
                                        ? BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )
                                        : const BoxDecoration(),
                                    child: Center(
                                      child: Text(time.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      currentStudyTimes = time;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ]),
                    isActive: _currentStep >= 2,
                    state: _currentStep > 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text(''),
                    content: Column(children: [
                      Text('总结',
                          style: Theme.of(context).textTheme.displaySmall),
                      const SizedBox(height: 60),
                      Column(children: [
                        // Text(),
                      ]),
                    ]),
                    isActive: _currentStep >= 3,
                    state: StepState.indexed,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
