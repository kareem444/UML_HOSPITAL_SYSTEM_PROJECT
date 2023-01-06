import 'dart:io';
import '../../appointment/appointment.dart';
import '../../department/department.dart';
import '../../helpers/terminal_helper.dart';
import '../../hospital/hospital.dart';
import 'staff.dart';

class Nurse extends Staff {
  Nurse({
    required super.salary,
    required super.start_date,
    required super.address,
    required super.age,
    required super.gender,
    required super.id,
    required super.name,
    required super.phone,
    required super.department_id,
  });

  static Nurse? selectNurse(Department department) {
    print("Select nurse, or enter 0 to leave");
    print("-" * 40);

    if (department.nurses.length > 0) {
      department.nurses.forEach((el) {
        print("${el.id} - nurse name : ${el.name}");
      });

      int option = int.parse(stdin.readLineSync() ?? "0");
      print("\x1B[2J\x1B[0;0H");

      if (option > 0) {
        int index = department.nurses.indexWhere((el) => el.id == option);
        if (index != -1) {
          return department.nurses.firstWhere((el) => el.id == option);
        } else {
          print("\x1B[2J\x1B[0;0H");
          print("invalid number, click any button to leave");
          stdin.readLineSync();
        }
      }
    } else {
      print("\x1B[2J\x1B[0;0H");
      print("no nurses in this department yet");
      print(" click any button to leave");
      stdin.readLineSync();
    }
    return null;
  }

  Department? giveMedicine(Hospital hospital, Department department) {
    if (department.appointments.length > 0) {
      print("\x1B[2J\x1B[0;0H");
      print("Nurse ${name} selected");
      print("-" * 40);

      if (hospital.medicines.length > 0) {
        Appointment? appointment = Appointment.selectAppointment(department);

        if (appointment != null) {
          department.appointments
              .firstWhere((el) => el.id == appointment.id)
              .patient
              .takeMedicins();

          return department;
        }
      } else {
        TerminalHelper.noMedicens();
      }
    } else {
      TerminalHelper.noPationts();
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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

  factory Nurse.fromMap(Map<String, dynamic> map) {
    return Nurse(
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
