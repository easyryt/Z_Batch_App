class BatchDescriptionModel {
  bool? status;
  String? message;
  DescriptionData? data;

  BatchDescriptionModel({this.status, this.message, this.data});

  BatchDescriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DescriptionData.fromJson(json['data']) : null;
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

class DescriptionData {
  String? batchId;
  String? sId;
  CourseDuration? courseDuration;
  List<String>? batchIncludes;
  String? validity;
  List<String>? subjects;
  List<KnowYourTeachers>? knowYourTeachers;
  List<Schedule>? schedule;
  List<String>? otherDetails;
  List<Faq>? faq;

  DescriptionData(
      {this.batchId,
      this.sId,
      this.courseDuration,
      this.batchIncludes,
      this.validity,
      this.subjects,
      this.knowYourTeachers,
      this.schedule,
      this.otherDetails,
      this.faq});

  DescriptionData.fromJson(Map<String, dynamic> json) {
    batchId = json['batchId'];
    sId = json['_id'];
    courseDuration = json['courseDuration'] != null
        ? CourseDuration.fromJson(json['courseDuration'])
        : null;
    batchIncludes = json['batchIncludes'].cast<String>();
    validity = json['validity'];
    subjects = json['subjects'].cast<String>();
    if (json['knowYourTeachers'] != null) {
      knowYourTeachers = <KnowYourTeachers>[];
      json['knowYourTeachers'].forEach((v) {
        knowYourTeachers!.add(KnowYourTeachers.fromJson(v));
      });
    }
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(Schedule.fromJson(v));
      });
    }
    otherDetails = json['otherDetails'].cast<String>();
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(Faq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['batchId'] = batchId;
    data['_id'] = sId;
    if (courseDuration != null) {
      data['courseDuration'] = courseDuration!.toJson();
    }
    data['batchIncludes'] = batchIncludes;
    data['validity'] = validity;
    data['subjects'] = subjects;
    if (knowYourTeachers != null) {
      data['knowYourTeachers'] =
          knowYourTeachers!.map((v) => v.toJson()).toList();
    }
    if (schedule != null) {
      data['schedule'] = schedule!.map((v) => v.toJson()).toList();
    }
    data['otherDetails'] = otherDetails;
    if (faq != null) {
      data['faq'] = faq!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseDuration {
  String? startDate;
  String? endDate;

  CourseDuration({this.startDate, this.endDate});

  CourseDuration.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}

class KnowYourTeachers {
  String? teacherName;
  String? expertise;
  String? pic;
  double? yearOfEx;

  KnowYourTeachers({this.teacherName, this.expertise, this.pic, this.yearOfEx});

  KnowYourTeachers.fromJson(Map<String, dynamic> json) {
    teacherName = json['teacherName'];
    expertise = json['expertise'];
    pic = json['pic'];
    yearOfEx = double.parse("${json['yearOfEx']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['teacherName'] = teacherName;
    data['expertise'] = expertise;
    data['pic'] = pic;
    data['yearOfEx'] = yearOfEx;
    return data;
  }
}

class Schedule {
  String? subject;
  String? icon;
  String? pdf;
  String? publicId;

  Schedule({this.subject, this.icon, this.pdf, this.publicId});

  Schedule.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    icon = json['icon'];
    pdf = json['pdf'];
    publicId = json['public_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = subject;
    data['icon'] = icon;
    data['pdf'] = pdf;
    data['public_id'] = publicId;
    return data;
  }
}

class Faq {
  String? question;
  String? answer;

  Faq({this.question, this.answer});

  Faq.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
