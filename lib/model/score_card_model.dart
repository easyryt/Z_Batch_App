class ScoreCardModel {
  bool? status;
  String? message;
  Data? data;

  ScoreCardModel({this.status, this.message, this.data});

  ScoreCardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? correctAnswers;
  int? wrongAnswers;
  int? unattemptedQuestions;
  int? totalMarks;
  double? score;
  int? negativeMarksApplied;
  List<Responses>? responses;

  Data(
      {this.correctAnswers,
      this.wrongAnswers,
      this.unattemptedQuestions,
      this.totalMarks,
      this.score,
      this.negativeMarksApplied,
      this.responses});

  Data.fromJson(Map<String, dynamic> json) {
    correctAnswers = json['correctAnswers'];
    wrongAnswers = json['wrongAnswers'];
    unattemptedQuestions = json['unattemptedQuestions'];
    totalMarks = json['totalMarks'];
    score = json['score'];
    negativeMarksApplied = json['negativeMarksApplied'];
    if (json['responses'] != null) {
      responses = <Responses>[];
      json['responses'].forEach((v) {
        responses!.add(Responses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['correctAnswers'] = correctAnswers;
    data['wrongAnswers'] = wrongAnswers;
    data['unattemptedQuestions'] = unattemptedQuestions;
    data['totalMarks'] = totalMarks;
    data['score'] = score;
    data['negativeMarksApplied'] = negativeMarksApplied;
    if (responses != null) {
      data['responses'] = responses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Responses {
  String? questionText;
  List<Options>? options;
  String? selectedOption;
  bool? isCorrect;
  String? explanation;

  Responses(
      {this.questionText,
      this.options,
      this.selectedOption,
      this.isCorrect,
      this.explanation});

  Responses.fromJson(Map<String, dynamic> json) {
    questionText = json['questionText'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    selectedOption = json['selectedOption'];
    isCorrect = json['isCorrect'];
    explanation = json['explanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionText'] = questionText;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['selectedOption'] = selectedOption;
    data['isCorrect'] = isCorrect;
    data['explanation'] = explanation;
    return data;
  }
}

class Options {
  String? optionText;
  bool? isCorrect;
  String? sId;

  Options({this.optionText, this.isCorrect, this.sId});

  Options.fromJson(Map<String, dynamic> json) {
    optionText = json['optionText'];
    isCorrect = json['isCorrect'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optionText'] = optionText;
    data['isCorrect'] = isCorrect;
    data['_id'] = sId;
    return data;
  }
}
