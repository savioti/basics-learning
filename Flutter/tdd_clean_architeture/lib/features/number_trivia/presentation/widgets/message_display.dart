import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    final double textContainerHeight =
        MediaQuery.of(context).size.height * 0.35;

    return SizedBox(
      height: textContainerHeight,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }
}
