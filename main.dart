import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:login/question.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("(QUIZ ONLINE)")),
        ),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var sum1;
  var sum2;

  var id1;
  var question;
  var aa;
  var bb;
  var cc;
  var dd;
  var answer;

  //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  Future<void> _queryCount() async {
    final url1 = Uri.parse(
      'http://192.168.100.100:8087/quiz/query_count.php',
    );
    var sendUrlParam1 = await http.post(url1, body: {});
    var dataReturn1 = jsonDecode(sendUrlParam1.body);

    if (dataReturn1.isEmpty) {
      setState(() {
        sum1 = "0";
      });
    } else {
      setState(() {
        sum1 = dataReturn1[0]['jumlah'];
        sum2 = int.parse(sum1) + 1;

        if (sum2.toString() == '11') {
          sum2 = "FINISHED";
        }
      });
    }
  }

  //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  @override
  void initState() {
    _queryCount();
    // TODO: implement initState
    super.initState();
  }

  Future<void> _queryQuestion() async {
    final url2 =
        Uri.parse("http://192.168.100.100:8087/quiz/query_question.php");
    var sendUrlParam = await http.post(url2, body: {
      "number": sum2.toString(),
    });
    var dataReturn = jsonDecode(sendUrlParam.body);

    //MANAGE DATARETURN
    if (dataReturn.isEmpty) {
      setState(() {
        //??
      });
    } else {
      if (dataReturn[0]["id"] != null) {
        //TAKE FIELD BECOME PARAM
        id1 = dataReturn[0]["id"];
        question = dataReturn[0]["question"];
        aa = dataReturn[0]["aa"];
        bb = dataReturn[0]["bb"];
        cc = dataReturn[0]["cc"];
        dd = dataReturn[0]["dd"];
        answer = dataReturn[0]["answer"];

        //SEND PARAM TO NEXT PAGE (QUESTION.DART)
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => MyProject(
                    id_: id1,
                    question_: question,
                    aa_: aa,
                    bb_: bb,
                    cc_: cc,
                    dd_: dd,
                    answer_: answer))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              sum2.toString(),
              style: TextStyle(fontSize: 50),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
          child: ElevatedButton(
              onPressed: () {
                _queryQuestion();
              },
              child: Center(child: Text("Query Question Number"))),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
          child: ElevatedButton(
              onPressed: () {},
              child: Center(child: Text("Score 10 Question"))),
        ),
      ],
    );
  }
}
