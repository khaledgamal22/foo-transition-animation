import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<AlignmentGeometry> _blueAlignmentAnimation;
  late Animation<AlignmentGeometry> _blackAlignmentAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 4),
    );
    _blueAlignmentAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(_animationController);
    _blackAlignmentAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(_animationController);
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
                    _animationController.forward();
                  },
                ),
                ElevatedButton(
                  child: const Text('Reverse'),
                  onPressed: () {
                    _animationController.reverse();
                  },
                ),
                ElevatedButton(
                  child: const Text('Stop'),
                  onPressed: () {
                    _animationController.stop();
                  },
                ),
                ElevatedButton(
                  child: const Text('Reset'),
                  onPressed: () {
                    _animationController.reset();
                  },
                ),
                ElevatedButton(
                  child: const Text('Repeat(reverse=false)'),
                  onPressed: () {
                    _animationController.repeat(
                      reverse: false,
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Repeat(reverse=true)'),
                  onPressed: () {
                    _animationController.repeat(
                      reverse: true,
                    );
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
