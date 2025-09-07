class Profile {
  final String name;
  final String phoneNumber;
  final String address;
  final String profilePictureUrl;
  final String gender;

  Profile({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.profilePictureUrl,
    required this.gender,
  });

  Profile copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    String? profilePictureUrl,
    String? gender,
  }) {
    return Profile(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber, // konsisten: phoneNumber
      'address': address,
      'profilePictureUrl': profilePictureUrl,
      'gender': gender,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    // Toleran jika key belum ada di session/database
    return Profile(
      name: (json['name'] ?? '').toString(),
      phoneNumber: (json['phoneNumber'] ?? json['phone'] ?? '').toString(),
      address: (json['address'] ?? '').toString(),
      profilePictureUrl: (json['profilePictureUrl'] ?? '').toString(),
      gender: (json['gender'] ?? '').toString(),
    );
  }

  static Profile get empty => Profile(
    name: '',
    phoneNumber: '',
    address: '',
    profilePictureUrl: '',
    gender: '',
  );
}
