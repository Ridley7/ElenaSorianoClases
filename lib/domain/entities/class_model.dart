import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel {
  String id;
  DateTime timestamp;
  int amountStudents;
  List<String> listStudent;

  ClassModel({
    required this.id,
    required this.timestamp,
    required this.amountStudents,
    required this.listStudent,
  });

  // Constructor para crear una instancia desde un JSON
  factory ClassModel.fromJson(Map<String, dynamic> json) {

    final timestamp = json['timestamp'];

    return ClassModel(
      id: json['id'] ?? '', // Si no tiene ID, asigna una cadena vacía
      timestamp: timestamp is Timestamp
          ? timestamp.toDate()
          : timestamp is DateTime
          ? timestamp
          : DateTime.now(),
      amountStudents: json['amountStudents'],
      listStudent: List<String>.from(json['listStudent'] ?? []), // Convierte correctamente la lista
    );
  }

  // Método para convertir a JSON, excluyendo el id
  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'amountStudents': amountStudents,
      'listStudent': listStudent, // Asegura que se incluya en el JSON
    };
  }

  // Método copyWith
  ClassModel copyWith({
    String? id,
    DateTime? timestamp,
    int? amountStudents,
    List<String>? listStudents
  }) {
    return ClassModel(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      amountStudents: amountStudents ?? this.amountStudents,
      listStudent: listStudents ?? this.listStudent,
    );
  }
}
