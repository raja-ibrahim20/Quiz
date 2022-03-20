import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {
  // const Difficulty({ Key? key }) : super(key: key);
  final String difficulty;
  Difficulty(this.difficulty);

  Widget printStar(bool level) {
    return level
        ? const Icon(
            Icons.favorite,
            color: Colors.black,
          )
        : const Icon(Icons.favorite_border);
  }

  @override
  Widget build(BuildContext context) {
    return difficulty == 'hard'
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            printStar(true),
            printStar(true),
            printStar(true),
          ])
        : difficulty == 'medium'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    printStar(true),
                    printStar(true),
                    printStar(false),
                  ])
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    printStar(true),
                    printStar(false),
                    printStar(false),
                  ]);
  }
}
