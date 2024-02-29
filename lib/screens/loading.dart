import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupNewsApp() async {
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, '/home');
    });
  }

  @override
  void initState() {
    super.initState();
    setupNewsApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SpinKitPouringHourGlassRefined(
        color: Colors.orangeAccent,
        size: 50,
      )),
    );
  }
}
