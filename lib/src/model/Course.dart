class Course {
  final String uid;
  String title;
  String description;
  String image;
  List<dynamic> tags;
  String updateAt;

  Course(
    this.uid,
    this.title, [
    this.description = '',
    this.image = '',
    this.tags,
    this.updateAt,
  ]);

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        json['uid'],
        json['title'],
        json['description'],
        json['image'],
        json['tags'],
        json['updateAt'],
      );

  String toString() {
    return '$uid=> $title';
  }

  Map toJson() => {
        'uid': uid,
        'title': title,
        'description': description,
        'image': image,
        'tags': tags,
        'updateAt': updateAt,
      };
}
