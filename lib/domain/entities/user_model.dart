class UserData{
  String name;
  String faculty;
  String grade;

  UserData({
    required this.name,
    required this.faculty,
    required this.grade,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'faculty': faculty,
      'grade': grade,
    };
  }
}