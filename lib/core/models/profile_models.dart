import 'dart:convert';

class Profile{
  int id;
  String name;
  String email;
  int age;

  Profile({this.id = 0, this.name, this.email, this.age});

  factory Profile.fromJSON(Map<String, dynamic> map) => Profile(
    id: map['id'],
    name: map['name'],
    email: map['email'],
    age: map['age']
  );

  Map<String, dynamic> toJSON() {
    return {"id": id, "name": name, "email": email, "age": age};
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Profile{id: $id, name: $name, email: $email, age: $age}';
  }
}

List<Profile> profileFromJSON(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJSON(item)));
}

String profileToJSON(Profile data) {
  final jsonData = data.toJSON();
  return json.encode(jsonData);
}