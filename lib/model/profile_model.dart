class ProfileModel {
  bool? status;
  String? message;
  ProfileData? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  ProfilePic? profilePic;
  String? sId;
  String? phone;
  String? gender;
  String? role;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? city;
  String? dob;
  String? email;
  String? fullName;
  String? state;

  ProfileData(
      {this.profilePic,
      this.sId,
      this.phone,
      this.gender,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.city,
      this.dob,
      this.email,
      this.fullName,
      this.state});

  ProfileData.fromJson(Map<String, dynamic> json) {
    profilePic = json['profilePic'] != null
        ? ProfilePic.fromJson(json['profilePic'])
        : null;
    sId = json['_id'];
    phone = json['phone'];
    gender = json['gender'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    city = json['city'];
    dob = json['dob'];
    email = json['email'];
    fullName = json['fullName'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profilePic != null) {
      data['profilePic'] = profilePic!.toJson();
    }
    data['_id'] = sId;
    data['phone'] = phone;
    data['gender'] = gender;
    data['role'] = role;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['city'] = city;
    data['dob'] = dob;
    data['email'] = email;
    data['fullName'] = fullName;
    data['state'] = state;
    return data;
  }
}

class ProfilePic {
  String? publicId;
  String? url;

  ProfilePic({this.publicId, this.url});

  ProfilePic.fromJson(Map<String, dynamic> json) {
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
