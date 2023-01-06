import 'dart:io';
import '../department/department.dart';
import '../person/patient/patient.dart';
import '../person/staff/doctor.dart';

class Appointment {
  int id;
  DateTime date;
  Patient patient;
  Doctor doctor;

  Appointment({
    required this.id,
    required this.date,
    required this.patient,
    required this.doctor,
  });

  static Appointment? selectAppointmentFromDoctor(
    Department department,
    Doctor doctor,
  ) {
    print("- select patient to examin, or enter 0 to leave");
    print("-" * 40);

    List<Appointment> appointments = department.appointments
        .where((el) => el.doctor.id == doctor.id)
        .toList();

    if (appointments.length > 0) {
      appointments.forEach((el) {
        print("${el.id} - patient name : ${el.patient.name}");
      });
      int option = int.parse(stdin.readLineSync() ?? "0");
      print("\x1B[2J\x1B[0;0H");

      if (option > 0) {
        int index = department.appointments.indexWhere((el) => el.id == option);

        if (index != -1) {
          return department.appointments.firstWhere((el) => el.id == option);
        }
      }

      print("\x1B[2J\x1B[0;0H");
      print("invalid number, click any button to leave");
      stdin.readLineSync();
    } else {
      print("\x1B[2J\x1B[0;0H");
      print("no patient yet, click any button to leave");
      stdin.readLineSync();
    }
    return null;
  }

  static Appointment? selectAppointment(Department department) {
    print("- select patient, or enter 0 to leave");
    print("-" * 40);

    if (department.appointments.length > 0) {
      department.appointments.forEach((el) {
        print("${el.id} - patient name : ${el.patient.name}");
      });
      int option = int.parse(stdin.readLineSync() ?? "0");
      print("\x1B[2J\x1B[0;0H");

      if (option > 0) {
        int index = department.appointments.indexWhere((el) => el.id == option);

        if (index != -1) {
          return department.appointments.firstWhere((el) => el.id == option);
        }
      }

      print("\x1B[2J\x1B[0;0H");
      print("invalid number, click any button to leave");
      stdin.readLineSync();
    } else {
      print("\x1B[2J\x1B[0;0H");
      print("no patient yet, click any button to leave");
      stdin.readLineSync();
    }
    return null;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'patient': patient.toMap(),
      'doctor': doctor.toMap(),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      patient: Patient.fromMap(map['patient'] as Map<String, dynamic>),
      doctor: Doctor.fromMap(map['doctor'] as Map<String, dynamic>),
    );
  }
}
