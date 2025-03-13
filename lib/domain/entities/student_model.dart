class StudentModel{
  String id;
  String uid;
  String name;
  String surename;
  bool access;
  String rol;
  int classCount;

  StudentModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.surename,
    required this.access,
    required this.rol,
    required this.classCount
  });

  // ✅ Constructor con valores predeterminados
  StudentModel.empty()
      : id = "",
        uid = "",
        name = "",
        surename = "",
        access = false,
        rol = "",
        classCount = -1;

  factory StudentModel.fromJson(Map<String, dynamic> json){
    return StudentModel(
        id: json['id'] ?? '',
        uid: json['uid'],
        name: json['name'],
        surename: json['surename'],
        access: json['access'],
        rol: json['rol'],
      classCount: json['classCount']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'uid': uid,
      'name': name,
      'surename': surename,
      'access': access,
      'rol': rol,
      'classCount': classCount
    };
  }

  StudentModel copyWith({
    String? id,
    String? uid,
    String? name,
    String? surename,
    bool? access,
    String? rol,
    int? classCount,
  }){
    return StudentModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      surename: surename ?? this.surename,
      access: access ?? this.access,
      rol: rol ?? this.rol,
      classCount: classCount ?? this.classCount
    );
  }
}