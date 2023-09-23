import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'main.dart';

class MyProject extends StatefulWidget {
  final String id_, question_, aa_, bb_, cc_, dd_, answer_;
  const MyProject(
      {Key? key,
      required this.id_,
      required this.question_,
      required this.aa_,
      required this.bb_,
      required this.cc_,
      required this.dd_,
      required this.answer_})
      : super(key: key);
  @override
  State<MyProject> createState() => _MyProjectState();
}

//DECLARE GLOBAL PARAM
enum ANSWER { a, b, c, d, e }

ANSWER? _quizAnswer = ANSWER.e; //Default Answer
var statusController;

TextEditingController idController = TextEditingController();
TextEditingController answerController = TextEditingController();
TextEditingController questionController = TextEditingController();
TextEditingController correctController = TextEditingController();

class _MyProjectState extends State<MyProject> {
  Future<void> _select() async {
    if (_quizAnswer.toString() == widget.answer_.toString()) {
      statusController = "TRUE";
    } else {
      statusController = "FALSE";
    }

    final url = Uri.parse("http://192.168.100.100:8087/quiz/save_answer.php");

    var sendUrlParam = await http.post(url, body: {
      "idController": widget.id_.toString(),
      "answerController": _quizAnswer.toString(),
      "correctController": widget.answer_.toString(),
      "statusController": statusController.toString(),
    });

    final dataReturn = jsonDecode(sendUrlParam.body);

    if (dataReturn.isNotEmpty) {
      print(dataReturn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("QUIZ ONLINE")),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Question No." + widget.id_,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.question_,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),

          //......................................................................
          ListTile(
            title: Row(
              children: [
                Text("a.   "),
                Expanded(child: Text(widget.aa_)),
              ],
            ),
            leading: Radio<ANSWER>(
              value: ANSWER.a,
              groupValue: _quizAnswer,
              onChanged: (ANSWER? value) {
                setState(() {
                  _quizAnswer = value;
                });
              },
            ),
          ),
          //......................................................................
          ListTile(
            title: Row(
              children: [
                const Text("b.   "),
                Expanded(child: Text(widget.bb_)),
              ],
            ),
            leading: Radio<ANSWER>(
              value: ANSWER.b,
              groupValue: _quizAnswer,
              onChanged: (ANSWER? value) {
                setState(() {
                  _quizAnswer = value;
                });
              },
            ),
          ),
          //......................................................................
          ListTile(
            title: Row(
              children: [
                const Text("c.   "),
                Expanded(child: Text(widget.cc_)),
              ],
            ),
            leading: Radio<ANSWER>(
              value: ANSWER.c,
              groupValue: _quizAnswer,
              onChanged: (ANSWER? value) {
                setState(() {
                  _quizAnswer = value;
                });
              },
            ),
          ),
          //......................................................................
          ListTile(
            title: Row(
              children: [
                const Text("d.   "),
                Expanded(child: Text(widget.dd_)),
              ],
            ),
            leading: Radio<ANSWER>(
              value: ANSWER.d,
              groupValue: _quizAnswer,
              onChanged: (ANSWER? value) {
                setState(() {
                  _quizAnswer = value;
                });
              },
            ),
          ),
          //......................................................................
          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(120, 2, 120, 2),
            child: ElevatedButton(
                onPressed: () {
                  _select();

                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => MyApp())));

                  setState(() {
                    _quizAnswer = ANSWER.e;
                  });
                },
                child: const Center(child: Text("E N T E R"))),
          )
        ],
      ),
    );
  }
}
