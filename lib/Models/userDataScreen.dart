// class ChatUser {
//   ChatUser({
//     required this.uid,
//     required this.password,
//     required this.city,
//     required this.imageUrl,
//     required this.name,
//     required this.active,
//     required this.email,
//     required this.createdAt,
//   // required this.isOnline,
//     required this.about,
//     required this.id,
//     required this.pushToken,
//   });
//   late final String uid;
//   late final String password;
//   late final String city;
//   late final String imageUrl;
//   late final String name;
//   late final String active;
//   late final String email;
//   late String pushToken;
//  // late bool isOnline;
//   late String id;
//   late String about;
//   late String createdAt;

//   ChatUser.fromJson(Map<String, dynamic> json) {
//     uid = json['uid'] ?? ' ';
//     password = json['password'] ?? ' ';
//     city = json['city'] ?? ' ';
//     imageUrl = json['image_url'] ?? ' ';
//     name = json['name'] ?? ' ';
//     active = json['active'] ?? ' ';
//     email = json['email'] ?? ' ';
//     pushToken = json['push_token'] ?? '';
//     id = json['id'] ?? '';
//     //isOnline = json['is_online'];
//     createdAt = json['created_at'] ?? '';
//     about = json['about'] ?? '';
//   }

//   get image => null;

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['uid'] = uid;
//     data['password'] = password;
//     data['city'] = city;
//     data['image_url'] = imageUrl;
//     data['name'] = name;
//     data['active'] = active;
//     data['email'] = email;
//     data['about'] = about;
//     data['created_at'] = createdAt;
//   //  data['is_online'] = isOnline;
//     data['id'] = id;
//     data['push_token'] = pushToken;
//     return data;
//   }
// }
