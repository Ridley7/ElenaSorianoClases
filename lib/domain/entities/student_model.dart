class StudentModel{
  String id;
  String uid;
  String name;
  String surename;
  bool access;
  String rol;

  StudentModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.surename,
    required this.access,
    required this.rol
  });

  factory StudentModel.fromJson(Map<String, dynamic> json){
    return StudentModel(
        id: json['id'] ?? '',
        uid: json['uid'],
        name: json['name'],
        surename: json['surename'],
        access: json['access'],
        rol: json['rol']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'uid': uid,
      'name': name,
      'surename': surename,
      'access': access,
      'rol': rol
    };
  }
}