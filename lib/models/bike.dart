class Bike {
  final String about;
  final String category;
  final String id;
  final String image;
  final String level;
  final String name;
  final num price;
  final num rating;
  final String release;
  Bike({
    required this.about,
    required this.category,
    required this.id,
    required this.image,
    required this.level,
    required this.name,
    required this.price,
    required this.rating,
    required this.release,
  });

  Bike copyWith({
    String? about,
    String? category,
    String? id,
    String? image,
    String? level,
    String? name,
    num? price,
    num? rating,
    String? release,
  }) {
    return Bike(
      about: about ?? this.about,
      category: category ?? this.category,
      id: id ?? this.id,
      image: image ?? this.image,
      level: level ?? this.level,
      name: name ?? this.name,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      release: release ?? this.release,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'about': about,
      'category': category,
      'id': id,
      'image': image,
      'level': level,
      'name': name,
      'price': price,
      'rating': rating,
      'release': release,
    };
  }

  factory Bike.fromJson(Map<String, dynamic> json) {
    return Bike(
      about: json['about'] as String,
      category: json['category'] as String,
      id: json['id'] as String,
      image: json['image'] as String,
      level: json['level'] as String,
      name: json['name'] as String,
      price: json['price'] as num,
      rating: json['rating'] as num,
      release: json['release'] as String,
    );
  }

  static Bike get empty => Bike(
    about: '',
    category: '',
    id: '',
    image: '',
    level: '',
    name: '',
    price: 0,
    rating: 0,
    release: '',
  );
}
