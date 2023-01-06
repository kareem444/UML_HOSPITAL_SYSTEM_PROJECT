import 'dart:io';
import 'department/department.dart';
import 'hospital/hospital.dart';
import 'person/staff/doctor.dart';
import 'person/staff/nurse.dart';

class TerminalHelper {
  static clearTerminal() {
    print("\x1B[2J\x1B[0;0H");
  }

  static invalidOption() async {
    print('Invalid option, Press any key to back');
    print('-' * 20);
    await stdin.readLineSync();
  }

  static Future<int> systemControl(Hospital hospital) async {
    print('Hospital ${hospital.name} System');
    print('-' * 20);
    print('1. Hospital');
    print('2. Departments');
    print('3. Exit');
    print('Enter a number: ');

    int option = await int.parse(stdin.readLineSync() ?? "3");
    print("\x1B[2J\x1B[0;0H");

    return option;
  }

  static Future<int> hospitalControl(Hospital hospital) async {
    print("\x1B[2J\x1B[0;0H");
    print('Hospital ${hospital.name} System');
    print('-' * 20);
    print('1. view hospital information');
    print('2. Edit hospital name');
    print('3. Edit hospital address');
    print('4. Edit hospital phone');
    print('5. Add medicine');
    print('6. remove medicine');
    print('7. Cancel');

    int option = await int.parse(stdin.readLineSync() ?? "7");
    print("\x1B[2J\x1B[0;0H");
    return option;
  }

  static Future<int> departmentControl() async {
    print("\x1B[2J\x1B[0;0H");
    print('Manage the departments');
    print('-' * 20);
    print('1. view all');
    print('2. select');
    print('3. add one');
    print('4. delete one');
    print('5. Cancle');

    int option = await int.parse(stdin.readLineSync() ?? "5");
    print("\x1B[2J\x1B[0;0H");

    return option;
  }

  static departmentNotFound() async {
    print("-" * 20);
    print("this department is not exist");
    print("enter any key to leave.");
    await stdin.readLineSync();
  }

  static Future<int> selectedDepartmentControl(Department department) async {
    print("\x1B[2J\x1B[0;0H");
    print("Department ${department.name} manage");
    print("-" * 20);
    print('1. doctors');
    print('2. nurses');
    print('3. Receptionist');
    print('4. Cancel');

    int option = await int.parse(stdin.readLineSync() ?? "");
    print("\x1B[2J\x1B[0;0H");

    return option;
  }

  static departmentNameExist() async {
    print("-" * 20);
    print("this department name is already exist");
    print("enter any key to leave.");
    await stdin.readLineSync();
  }

  static Future<int> doctorControl(Department department) async {
    print("\x1B[2J\x1B[0;0H");
    print("Manage Doctors in deaprtment ${department.name}");
    print("-" * 20);
    print('1. add');
    print('2. delete');
    print('3. select doctor');
    print('4. cancle');
    print("Please Enter Number : ");

    int option = await int.parse(stdin.readLineSync() ?? "");
    print("\x1B[2J\x1B[0;0H");

    return option;
  }

  static Future<int> selectedDoctor(Doctor doctor) async {
    print("\x1B[2J\x1B[0;0H");
    print(
        "Doctor ${doctor.name} selected, specialization is ${doctor.specialization}");
    print("-" * 20);
    print('1. examine patient');
    print('2. descripe medicine for patient');
    print('3. cancle');
    print("Please Enter Number : ");

    int option = await int.parse(stdin.readLineSync() ?? "");
    print("\x1B[2J\x1B[0;0H");

    return option;
  }

  static Future<int> nurseControl(Department department) async {
    print("\x1B[2J\x1B[0;0H");
    print("Manage nurses in deaprtment ${department.name}");
    print("-" * 40);
    print('1. add');
    print('2. delete');
    print('3. select');
    print('4. cancle');
    print("Please Enter Number : ");

    int option = await int.parse(stdin.readLineSync() ?? "");
    print("\x1B[2J\x1B[0;0H");

    return option;
  }

  static Future<int> selectedNurse(Nurse nurse) async {
    print("\x1B[2J\x1B[0;0H");
    print("Nurse ${nurse.name} selected");
    print("-" * 20);
    print('1. administer medicens');
    print('2. cancel');

    int option = await int.parse(stdin.readLineSync() ?? "2");
    print("\x1B[2J\x1B[0;0H");

    return option;
  }

  static Future<int> receptionistControl(Department department) async {
    print("Manage receptionist in deaprtment ${department.name}");
    print("-" * 40);
    print('1. add');
    print('2. delete');
    print('3. select');
    print('4. cancle');
    print("Please Enter Number : ");

    int option = await int.parse(stdin.readLineSync() ?? "");
    print("\x1B[2J\x1B[0;0H");

    return option;
  }

  static Future<int> selectdReceptionist() async {
    print("\x1B[2J\x1B[0;0H");
    print("receptionist selected");
    print("-" * 40);
    print('1. book appointment');
    print('2. discharg patient');
    print('3. cancle');
    print("Please Enter Number : ");

    int option = await int.parse(stdin.readLineSync() ?? "0");
    print("\x1B[2J\x1B[0;0H");

    return option;
  }
}
