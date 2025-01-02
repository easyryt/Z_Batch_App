class TestSubjectModel {
  bool? status;
  String? message;
  List<Data>? data;

  TestSubjectModel({this.status, this.message, this.data});

  TestSubjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? batchId;
  String? subjectName;
  String? name;
  String? description;
  int? totalMarks;
  int? duration;
  int? wrongAnswerDeduction;
  int? unattemptedDeduction;
  int? totalQues;
  bool? isFreeTest;
  String? createdAt;
  bool? isBatchPaidByUser;

  Data(
      {this.sId,
      this.batchId,
      this.subjectName,
      this.name,
      this.description,
      this.totalMarks,
      this.duration,
      this.wrongAnswerDeduction,
      this.unattemptedDeduction,
      this.totalQues,
      this.isFreeTest,
      this.createdAt,
      this.isBatchPaidByUser});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchId = json['batchId'];
    subjectName = json['subjectName'];
    name = json['name'];
    description = json['description'];
    totalMarks = json['totalMarks'];
    duration = json['duration'];
    wrongAnswerDeduction = json['wrongAnswerDeduction'];
    unattemptedDeduction = json['unattemptedDeduction'];
    totalQues = json['totalQues'];
    isFreeTest = json['isFreeTest'];
    createdAt = json['createdAt'];
    isBatchPaidByUser = json['isBatchPaidByUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['batchId'] = batchId;
    data['subjectName'] = subjectName;
    data['name'] = name;
    data['description'] = description;
    data['totalMarks'] = totalMarks;
    data['duration'] = duration;
    data['wrongAnswerDeduction'] = wrongAnswerDeduction;
    data['unattemptedDeduction'] = unattemptedDeduction;
    data['totalQues'] = totalQues;
    data['isFreeTest'] = isFreeTest;
    data['createdAt'] = createdAt;
    data['isBatchPaidByUser'] = isBatchPaidByUser;
    return data;
  }
}
