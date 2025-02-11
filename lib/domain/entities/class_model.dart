class ClassModel{
  String date;
  String hour;
  int amountStudents;
  String? id;

  ClassModel({
    required this.date,
    required this.hour,
    required this.amountStudents
  });

  Map<String, dynamic> toJson(){
    return {
      'date': date,
      'hour': hour,
      'amountStudents': amountStudents,
    };
  }
}
