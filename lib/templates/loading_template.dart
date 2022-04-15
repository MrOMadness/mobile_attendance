import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Template for rounded box
class LoadingTemplate extends StatelessWidget {
  const LoadingTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      child: Center(
          child: LoadingAnimationWidget.prograssiveDots(
        color: Colors.lightBlue,
        size: 50,
      )),
    );
  }
}
