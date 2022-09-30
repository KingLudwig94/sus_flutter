import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
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
  late int yfs;
  late ValueNotifier<String?> sex = ValueNotifier(null);
  final ValueNotifier<int?> literacy = ValueNotifier(null);
  final ValueNotifier<int?> expDia = ValueNotifier(null);
  final ValueNotifier<int?> expTele = ValueNotifier(null);
  final ValueNotifier<String?> plat = ValueNotifier(null);
  final GlobalKey<FormState> _form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _form,
          child: Container(
            constraints: BoxConstraints.expand(
                width: MediaQuery.of(context).size.width / 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        tr('intro', args: ['the DEEP platform']),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          tr('intro1'),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                InputField(
                  description: tr('age'),
                  callback: (string) => age = int.parse(string!),
                  validator: (val) =>
                      int.tryParse(val!) != null ? null : tr('numreq'),
                ),
                InputField(
                  description: tr('prof'),
                  callback: (string) => profession = string!,
                  validator: (val) => val != "" ? null : tr('required'),
                ),
                InputField(
                  description: tr('yfs'),
                  callback: (string) => yfs = int.parse(string!),
                  validator: (val) =>
                      int.tryParse(val!) != null ? null : tr('numreq'),
                ),
                InputRadio(
                  description: tr('sex'),
                  validator: (val) => val != null ? null : tr('required'),
                  values: ['M', 'F'],
                  answer: sex,
                ),
                InputRadio(
                  description: tr('literacy'),
                  answer: literacy,
                  values: [1, 2, 3, 4, 5],
                  validator: (val) => val != null ? null : tr('required'),
                  optDesc: [tr('hs'), tr('bd'), tr('md'), tr('phd'), tr('med')],
                ),
                InputRadio(
                  description: tr('exptel'),
                  validator: (val) => val != null ? null : tr('required'),
                  values: [1, 2, 3, 4, 5],
                  answer: expTele,
                ),
                InputRadio(
                  description: tr('expdiary'),
                  validator: (val) => val != null ? null : tr('required'),
                  values: [1, 2, 3, 4, 5],
                  answer: expDia,
                ),
                InputRadio(
                  description: tr('platform'),
                  validator: (val) => val != null ? null : tr('required'),
                  values: ['APP', 'WEBSITE'],
                  answer: plat,
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
                                        'https://savethekid.dei.unipd.it/index.php/api/sus/',
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
                                        'literacy': literacy.value,
                                        'sex': sex.value,
                                        'years_since_surgery': yfs,
                                        'exp_level_telemedicine': expTele.value,
                                        'exp_level_diary': expDia.value,
                                        'platform': plat.value,
                                      };
                                      var json = jsonEncode(body);
                                      print(json);
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
      ),
    );
  }
}

class InputRadio<T> extends StatefulWidget {
  const InputRadio(
      {Key? key,
      required this.description,
      required this.answer,
      required this.values,
      this.optDesc,
      this.validator})
      : super(key: key);
  final String description;
  final ValueNotifier<T?> answer;
  final List<T> values;
  final List<String>? optDesc;
  final String? Function(T?)? validator;
  @override
  State<InputRadio> createState() => _InputRadioState();
}

class _InputRadioState<T> extends State<InputRadio> {
  bool missing = false;
  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: widget.validator != null
          ? (T? val) {
              String? err = widget.validator!(val);
              if (err != null) {
                setState(() {
                  missing = true;
                });
              }
              return err;
            }
          : null,
      builder: (formstate) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.description),
                if (missing)
                  Text(
                    '*',
                    style: TextStyle(color: Colors.red, fontSize: 40),
                  )
              ],
            ),
            Wrap(
              spacing: 20,
              alignment: WrapAlignment.spaceEvenly,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.values.length,
                (index) => Column(
                  children: [
                    Radio<T>(
                      value: widget.values[index],
                      groupValue: widget.answer.value,
                      onChanged: (T? val) => setState(() {
                        missing = false;
                        widget.answer.value = val!;
                        formstate.didChange(val);
                      }),
                    ),
                    Text(
                      widget.optDesc != null
                          ? widget.optDesc![index]
                          : '${widget.values[index]}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
