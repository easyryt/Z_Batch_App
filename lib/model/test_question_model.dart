class TestQuestionModel {
  bool? status;
  String? message;
  Data? data;

  TestQuestionModel({this.status, this.message, this.data});

  TestQuestionModel.fromJson(Map<String, dynamic> json) {
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
  bool? isFreeTest;
  Test? test;

  Data({this.isFreeTest, this.test});

  Data.fromJson(Map<String, dynamic> json) {
    isFreeTest = json['isFreeTest'];
    test = json['test'] != null ? Test.fromJson(json['test']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFreeTest'] = isFreeTest;
    if (test != null) {
      data['test'] = test!.toJson();
    }
    return data;
  }
}

class Test {
  String? testId;
  String? batchId;
  String? testSubId;
  String? name;
  String? description;
  int? totalMarks;
  int? duration;
  int? wrongAnswerDeduction;
  int? unattemptedDeduction;
  List<Questions>? questions;
  bool? isFreeTest;

  Test(
      {this.testId,
      this.batchId,
      this.testSubId,
      this.name,
      this.description,
      this.totalMarks,
      this.duration,
      this.wrongAnswerDeduction,
      this.unattemptedDeduction,
      this.questions,
      this.isFreeTest});

  Test.fromJson(Map<String, dynamic> json) {
    testId = json['testId'];
    batchId = json['batchId'];
    testSubId = json['testSubId'];
    name = json['name'];
    description = json['description'];
    totalMarks = json['totalMarks'];
    duration = json['duration'];
    wrongAnswerDeduction = json['wrongAnswerDeduction'];
    unattemptedDeduction = json['unattemptedDeduction'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
    isFreeTest = json['isFreeTest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['testId'] = testId;
    data['batchId'] = batchId;
    data['testSubId'] = testSubId;
    data['name'] = name;
    data['description'] = description;
    data['totalMarks'] = totalMarks;
    data['duration'] = duration;
    data['wrongAnswerDeduction'] = wrongAnswerDeduction;
    data['unattemptedDeduction'] = unattemptedDeduction;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    data['isFreeTest'] = isFreeTest;
    return data;
  }
}

class Questions {
  String? questionId;
  String? questionText;
  List<Options>? options;
  String? difficultyLevel;

  Questions(
      {this.questionId, this.questionText, this.options, this.difficultyLevel});

  Questions.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    questionText = json['questionText'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    difficultyLevel = json['difficultyLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = questionId;
    data['questionText'] = questionText;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['difficultyLevel'] = difficultyLevel;
    return data;
  }
}

class Options {
  String? optionText;

  Options({this.optionText});

  Options.fromJson(Map<String, dynamic> json) {
    optionText = json['optionText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optionText'] = optionText;
    return data;
  }
}
