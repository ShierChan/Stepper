import 'package:flutter/material.dart';

class StepMemorize extends StatefulWidget {
  const StepMemorize({super.key});

  @override
  State<StepMemorize> createState() => StepMemorizeState();
}

class StepMemorizeState extends State<StepMemorize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: const Center(),
      ),
    );
  }
}
