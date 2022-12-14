import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            "Something Went Wrong",
            style: TextStyle(
              fontSize: 30,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
