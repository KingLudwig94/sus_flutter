/// An enumerator that defines the five possible values that an [Answer] can take.
enum AnswerValue {
  /// Strongly disagree.
  ONE,

  /// Disagree.
  TWO,

  /// Nor agree or disagree.
  THREE,

  /// Agree.
  FOUR,

  /// Strongly agree.
  FIVE
} // AnswerValue

/// [Answer] is a class that implements the data model of an answer of the SUS questionnarie.
class Answer {
  /// The value of the [Answer].
  AnswerValue answerValue;

  /// Default constructor of a [Answer].
  Answer({required this.answerValue});

  /// A method that converts the [answerValue] to the correspondent integer.
  int toNumber() {
    final int ret;
    if (answerValue == AnswerValue.ONE) {
      ret = 1;
    } else if (answerValue == AnswerValue.TWO) {
      ret = 2;
    } else if (answerValue == AnswerValue.THREE) {
      ret = 3;
    } else if (answerValue == AnswerValue.FOUR) {
      ret = 4;
    } else {
      ret = 5;
    } //if

    return ret;
  } // toNumber

  /// Returns the status of an [Answer]
  @override
  String toString() {
    return (StringBuffer('Answer(')
          ..write('answerValue: $answerValue ')
          ..write(')'))
        .toString();
  } // toString

} // Answer
