import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class LoadingApp extends StatefulWidget {
  const LoadingApp({super.key});

  @override
  State<LoadingApp> createState() => _LoadingAppState();
}

class _LoadingAppState extends State<LoadingApp> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: double.infinity,
        height: MediaQuery.of(context).size.height/4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16),
            child:
            Center(
              child: LoadingAnimationWidget.discreteCircle(
                  color: Colors.greenAccent,
                  secondRingColor: Colors.orange,
                  thirdRingColor: Colors.purple, size: 40),
            )
        ),
      ),
    );
  }
}
