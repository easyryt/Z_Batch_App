class SubjectDPPPDFModel {
  bool? status;
  String? message;
  List<SubDPPPDFData>? data;

  SubjectDPPPDFModel({this.status, this.message, this.data});

  SubjectDPPPDFModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubDPPPDFData>[];
      json['data'].forEach((v) {
        data!.add(SubDPPPDFData.fromJson(v));
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

class SubDPPPDFData {
  Pdf? pdf;
  String? sId;
  String? batchId;
  String? allClassSubId;
  String? title;
  String? contentType;
  int? part;
  bool? isFreeContent;
  String? createdAt;
  int? iV;
  bool? isBatchPaidByUser;

  SubDPPPDFData(
      {this.pdf,
      this.sId,
      this.batchId,
      this.allClassSubId,
      this.title,
      this.contentType,
      this.part,
      this.isFreeContent,
      this.createdAt,
      this.iV,
      this.isBatchPaidByUser});

  SubDPPPDFData.fromJson(Map<String, dynamic> json) {
    pdf = json['pdf'] != null ? Pdf.fromJson(json['pdf']) : null;
    sId = json['_id'];
    batchId = json['batchId'];
    allClassSubId = json['allClassSubId'];
    title = json['title'];
    contentType = json['contentType'];
    part = json['part'];
    isFreeContent = json['isFreeContent'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    isBatchPaidByUser = json['isBatchPaidByUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pdf != null) {
      data['pdf'] = pdf!.toJson();
    }
    data['_id'] = sId;
    data['batchId'] = batchId;
    data['allClassSubId'] = allClassSubId;
    data['title'] = title;
    data['contentType'] = contentType;
    data['part'] = part;
    data['isFreeContent'] = isFreeContent;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    data['isBatchPaidByUser'] = isBatchPaidByUser;
    return data;
  }
}

class Pdf {
  String? publicId;
  String? url;

  Pdf({this.publicId, this.url});

  Pdf.fromJson(Map<String, dynamic> json) {
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
