import 'package:flutter/material.dart';
import 'package:sus/sus.dart';

class SUSItemView extends StatefulWidget {
  const SUSItemView(
      {Key? key,
      required this.item,
      this.missingAnswer = false})
      : super(key: key);
  final SUSItem item;
  final bool missingAnswer;

  @override
  _SUSItemViewState createState() => _SUSItemViewState();
}

class _SUSItemViewState extends State<SUSItemView> {
  //late bool missingAnswer = widget.missingAnswer;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          text: '${widget.item.index + 1}.  ' + widget.item.question.text,
          children: widget.missingAnswer
              ? [TextSpan(text: '*', style: TextStyle(color: Colors.red, fontSize: 18))]
              : [],
        ),
      ),
      subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            5,
            (index) => Column(
              children: [
                Radio(
                  value: index,
                  groupValue: widget.item.answer?.answerValue.index,
                  onChanged: (val) => setState(() {
                    widget.item.answer = Answer(
                        answerValue: AnswerValue.values.elementAt(index));
                  }),
                ),
                Text(
                  '${index + 1}',
                )
              ],
            ),
          )),
    );
  }
}
