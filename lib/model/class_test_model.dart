class ClassTestModel {
  bool? status;
  String? message;
  List<TestData>? data;

  ClassTestModel({this.status, this.message, this.data});

  ClassTestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TestData>[];
      json['data'].forEach((v) {
        data!.add(TestData.fromJson(v));
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

class TestData {
  String? sId;
  String? batchId;
  String? subjectId;
  String? subjectName;
  String? icon;

  TestData(
      {this.sId, this.batchId, this.subjectId, this.subjectName, this.icon});

  TestData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchId = json['batchId'];
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['batchId'] = batchId;
    data['subjectId'] = subjectId;
    data['subjectName'] = subjectName;
    data['icon'] = icon;
    return data;
  }
}
