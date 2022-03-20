import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Widgets/difficulty.dart';
import '../Widgets/upper_bar.dart';
import '../Widgets/bottom_bar.dart';
import '../Widgets/result.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;
  bool? check;
  int index = 0;
  int correct = 0;
  bool isInit = true;
  var question = {};
  int score = 0;
  int maxScore = 100;
  int stateCorrect = 0;

  Widget _button(String text, bool ans) {
    return OutlinedButton(
      onPressed: () {
        if (check == null) {
          setState(() {
            if (text == question['correct_answer']) {
              correct++;
              check = true;
            } else {
              check = false;
            }
          });
        }
      },
      child: FittedBox(
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      style: check == null
          ? OutlinedButton.styleFrom(primary: Colors.black)
          : ans == false
              ? OutlinedButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.red[400])
              : OutlinedButton.styleFrom(
                  primary: Colors.white, backgroundColor: Colors.green[400]),
    );
  }

  void reset() {
    setState(() {
      isLoading = true;
      score = 0;
      maxScore = 100;
      index = 0;
      correct = 0;
      stateCorrect = 0;
    });
    getData();
  }

  Future<void> getData() {
    var url = Uri.parse(
        'https://project1-5aa26-default-rtdb.firebaseio.com/${index}.json');
    return http.get(url).then((response) {
      question = json.decode(response.body);
      // print(question);
    }).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: UpperBar(index, size),
        title: const Text("Quiz"),
      ),
      // const Text("Quiz"),

      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : index < 20
              ? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // UpperBar(index, size),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: size * 0.1,
                        child: FittedBox(
                          child: Text(
                            "Question ${(index + 1).toString()} of 20",
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          height: size * 0.05,
                          child: FittedBox(child: Text(question['category']))),
                      SizedBox(
                          height: size * 0.05,
                          child: Difficulty(question['difficulty'])),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: size * 0.175,
                        child: Text(question['question'],
                            style: const TextStyle(fontSize: 16)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? size * 0.3
                            : 300,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            childAspectRatio: 10 / 3,
                          ),
                          itemCount: question['_answers'].length,
                          itemBuilder: (context, i) => _button(
                              question['_answers'][i],
                              question['_answers'][i] ==
                                  question['correct_answer']),
                        ),
                      ),
                      if (check == true)
                        const Text(
                          "CORRECT!",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      if (check == false)
                        const Text("OOPS!",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      if (check != null)
                        TextButton(
                            onPressed: () {
                              setState(() {
                                score = ((correct / (index + 1)) * 100).toInt();
                                maxScore =
                                    (((correct + (20 - (index + 1))) / 20) *
                                            100)
                                        .toInt();
                                stateCorrect = correct;
                                isLoading = true;
                                index++;
                              });
                              if (index < 20) {
                                getData();
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                              // if (check == null) {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(
                              //           duration: Duration(seconds: 1),
                              //           content:
                              //               Text("PLEASE PROVIDE AN ANSWER.")));
                              // }
                              check = null;
                            },
                            child: const Text("Next Question")),
                    ],
                  ),
                )
              : Result(correct, reset),
      bottomNavigationBar: BottomBar(index, stateCorrect),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: <Widget>[
            Text("Score: $score %"),
            const Spacer(),
            Text("Max Score: $maxScore%"),
          ],
        ),
      ),
    );
  }
}
