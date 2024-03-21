import 'package:flutter/material.dart';
import 'package:gitgraph/constants.dart';

class GitGraph extends StatelessWidget {
  const GitGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: AppConstants.fontFamily),
      home: Scaffold(),
    );
  }
}
