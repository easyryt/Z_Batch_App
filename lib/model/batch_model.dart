class BatchModel {
  List<BatchData>? data;

  BatchModel({this.data});

  BatchModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BatchData>[];
      json['data'].forEach((v) {
        data!.add(BatchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BatchData {
  Duration? duration;
  ThumbnailImg? thumbnailImg;
  String? sId;
  String? clsId;
  String? title;
  String? clsName;
  String? board;
  bool? isFree;
  String? batchTag;
  int? price;
  int? mrp;
  int? discount;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BatchData(
      {this.duration,
      this.thumbnailImg,
      this.sId,
      this.clsId,
      this.title,
      this.clsName,
      this.board,
      this.isFree,
      this.batchTag,
      this.price,
      this.mrp,
      this.discount,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BatchData.fromJson(Map<String, dynamic> json) {
    duration =
        json['duration'] != null ? Duration.fromJson(json['duration']) : null;
    thumbnailImg = json['thumbnailImg'] != null
        ? ThumbnailImg.fromJson(json['thumbnailImg'])
        : null;
    sId = json['_id'];
    clsId = json['clsId'];
    title = json['title'];
    clsName = json['clsName'];
    board = json['board'];
    isFree = json['isFree'];
    batchTag = json['batchTag'];
    price = json['price'];
    mrp = json['mrp'];
    discount = json['discount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (duration != null) {
      data['duration'] = duration!.toJson();
    }
    if (thumbnailImg != null) {
      data['thumbnailImg'] = thumbnailImg!.toJson();
    }
    data['_id'] = sId;
    data['clsId'] = clsId;
    data['title'] = title;
    data['clsName'] = clsName;
    data['board'] = board;
    data['isFree'] = isFree;
    data['batchTag'] = batchTag;
    data['price'] = price;
    data['mrp'] = mrp;
    data['discount'] = discount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Duration {
  String? startDate;
  String? endDate;

  Duration({this.startDate, this.endDate});

  Duration.fromJson(Map<String, dynamic> json) {
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
