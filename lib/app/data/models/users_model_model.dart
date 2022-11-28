class UsersModel {
  String? uid;
  String? name;
  String? email;
  String? createdAt;
  String? lastSignIn;
  String? photoUrl;
  String? status;
  String? updatedAt;

  UsersModel(
      {this.uid,
      this.name,
      this.email,
      this.createdAt,
      this.lastSignIn,
      this.photoUrl,
      this.status,
      this.updatedAt});

  UsersModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    createdAt = json['createdAt'];
    lastSignIn = json['lastSignIn'];
    photoUrl = json['photoUrl'];
    status = json['status'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['createdAt'] = createdAt;
    data['lastSignIn'] = lastSignIn;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
