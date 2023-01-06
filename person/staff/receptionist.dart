import 'dart:io';
import '../../appointment/appointment.dart';
import '../../bill/bill.dart';
import '../../department/department.dart';
import '../../helpers/terminal_helper.dart';
import '../patient/patient.dart';
import 'doctor.dart';
import 'staff.dart';

class Receptionist extends Staff {
  Receptionist({
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

  Department? bookAppointment(Department department) {
    if (department.doctors.length > 0) {
      print("\x1B[2J\x1B[0;0H");
      print("Book Appointment for new patient.");
      print("-" * 20);
      print("- select doctor:");
      print("-" * 20);
      department.doctors.forEach((el) {
        print(
            "${el.id} - doctor name : ${el.name}, specialization : ${el.specialization}");
      });

      int doctorId = int.parse(stdin.readLineSync() ?? "");
      print("\x1B[2J\x1B[0;0H");

      int doctorindex =
          department.doctors.indexWhere((el) => el.id == doctorId);
      if (doctorindex != -1) {
        Doctor doctor =
            department.doctors.firstWhere((el) => el.id == doctorId);

        print("Patient information.");
        print("-" * 20);
        print("Enter patient name : ");
        String name = stdin.readLineSync() ?? "Default Patient name";
        print("Enter patient age :  ");
        int age = int.parse(stdin.readLineSync() ?? "60");
        print("Enter patient gender : ");
        String gender = stdin.readLineSync() ?? "Male";
        print("Enter patient address : ");
        String address = stdin.readLineSync() ?? "Default address";
        print("Enter patient phone : ");
        String phone = stdin.readLineSync() ?? "Default phone";

        department.addAppointment(Appointment(
          id: department.appointments.length + 1,
          date: DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day + 1,
          ),
          patient: Patient(
            id: department.appointments.length + 1,
            name: name,
            gender: gender,
            age: age,
            phone: phone,
            address: address,
            bill: generateBill(),
            medicins: [],
          ),
          doctor: doctor,
        ));
        return department;
      } else {
        print("Invalid option, Enter any key to leave.");
        stdin.readLineSync();
      }
    } else {
      TerminalHelper.noDoctors();
    }
    return null;
  }

  Bill generateBill() {
    return Bill(amount: 0);
  }

  Department? disChargePatient(Department department) {
    if (department.appointments.length > 0) {
      print("select aptinet:");
      print("-" * 20);
      department.appointments.forEach((el) {
        print(el.id.toString() + " - patinet name : " + el.patient.name);
      });

      int appointmentId = int.parse(stdin.readLineSync() ?? "");
      print("\x1B[2J\x1B[0;0H");

      int appointmentindex =
          department.appointments.indexWhere((el) => el.id == appointmentId);
      if (appointmentindex != -1) {
        department.appointments.removeWhere((el) => el.id == appointmentId);
        return department;
      } else {
        TerminalHelper.invalidOption();
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

  factory Receptionist.fromMap(Map<String, dynamic> map) {
    return Receptionist(
      address: map["address"],
      age: map["age"],
      gender: map["gender"],
      id: map["id"],
      name: map["name"],
      phone: map["phone"],
      salary: map["salary"],
      department_id: map['department_id'],
      start_date: DateTime.fromMillisecondsSinceEpoch(map['start_date'] as int),
    );
  }
}
