import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: Colors.white),
        ), // SizedBox
        SizedBox(width: 10),
        Text("Loading...")
      ],
    );
  } // Row
}
