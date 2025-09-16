import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.35;

    return SizedBox(
      height: height,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
