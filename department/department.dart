import 'dart:io';

import '../appointment/appointment.dart';
import '../person/staff/doctor.dart';
import '../person/staff/nurse.dart';
import '../person/staff/receptionist.dart';
import '../terminal_helper.dart';

class Department {
  int id;
  String name;
  List<Doctor> doctors = [];
  List<Nurse> nurses = [];
  List<Appointment> appointments = [];
  Receptionist? receptionist;

  Department({
    required this.id,
    required this.name,
    required this.doctors,
    required this.nurses,
    required this.appointments,
    this.receptionist,
  });

  void addDoctor() {
    print("Enter doctor Specialization : ");
    String specialization = stdin.readLineSync() ?? "Default Special";
    print("Enter doctor name : ");
    String name = stdin.readLineSync() ?? "Default Name";
    print("Enter doctor age : ");
    int age = int.parse(stdin.readLineSync() ?? "26");
    print("Enter doctor salary : ");
    int salary = int.parse(stdin.readLineSync() ?? "4000");
    print("Enter doctor gender : ");
    String gender = stdin.readLineSync() ?? "Default age";
    print("Enter doctor address : ");
    String address = stdin.readLineSync() ?? "Default age";
    print("Enter doctor phone : ");
    String phone = stdin.readLineSync() ?? "Default Phone";

    doctors.add(Doctor(
      specialization: specialization,
      department_id: id,
      salary: salary,
      start_date: DateTime.now(),
      address: address,
      age: age,
      gender: gender,
      id: doctors.length + 1,
      name: name,
      phone: phone,
    ));
  }

  void removeDoctor(int id) {
    if (id > 0) {
      int doctor = doctors.indexWhere((el) => el.id == id);
      if (doctor != -1) {
        doctors.removeWhere((Doctor el) => el.id == id);
      } else {
        TerminalHelper.invalidOption();
      }
    }
  }

  void addNurse() {
    print("Enter nurse name : ");
    String name = stdin.readLineSync() ?? "Default Name";
    print("Enter nurse age : ");
    int age = int.parse(stdin.readLineSync() ?? "26");
    print("Enter nurse salary : ");
    int salary = int.parse(stdin.readLineSync() ?? "4000");
    print("Enter nurse gender : ");
    String gender = stdin.readLineSync() ?? "Default age";
    print("Enter nurse address : ");
    String address = stdin.readLineSync() ?? "Default age";
    print("Enter nurse phone : ");
    String phone = stdin.readLineSync() ?? "Default Phone";

    nurses.add(Nurse(
      salary: salary,
      start_date: DateTime.now(),
      address: address,
      age: age,
      gender: gender,
      id: nurses.length + 1,
      name: name,
      phone: phone,
      department_id: id,
    ));
  }

  void removeNurse() {
    print("Select Nurse to delete, or enter 0 to cancle : ");
    print("-" * 40);
    nurses.forEach((el) {
      print("${el.id}- Nurse Name: ${el.name}.");
    });
    int option = int.parse(stdin.readLineSync() ?? "");
    if (option > 0) {
      int index = nurses.indexWhere((el) => el.id == option);
      if (index != -1) {
        nurses.removeWhere((Nurse el) => el.id == option);
      } else {
        print("\x1B[2J\x1B[0;0H");
        print("invalid number, Enter any button to leave.");
        stdin.readLineSync();
      }
    }
  }

  void addAppointment(Appointment appointment) {
    appointments.add(appointment);
  }

  void removeAppointment(Appointment appointment) {
    appointments.removeWhere((Appointment el) => el.id == appointment.id);
  }

  bool addReceptionist() {
    print("\x1B[2J\x1B[0;0H");
    if (receptionist == null) {
      print("Enter receptionist name : ");
      String name = stdin.readLineSync() ?? "Default Receptionist name";
      print("Enter receptionist age : ");
      int age = int.parse(stdin.readLineSync() ?? "23");
      print("Enter receptionist address : ");
      String address = stdin.readLineSync() ?? "Default Receptionist Address";
      print("Enter receptionist phone : ");
      String phone = stdin.readLineSync() ?? "Default Receptionist Phone";
      print("Enter receptionist salary : ");
      int salary = int.parse(stdin.readLineSync() ?? "4000");
      print("Enter receptionist gender : ");
      String gender = stdin.readLineSync() ?? "Male";

      this.receptionist = Receptionist(
        salary: salary,
        start_date: DateTime.now(),
        address: address,
        age: age,
        gender: gender,
        id: id,
        name: name,
        phone: phone,
        department_id: id,
      );
      return true;
    } else {
      print("There is already receptionist in this department");
      print("Enter any key to leave.");
      stdin.readLineSync();
      return false;
    }
  }

  bool removeReceptionist() {
    if (receptionist != null) {
      this.receptionist = null;
      return true;
    } else {
      print("\x1B[2J\x1B[0;0H");
      print("No receptionist in this department");
      print("Enter any button to leave.");
      stdin.readLineSync();
      return false;
    }
  }

  static viewAllDepartment(List<Department> depts) {
    print("**Enter any key to leave");
    print("-" * 20);
    if (depts.length > 0) {
      int index = 0;
      depts.forEach((Department el) {
        print("Department " + (++index).toString() + " is : " + el.name);
      });
    } else {
      print("There is no department yet");
    }
    stdin.readLineSync();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'doctors': doctors.map((x) => x.toMap()).toList(),
      'nurses': nurses.map((x) => x.toMap()).toList(),
      'appointments': appointments.map((x) => x.toMap()).toList(),
      'receptionist': receptionist?.toMap(),
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id'] as int,
      name: map['name'] as String,
      doctors: List<Doctor>.from(
        (map['doctors'] as List).map<Doctor>(
          (x) => Doctor.fromMap(x as Map<String, dynamic>),
        ),
      ),
      nurses: List<Nurse>.from(
        (map['nurses'] as List).map<Nurse>(
          (x) => Nurse.fromMap(x as Map<String, dynamic>),
        ),
      ),
      appointments: List<Appointment>.from(
        (map['appointments'] as List).map<Appointment>(
          (x) => Appointment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      receptionist: map['receptionist'] != null
          ? Receptionist.fromMap(map['receptionist'] as Map<String, dynamic>)
          : null,
    );
  }
}
