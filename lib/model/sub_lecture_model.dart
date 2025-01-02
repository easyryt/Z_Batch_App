class SubjectLectureModel {
  bool? status;
  String? message;
  List<LectureData>? data;

  SubjectLectureModel({this.status, this.message, this.data});

  SubjectLectureModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LectureData>[];
      json['data'].forEach((v) {
        data!.add(LectureData.fromJson(v));
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

class LectureData {
  ThumbnailImg? thumbnailImg;
  String? sId;
  String? batchId;
  String? allClassSubId;
  String? title;
  String? contentType;
  double? part;
  bool? isFreeContent;
  String? duration;
  String? videoUrl;
  String? createdAt;
  int? iV;
  bool? isBatchPaidByUser;

  LectureData(
      {this.thumbnailImg,
      this.sId,
      this.batchId,
      this.allClassSubId,
      this.title,
      this.contentType,
      this.part,
      this.isFreeContent,
      this.duration,
      this.videoUrl,
      this.createdAt,
      this.iV,
      this.isBatchPaidByUser});

  LectureData.fromJson(Map<String, dynamic> json) {
    thumbnailImg = json['thumbnailImg'] != null
        ? ThumbnailImg.fromJson(json['thumbnailImg'])
        : null;
    sId = json['_id'];
    batchId = json['batchId'];
    allClassSubId = json['allClassSubId'];
    title = json['title'];
    contentType = json['contentType'];
    part = double.parse("${json['part']}");
    isFreeContent = json['isFreeContent'];
    duration = json['duration'];
    videoUrl = json['videoUrl'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    isBatchPaidByUser = json['isBatchPaidByUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (thumbnailImg != null) {
      data['thumbnailImg'] = thumbnailImg!.toJson();
    }
    data['_id'] = sId;
    data['batchId'] = batchId;
    data['allClassSubId'] = allClassSubId;
    data['title'] = title;
    data['contentType'] = contentType;
    data['part'] = part;
    data['isFreeContent'] = isFreeContent;
    data['duration'] = duration;
    data['videoUrl'] = videoUrl;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['isBatchPaidByUser'] = isBatchPaidByUser;
    return data;
  }
}

class ThumbnailImg {
  String? publicId;
  String? url;

  ThumbnailImg({this.publicId, this.url});

  ThumbnailImg.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}
