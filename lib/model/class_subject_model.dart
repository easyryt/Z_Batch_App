class ClassSubjectModel {
  bool? status;
  String? message;
  List<ClassSubjectData>? data;

  ClassSubjectModel({this.status, this.message, this.data});

  ClassSubjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ClassSubjectData>[];
      json['data'].forEach((v) {
        data!.add(ClassSubjectData.fromJson(v));
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

class ClassSubjectData {
  String? sId;
  String? batchId;
  String? subjectId;
  String? subjectName;
  String? icon;
  int? totalChapter;

  ClassSubjectData(
      {this.sId,
      this.batchId,
      this.subjectId,
      this.subjectName,
      this.icon,
      this.totalChapter});

  ClassSubjectData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    batchId = json['batchId'];
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    icon = json['icon'];
    totalChapter = json['totalChapter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['batchId'] = batchId;
    data['subjectId'] = subjectId;
    data['subjectName'] = subjectName;
    data['icon'] = icon;
    data['totalChapter'] = totalChapter;
    return data;
  }
}
