class User {
  late String userId;
  late String username;
  late String email;
  late String password;
  late double weight;
  late double height;
  late int age;
  late String activityLevel;
  late String userProfile;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    required this.weight,
    required this.height,
    required this.age,
    required this.activityLevel,
    required this.userProfile,
  });

  // Convert User object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'password': password,
      'weight': weight,
      'height': height,
      'age': age,
      'activityLevel': activityLevel,
      'userProfile': userProfile,
    };
  }

  // Create a User object from a Firestore document snapshot
  User.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        username = map['username'],
        email = map['email'],
        password = map['password'],
        weight = map['weight'],
        height = map['height'],
        age = map['age'],
        activityLevel = map['activityLevel'],
        userProfile = map['userProfile'];
}
