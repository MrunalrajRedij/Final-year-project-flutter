class StudentInfo{
  final id;
  final name;
  StudentInfo({this.id, this.name});

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'name': name,
    };
  }
}