import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  // const BottomBar({Key? key}) : super(key: key);
  final int index;
  final int correct;
  BottomBar(this.index, this.correct);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        Container(
          height: 10,
          width: double.infinity,
          color: Colors.grey,
        ),
        Container(
          height: 10,
          width: (MediaQuery.of(context).size.width) *
              (correct + (20 - index)) /
              20,
          color: Colors.green,
        ),
        Container(
          height: 10,
          width: index != 0
              ? (correct / index) * (MediaQuery.of(context).size.width)
              : 0,
          color: Colors.amber,
        ),
        Container(
          height: 10,
          width: (MediaQuery.of(context).size.width) * (correct / 20),
          color: Colors.red,
        ),
      ],
    );
  }
}
