import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  // const Result({Key? key}) : super(key: key);

  final int correct;
  final VoidCallback reset;
  Result(this.correct, this.reset);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CircleAvatar(
            radius: 75,
            child: Text(
              correct.toString(),
              style: TextStyle(fontSize: 96),
            )),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "OUT OF 20",
          textAlign: TextAlign.center,
        ),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text("Are You Sure!"),
                        content: const Text(
                            "Do you really want to restart the quiz?"),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("No"),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          TextButton(
                            child: const Text("Yes"),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      )).then((value) {
                if (value == true) {
                  reset();
                  return;
                }
              });
            },
            icon: const Icon(Icons.replay))
      ],
    );
  }
}
