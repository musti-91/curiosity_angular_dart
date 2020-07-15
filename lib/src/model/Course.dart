class Course {
  final String uid;
  String title;
  String description;

  Course(this.uid, this.title, [this.description]);
  factory Course.fromJson(Map<String, dynamic> jsonData) => Course(
        jsonData['uid'],
        jsonData['title'],
        jsonData['description'],
      );

  String toString() {
    return '$uid=> $title';
  }

  Map toJson() => {
        'uid': uid,
        'title': title,
        'description': description,
      };
}
