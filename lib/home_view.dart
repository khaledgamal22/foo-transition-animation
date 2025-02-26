import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _blueAnimationController;
  late AnimationController _blackAnimationController;
  late Animation<AlignmentGeometry> _blueAlignmentAnimation;
  late Animation<AlignmentGeometry> _blackAlignmentAnimation;

  @override
  void initState() {
    _blueAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 4),
    );
    _blackAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 4),
    );
    _blueAlignmentAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(_blueAnimationController);
    _blackAlignmentAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(_blackAnimationController);
    _blueAnimationController.addStatusListener((status) {
      if ((status == AnimationStatus.completed) &&
          (_blackAnimationController.status == AnimationStatus.dismissed)) {
        _blackAnimationController.forward();
      }
      if ((status == AnimationStatus.dismissed) &&
          (_blackAnimationController.status == AnimationStatus.completed)) {
        _blackAnimationController.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FOO TRANSITION ANIMATION'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  AlignTransition(
                    alignment: _blueAlignmentAnimation,
                    child: const CircleAvatar(
                        radius: 20, backgroundColor: Colors.blueAccent),
                  ),
                  AlignTransition(
                    alignment: _blackAlignmentAnimation,
                    child: const CircleAvatar(
                        radius: 20, backgroundColor: Colors.black),
                  ),
                ],
              ),
            ),
            Wrap(
              children: [
                ElevatedButton(
                  child: const Text('Forward'),
                  onPressed: () {
                    _blueAnimationController.forward();
                  },
                ),
                ElevatedButton(
                  child: const Text('Reverse'),
                  onPressed: () {
                    _blueAnimationController.reverse();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
