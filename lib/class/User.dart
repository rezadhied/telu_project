class User {
  final String userID;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String photoProfileUrl;
  final String photoProfileImage;
  final String email;
  final String gender;
  final String lectureCode;
  final String facultyCode;
  final String facultyName;
  final String majorCode;
  final String majorName;
  final String kelas;
  final String role;

  User({
    required this.userID,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.photoProfileUrl,
    required this.photoProfileImage,
    required this.email,
    required this.gender,
    required this.lectureCode,
    required this.facultyCode,
    required this.facultyName,
    required this.majorCode,
    required this.majorName,
    required this.kelas,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'photoProfileUrl': photoProfileUrl,
      'photoProfileImage': photoProfileImage,
      'email': email,
      'gender': gender,
      'lectureCode': lectureCode,
      'facultyCode': facultyCode,
      'facultyName': facultyName,
      'majorCode': majorCode,
      'majorName': majorName,
      'kelas': kelas,
      'role': role,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      photoProfileUrl: json['photoProfileUrl'] ?? '',
      photoProfileImage: json['photoProfileImage'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      lectureCode: json['lectureCode'] ?? '',
      facultyCode: json['facultyCode'] ?? '',
      facultyName: json['facultyName'] ?? '',
      majorCode: json['majorCode'] ?? '',
      majorName: json['majorName'] ?? '',
      kelas: json['kelas'] ?? '',
      role: json['role'] ?? '',
    );
  }

  @override
  String toString() {
    return 'User(userID: $userID, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, photoProfileUrl: $photoProfileUrl, photoProfileImage: $photoProfileImage, email: $email, gender: $gender, lectureCode: $lectureCode, facultyCode: $facultyCode, facultyName: $facultyName, majorCode: $majorCode, majorName: $majorName, kelas: $kelas, role: $role)';
  }
}
