import 'dart:io';
import '../hospital/hospital.dart';

class Medicine {
  int id;
  double cost;
  String name;
  String description;
  String company;

  Medicine({
    required this.id,
    required this.cost,
    required this.name,
    required this.description,
    required this.company,
  });

  static selectMedicine(Hospital hospital) {
    if (hospital.medicines.length > 0) {
      print("- select medicine, or enter 0 to leave");
      print("-" * 40);
      hospital.medicines.forEach((el) {
        print(
            "${el.id} -  Medicine name : ${el.name}, cost : ${el.cost} , company : ${el.company}.");
      });

      int option = int.parse(stdin.readLineSync() ?? "0");
      print("\x1B[2J\x1B[0;0H");

      if (option > 0) {
        int medicine = hospital.medicines.indexWhere((el) => el.id == option);
        if (medicine != -1) {
          return hospital.medicines.firstWhere((el) => el.id == option);
        }
      }
      print("\x1B[2J\x1B[0;0H");
      print("invalid number, click any button to leave");
      stdin.readLineSync();
    } else {
      print("\x1B[2J\x1B[0;0H");
      print("No medicins yet, click any key to leave.");
      stdin.readLineSync();
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cost': cost,
      'name': name,
      'description': description,
      'company': company,
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'] as int,
      cost: map['cost'] as double,
      name: map['name'] as String,
      description: map['description'] as String,
      company: map['company'] as String,
    );
  }
}
