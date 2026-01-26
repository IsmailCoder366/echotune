class UserModel {
  final String uid;
  final String email;
  final String role;
  final String name;
  final String profileImage;
  // NEW POCKETS FOR THE SUITCASE
  final String accountNumber;
  final String ifscCode;

  UserModel({
    required this.uid,
    required this.email,
    required this.role,
    this.name = '',
    this.profileImage = '',
    this.accountNumber = '',
    this.ifscCode = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
      'name': name,
      'profileImage': profileImage,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'user',
      name: map['name'] ?? '',
      profileImage: map['profileImage'] ?? '',
      accountNumber: map['accountNumber'] ?? '',
      ifscCode: map['ifscCode'] ?? '',
    );
  }
}