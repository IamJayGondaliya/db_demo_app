class Student {
  int id;
  String name;
  int age;

  Student(this.name, this.age, this.id);

  factory Student.fromMap({required Map data}) => Student(
        data['name'],
        data['age'],
        data['id'],
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'age': age,
      };
}
