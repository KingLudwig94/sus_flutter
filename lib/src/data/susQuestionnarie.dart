import 'package:sus/sus.dart';
import 'package:easy_localization/easy_localization.dart';

/// [SUSQuestionnarie] is the class that implements the data model of the SUS questionnarie.
class SUSQuestionnarie {
  List<SUSItem> susItems;

  /// Default constructor of a [SUSQuestionnarie].
  SUSQuestionnarie({required this.susItems});

  /// Initialize a new [SUSQuestionnarie].
  factory SUSQuestionnarie.init() {
    List<SUSItem> susItems = [
      SUSItem(
        index: 0,
        question: Question(
            text: tr('q0')),
        answer: null,
        isPositive: true,
      ),
      SUSItem(
        index: 1,
        question: Question(text: tr('q1')),
        answer: null,
        isPositive: false,
      ),
      SUSItem(
        index: 2,
        question: Question(text: tr('q2')),
        answer: null,
        isPositive: true,
      ),
      SUSItem(
        index: 3,
        question: Question(
            text:
                tr('q3')),
        answer: null,
        isPositive: false,
      ),
      SUSItem(
        index: 4,
        question: Question(
            text:
                tr('q4')),
        answer: null,
        isPositive: true,
      ),
      SUSItem(
        index: 5,
        question: Question(
            text: tr('q5')),
        answer: null,
        isPositive: false,
      ),
      SUSItem(
        index: 6,
        question: Question(
            text:
                tr('q6')),
        answer: null,
        isPositive: true,
      ),
      SUSItem(
        index: 7,
        question: Question(text: tr('q7')),
        answer: null,
        isPositive: false,
      ),
      SUSItem(
        index: 8,
        question: Question(text: tr('q8')),
        answer: null,
        isPositive: true,
      ),
      SUSItem(
        index: 9,
        question: Question(
            text:
                tr('q9')),
        answer: null,
        isPositive: false,
      ),
    ];
    return SUSQuestionnarie(susItems: susItems);
  } //SUSQuestionnarie.init

  /// A method that computes the overall score of the SUS questionnarie.
  double getScore() {
    //Validate answers
    List notResp = susItems.where((element) => element.answer == null).toList();
    if (notResp.isNotEmpty) {
      throw AnswerException(notResp.map<int>((e) => e.index).toList());
    }

    //Initialize the sum to 0.
    int sum = 0;

    //Sum the given answers' scores.
    susItems.forEach((SUSItem susItem) {
      if (susItem.isPositive) {
        sum += susItem.answer!.toNumber() - 1;
      } else {
        sum += 5 - susItem.answer!.toNumber();
      } //if
    }); //forEach

    //Return the overall score
    return sum * 2.5;
  } // getScore

  /// Returns the status of a [SUSQuestionnarie].
  @override
  String toString() {
    return (StringBuffer('SUSQuestionnarie(')
          ..write('susItems: $susItems ')
          ..write(')'))
        .toString();
  } // toString

  /// A method to retrieve all answers.
  List<int> getAnswers() {
    //Validate answers
    List notResp = susItems.where((element) => element.answer == null).toList();
    if (notResp.isNotEmpty) {
      throw AnswerException(notResp.map<int>((e) => e.index).toList());
    }

    return susItems.map<int>((e) => e.answer!.toNumber()).toList();
  }
  
} // SUSQuestionnarie

class AnswerException implements Exception {
  AnswerException(this.notAnswered);
  List<int> notAnswered;
}
