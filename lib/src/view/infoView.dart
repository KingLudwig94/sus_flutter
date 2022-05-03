import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sus/src/inputField.dart';
import 'package:sus/sus.dart';
import 'package:http/http.dart' as http;

class InfoView extends StatefulWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => InfoViewState();
}

class InfoViewState extends State<InfoView> {
  late int age;
  late String profession;
  final GlobalKey<FormState> _form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'You are about to answer TEN simple questions about your experience with the platform. \n Please fill the fields below and then press start.',
                ),
              ),
              InputField(
                description: 'Age',
                callback: (string) => age = int.parse(string!),
                validator: (val) =>
                    int.tryParse(val!) != null ? null : 'number needed',
              ),
              InputField(
                description: 'Profession',
                callback: (string) => profession = string!,
                validator: (val) => val != null ? null : 'Required',
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (!_form.currentState!.validate()) return;
                    _form.currentState!.save();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            body: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: SUSView(
                                  doneCallback: (score, answers) async {
                                    print(score);
                                    print(answers);

                                    var url = Uri.parse(
                                      'http://savethekid.dei.unipd.it/index.php/api/sus/',
                                      // 'http://192.168.1.48:8000/index.php/api/sus',
                                    );
                                    var body = {
                                      'age': age,
                                      'profession': profession,
                                      'score': score,
                                      'q1': answers![0],
                                      'q2': answers[1],
                                      'q3': answers[2],
                                      'q4': answers[3],
                                      'q5': answers[4],
                                      'q6': answers[5],
                                      'q7': answers[6],
                                      'q8': answers[7],
                                      'q9': answers[8],
                                      'q10': answers[9],
                                    };
                                    var json = jsonEncode(body);
                                    await http.put(url, body: json);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        (route) => false);
                  },
                  child: Text('Start')),
            ],
          ),
        ),
      ),
    );
  }
}
