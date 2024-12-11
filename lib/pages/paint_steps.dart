import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaintSteps extends StatefulWidget {
  const PaintSteps({super.key});

  @override
  State<PaintSteps> createState() => PaintStepsState();
}

class PaintStepsState extends State<PaintSteps> {
  int _currentStep = 0;

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
                  if (_currentStep < 2) {
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
                      Text('您想学习什么内容？',
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Wrap(
                          spacing: 8.0, // 主轴(水平)方向间距
                          runSpacing: 4.0, // 纵轴（垂直）方向间距
                          alignment: WrapAlignment.center, //沿主轴方向居中
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
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
                    content: const Text('这是第二个步骤的内容'),
                    isActive: _currentStep >= 1,
                    state: _currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text(''),
                    content: const Text('这是第三个步骤的内容'),
                    isActive: _currentStep >= 2,
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
