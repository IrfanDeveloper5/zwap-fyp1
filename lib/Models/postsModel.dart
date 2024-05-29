class PostModel {
  PostModel({
    required this.condition,
    required this.imageUrls,
    required this.description,
    required this.location,
    required this.title,
    required this.items,
    required this.timestamp,
    required this.userId,
    required this.id,
    required this.type, required types,
  });

  late final String condition;
  late final List<String> imageUrls;
  late final String description;
  late final String location;
  late final String title;
  late final List<String> items;
  late final String timestamp;
  late final String userId;
  late final String id;
  late final String type;

  PostModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'].toString();
    imageUrls = List<String>.from(json['imageUrls'] ?? []);
    description = json['description'].toString();
    location = json['location'].toString();
    title = json['title'].toString();
    items = List<String>.from(json['items'] ?? []);
    timestamp = json['timestamp'].toString();
    userId = json['userId'].toString();
    id = json['id'].toString();
    type = json['type'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['condition'] = condition;
    data['imageUrls'] = imageUrls;
    data['description'] = description;
    data['location'] = location;
    data['title'] = title;
    data['items'] = items;
    data['timestamp'] = timestamp;
    data['userId'] = userId;
    data['id'] = id;
    data['type'] = type;
    return data;
  }
}
