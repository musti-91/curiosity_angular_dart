class Course {
  final String uid;
  String title;
  double price;
  String author;
  String description;
  String image;
  List<dynamic> tags;
  String updateAt;
  List<dynamic> stars;
  String currency;
  int lectures;
  double totalDuration;

  Course(
    this.uid,
    this.title,
    this.price,
    this.author, [
    this.description = '',
    this.image = '',
    this.tags = const [],
    this.updateAt = '',
    this.stars = const [1, 2, 3, 4, 5],
    this.currency = '€',
    this.lectures = 20,
    this.totalDuration = 120.30,
  ]);

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        json['uid'],
        json['title'],
        json['price'],
        json['author'],
        json['description'],
        json['image'],
        json['tags'],
        json['updateAt'],
        json['stars'],
        json['currency'],
        json['lectures'],
        json['totalDuration'],
      );

  String toString() {
    return '[$uid] => $title';
  }

  Map toJson() => {
        'uid': uid,
        'title': title,
        'price': price,
        'author': author,
        'description': description,
        'image': image,
        'tags': tags,
        'updateAt': updateAt,
        'stars': stars,
        'currency': currency,
        'lectures': lectures,
        'totalDuration': totalDuration,
      };
}
