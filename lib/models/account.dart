class Account {
  final String uid;
  final String name;
  final String email;

  Account({required this.uid, required this.name, required this.email});

  Account copyWith({String? uid, String? name, String? email}) {
    return Account(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'uid': uid, 'name': name, 'email': email};
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
