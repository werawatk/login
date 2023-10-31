import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class MyWelcome extends StatefulWidget {
  const MyWelcome({super.key});

  @override
  State<MyWelcome> createState() => _MyWelcomeState();
}

class _MyWelcomeState extends State<MyWelcome> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 89, 158, 214),
      body: Center(
        child: Container(
          width: 380,
          height: 380,
          child: Row(
            children: [
              Lottie.network(
                  'https://lottie.host/c3bf459f-e784-4a22-a69d-2fe21096db2d/sBXCA0bzRS.json',
                  controller: _controller, onLoaded: (composition) {
                // Configure the AnimationController with the duration of the
                // Lottie file and start the animation.
                _controller
                  ..duration = composition.duration
                  ..forward().then((value) =>
                      Navigator.pushReplacementNamed(context, 'login'));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
