class ClassModel {
  String id;
  String date;
  String hour;
  int amountStudents;
  List<String> listStudent;

  ClassModel({
    required this.id,
    required this.date,
    required this.hour,
    required this.amountStudents,
    required this.listStudent,
  });

  // Constructor para crear una instancia desde un JSON
  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] ?? '', // Si no tiene ID, asigna una cadena vacía
      date: json['date'],
      hour: json['hour'],
      amountStudents: json['amountStudents'],
      listStudent: List<String>.from(json['listStudent'] ?? []), // Convierte correctamente la lista
    );
  }

  // Método para convertir a JSON, excluyendo el id
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'hour': hour,
      'amountStudents': amountStudents,
      'listStudent': listStudent, // Asegura que se incluya en el JSON
    };
  }
}
