class AppUser {
  String uid;
  String userName;
  String name;
  String email;
  String phone;
  DateTime birthday;
  String profilePicUrl;
  bool isAnonymus;

  AppUser({
    this.birthday,
    this.email,
    this.name,
    this.phone,
    this.profilePicUrl,
    this.uid,
    this.userName,
    this.isAnonymus,
  });

  AppUser fromJson(Map data, String uid) {
    AppUser newUser = AppUser(
      uid: uid,
      userName: data['userName'],
      name: data['name'],
      email: data['email'],
      birthday: data['birthday'] != ''
          ? DateTime.parse(data['birthday'])
          : DateTime(1900, 1, 1),
      phone: data['phone'],
      profilePicUrl: data['profilePicUrl'],
      isAnonymus: data['isAnonymus'],
    );

    return newUser;
  }

  Map<String, String> toJson(AppUser user) {
    return {
      'userName': user.userName ?? '',
      'name': user.name ?? '',
      'email': user.email ?? '',
      'birthday': user.birthday == null ? '' : user.birthday.toIso8601String(),
      'phone': user.phone ?? '',
      'profilePicUrl': user.profilePicUrl ?? '',
      'isAnonymus': user.isAnonymus.toString(),
    };
  }
}
