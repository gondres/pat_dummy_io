class LikesModel {
  String? id;
  String? image;
  int? likes;
  List<String>? tags;
  String? text;
  String? publishDate;
  String? owner_id;
  String? owner_title;
  String? owner_firstname;
  String? owner_lastname;
  String? owner_picture;
  int? isLiked;

  LikesModel(
      {required this.id,
      this.image,
      this.likes,
      this.tags,
      this.text,
      this.publishDate,
      this.owner_id,
      this.owner_title,
      this.owner_firstname,
      this.owner_lastname,
      this.owner_picture,
      this.isLiked});

  factory LikesModel.fromJson(Map<String, dynamic> json) => LikesModel(
        id: json['id'] ?? '',
        image: json['image'],
        likes: json['likes'],
        tags: json.containsKey('tags') && json['tags'] is String ? (json['tags'] as String).split(',') : null,
        text: json['text'],
        publishDate: json['publishDate'],
        owner_id: json['owner_id'],
        owner_title: json['owner_title'],
        owner_firstname: json['owner_firstname'],
        owner_lastname: json['owner_lastname'],
        owner_picture: json['owner_picture'],
        isLiked: json['isLiked'],
      );
}
