class ChatUserModel {
  String? createsAt;
  String? image;
  String? about;
  String? name;
  bool? isOnline;
  String? lastActive;
  String? id;
  String? pushToken;
  String? email;

  ChatUserModel(
      {this.createsAt,
      this.image,
      this.about,
      this.name,
      this.isOnline,
      this.lastActive,
      this.id,
      this.pushToken,
      this.email});

  ChatUserModel.fromJson(Map<String, dynamic> json) {
    createsAt = json['creates_at'] ?? "";
    image = json['image'] ?? "";
    about = json['about'] ?? "";
    name = json['name'] ?? "";
    isOnline = json['is_online'] ?? false;
    lastActive = json['last_active'] ?? "";
    id = json['id'] ?? "";
    pushToken = json['push_token'] ?? "";
    email = json['email'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creates_at'] = this.createsAt;
    data['image'] = this.image;
    data['about'] = this.about;
    data['name'] = this.name;
    data['is_online'] = this.isOnline;
    data['last_active'] = this.lastActive;
    data['id'] = this.id;
    data['push_token'] = this.pushToken;
    data['email'] = this.email;
    return data;
  }
}
