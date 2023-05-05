class Student {
  int? id;
  late String name;
  late int regno;

  Student({
    this.id,
    required this.name,
    required this.regno,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': regno,
    };
  }

  // Convert a Map to a Dog Object
  Student.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    regno = map['age'];
  }
}