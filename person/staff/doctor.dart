import 'dart:io';

import '../../appointment/appointment.dart';
import '../../department/department.dart';
import '../../helpers/terminal_helper.dart';
import '../../hospital/hospital.dart';
import '../../medicine/medicine.dart';
import 'staff.dart';

class Doctor extends Staff {
  String specialization;

  Doctor({
    required this.specialization,
    required super.department_id,
    required super.salary,
    required super.start_date,
    required super.address,
    required super.age,
    required super.gender,
    required super.id,
    required super.name,
    required super.phone,
  });

  static Doctor? selectDoctor(Department department) {
    if (department.doctors.length > 0) {
      print("Select doctor, or enter 0 to leave");
      print("-" * 40);

      department.doctors.forEach((el) {
        print(
            "${el.id} - doctor name : ${el.name}, specialization : ${el.specialization}");
      });

      int option = int.parse(stdin.readLineSync() ?? "0");
      print("\x1B[2J\x1B[0;0H");

      if (option > 0) {
        int index = department.doctors.indexWhere((el) => el.id == option);
        if (index != -1) {
          return department.doctors.firstWhere((el) => el.id == option);
        } else {
          print("\x1B[2J\x1B[0;0H");
          print("invalid number, click any button to leave");
          stdin.readLineSync();
        }
      }
    } else {
      TerminalHelper.noDoctors();
    }
    return null;
  }

  Department? examinePatient(Department department) {
    print("\x1B[2J\x1B[0;0H");
    print("Deoctor ${name} selected, specialization is ${specialization}");
    print("-" * 40);

    Appointment? appointment =
        Appointment.selectAppointmentFromDoctor(department, this);

    if (appointment != null) {
      print("\x1B[2J\x1B[0;0H");
      print("Enter the diagnosis:");
      String diagnostic = stdin.readLineSync() ?? "Default diagnostic";

      department.appointments
          .firstWhere((el) => el.id == appointment.id)
          .patient
          .setDiagnosis(diagnostic);

      return department;
    }

    return null;
  }

  Department? descripeMedicine(Hospital hospital, Department department) {
    print("\x1B[2J\x1B[0;0H");
    print("Deoctor ${name} selected, specialization is ${specialization}");
    print("-" * 40);

    Medicine? medicine = Medicine.selectMedicine(hospital);

    if (medicine != null) {
      Appointment? appointment =
          Appointment.selectAppointmentFromDoctor(department, this);

      if (appointment != null) {
        department.appointments
            .firstWhere((el) => el.id == appointment.id)
            .patient
            .addMedicine(medicine);

        return department;
      }
    }

    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'specialization': specialization,
      "id": super.id,
      "name": super.name,
      "address": super.address,
      "phone": super.phone,
      "gender": super.gender,
      "age": super.age,
      "salary": super.salary,
      "start_date": super.start_date.millisecondsSinceEpoch,
      'department_id': super.department_id,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      specialization: map['specialization'] as String,
      address: map["address"],
      age: map["age"],
      gender: map["gender"],
      id: map["id"],
      name: map["name"],
      phone: map["phone"],
      salary: map["salary"],
      start_date: DateTime.fromMillisecondsSinceEpoch(map['start_date'] as int),
      department_id: map['department_id'],
    );
  }
}
