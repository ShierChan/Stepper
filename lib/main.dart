import 'package:flutter/material.dart';
import 'package:stepper/color.dart';
import 'package:stepper/pages/casual_memorize.dart';
import 'package:stepper/pages/paint_steps.dart';
import 'package:stepper/pages/step_memorize.dart';

void main() {
  runApp(const Stepper());
}

class Stepper extends StatelessWidget {
  const Stepper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlobalTheme.lightThemeData,
      darkTheme: GlobalTheme.darkThemeData,
      themeMode: ThemeMode.system,
      home: const StepperRoot(),
    );
  }
}

class StepperRoot extends StatefulWidget {
  const StepperRoot({super.key});

  @override
  State<StepperRoot> createState() => _StepperRootState();
}

class _StepperRootState extends State<StepperRoot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: ClipOval(
                  child: Container(
                    height: (MediaQuery.of(context).size.height +
                            MediaQuery.of(context).size.width) *
                        0.15,
                    width: (MediaQuery.of(context).size.height +
                            MediaQuery.of(context).size.width) *
                        0.15,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    child: Center(
                      child: Text(
                        "Casual",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return const CasualMemorize();
                      },
                    ),
                  );
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              GestureDetector(
                child: ClipOval(
                  child: Container(
                    height: (MediaQuery.of(context).size.height +
                            MediaQuery.of(context).size.width) *
                        0.15,
                    width: (MediaQuery.of(context).size.height +
                            MediaQuery.of(context).size.width) *
                        0.15,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    child: Center(
                      child: Text(
                        "Step",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return const PaintSteps();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
