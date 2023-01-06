import 'dart:io';
import 'constants.dart';
import 'department/department.dart';
import 'helpers/doctor_helper.dart';
import 'hospital/hospital.dart';
import 'jsonHelper.dart';
import 'person/staff/doctor.dart';
import 'person/staff/nurse.dart';

void main(List<String> args) async {
  print("\x1B[2J\x1B[0;0H");

  await Hospital.enter();
  print("\x1B[2J\x1B[0;0H");

  while (true) {
    Map<String, dynamic>? data = await JsonHelper.readJsonFile();
    Hospital hospital = Hospital.fromMap(data?[Constants.hospital]);
    print('Hospital ${hospital.name} System');
    print('-' * 20);
    print('1. Hospital');
    print('2. Departments');
    print('3. Exit');
    print('Enter a number: ');

    int option = int.parse(stdin.readLineSync() ?? "3");

    print("\x1B[2J\x1B[0;0H");

    if (option == 1) {
      await hospital.control();
    } else if (option == 2) {
      //****************************************************************/
      // start department control
      //****************************************************************/
      while (true) {
        Map<String, dynamic>? data = await JsonHelper.readJsonFile();
        Hospital hospital = Hospital.fromMap(data?[Constants.hospital]);
        print("\x1B[2J\x1B[0;0H");
        print('Manage the departments');
        print('-' * 20);
        print('1. view all');
        print('2. select');
        print('3. add one');
        print('4. delete one');
        print('5. Cancle');

        int option = int.parse(stdin.readLineSync() ?? "5");
        print("\x1B[2J\x1B[0;0H");

        if (option == 1) {
          List<Department> departs = hospital.departments;
          Department.viewAllDepartment(departs);
        } else if (option == 2) {
          print("Enter Department Name : ");
          String? name = stdin.readLineSync();
          if (name != null) {
            Department? department = hospital.getDepartmentByName(name);
            if (department != null) {
              //******************************************************************* Handle Singel department/
              while (true) {
                print("\x1B[2J\x1B[0;0H");
                print("Department ${department.name} manage");
                print("-" * 20);
                print('1. doctors');
                print('2. nurses');
                print('3. Receptionist');
                print('4. Cancel');

                int option = int.parse(stdin.readLineSync() ?? "4");
                print("\x1B[2J\x1B[0;0H");

                if (option == 1) {
                  while (true) {
                    print("\x1B[2J\x1B[0;0H");
                    print("Manage Doctors in deaprtment ${department.name}");
                    print("-" * 20);
                    print('1. add');
                    print('2. delete');
                    print('3. select doctor');
                    print('4. cancle');
                    print("Please Enter Number : ");

                    int option = int.parse(stdin.readLineSync() ?? "4");
                    print("\x1B[2J\x1B[0;0H");

                    if (option == 1) {
                      department.addDoctor();
                      await hospital.addDepartment(department);
                    } else if (option == 2) {
                      Department? dept =
                          await DoctorHelper.deleteDoctor(department);
                      if (dept != null) {
                        await hospital.addDepartment(dept);
                      }
                    } else if (option == 3) {
                      Doctor? doctor = Doctor.selectDoctor(department);
                      if (doctor != null) {
                        while (true) {
                          print("\x1B[2J\x1B[0;0H");
                          print(
                              "Doctor ${doctor.name} selected, specialization is ${doctor.specialization}");
                          print("-" * 20);
                          print('1. examine patient');
                          print('2. descripe medicine for patient');
                          print('3. cancle');
                          print("Please Enter Number : ");

                          int option = int.parse(stdin.readLineSync() ?? "3");
                          print("\x1B[2J\x1B[0;0H");

                          if (option == 1) {
                            Department? dept =
                                doctor.examinePatient(department);
                            if (dept != null) {
                              await hospital.addDepartment(department);
                            }
                          } else if (option == 2) {
                            Department? dept =
                                doctor.descripeMedicine(hospital, department);
                            if (dept != null) {
                              await hospital.addDepartment(department);
                            }
                          } else if (option == 3) {
                            break;
                          }
                        }
                      }
                    } else if (option == 4) {
                      break;
                    } else {
                      print('Invalid option, Enter any key to leave.');
                      stdin.readLineSync();
                    }
                  }
                } else if (option == 2) {
                  while (true) {
                    print("\x1B[2J\x1B[0;0H");
                    print("Manage nurses in deaprtment ${department.name}");
                    print("-" * 40);
                    print('1. add');
                    print('2. delete');
                    print('3. select');
                    print('4. cancle');
                    print("Please Enter Number : ");

                    int option = int.parse(stdin.readLineSync() ?? "4");
                    print("\x1B[2J\x1B[0;0H");

                    if (option == 1) {
                      department.addNurse();
                      await hospital.addDepartment(department);
                    } else if (option == 2) {
                      department.removeNurse();
                      await hospital.addDepartment(department);
                    } else if (option == 3) {
                      Nurse? nurse = Nurse.selectNurse(department);
                      if (nurse != null) {
                        while (true) {
                          print("\x1B[2J\x1B[0;0H");
                          print("Nurse ${nurse.name} selected");
                          print("-" * 20);
                          print('1. administer medicens');
                          print('2. cancel');

                          int option = int.parse(stdin.readLineSync() ?? "2");
                          print("\x1B[2J\x1B[0;0H");
                          if (option == 1) {
                            Department? dept =
                                nurse.giveMedicine(hospital, department);
                            if (dept != null) {
                              await hospital.addDepartment(department);
                            }
                          } else if (option == 2) {
                            break;
                          }
                        }
                      }
                    } else if (option == 4) {
                      break;
                    } else {
                      print("Invalid option, Enter any key to leave.");
                      stdin.readLineSync();
                    }
                  }
                } else if (option == 3) {
                  while (true) {
                    print("\x1B[2J\x1B[0;0H");
                    print(
                        "Manage receptionist in deaprtment ${department.name}");
                    print("-" * 40);
                    print('1. add');
                    print('2. delete');
                    print('3. select');
                    print('4. cancle');
                    print("Please Enter Number : ");

                    int option = int.parse(stdin.readLineSync() ?? "4");

                    if (option == 1) {
                      bool isAdded = department.addReceptionist();
                      if (isAdded) {
                        await hospital.addDepartment(department);
                      }
                    } else if (option == 2) {
                      bool isRemoved = department.removeReceptionist();
                      if (isRemoved) {
                        await hospital.addDepartment(department);
                        print("\x1B[2J\x1B[0;0H");
                        print("Receptionist removed, press any key to leave");
                        stdin.readLineSync();
                      }
                    } else if (option == 3) {
                      if (department.receptionist != null) {
                        while (true) {
                          print("\x1B[2J\x1B[0;0H");
                          print("receptionist selected");
                          print("-" * 40);
                          print('1. book appointment');
                          print('2. discharg patient');
                          print('3. cancle');
                          print("Please Enter Number : ");

                          int option = int.parse(stdin.readLineSync() ?? "3");
                          print("\x1B[2J\x1B[0;0H");
                          if (option == 1) {
                            Department? dept = department.receptionist
                                ?.bookAppointment(department);
                            if (dept != null) {
                              await hospital.addDepartment(department);
                            }
                          } else if (option == 2) {
                            Department? dept = department.receptionist
                                ?.disChargePatient(department);
                            if (dept != null) {
                              await hospital.addDepartment(department);
                            }
                          } else if (option == 3) {
                            break;
                          } else {
                            print("Invalid option, Enter any key to leave.");
                            stdin.readLineSync();
                          }
                        }
                      } else {
                        print("\x1B[2J\x1B[0;0H");
                        print("No receptionist yet, Enter any key to leave.");
                        stdin.readLineSync();
                      }
                    } else if (option == 4) {
                      break;
                    } else {
                      print("Invalid option, Enter any key to leave.");
                      stdin.readLineSync();
                    }
                  }
                } else if (option == 4) {
                  break;
                } else {
                  print('Invalid option, Please try agian');
                }
              }
              //******************************************************************* end Handle Singel department/
            }
          }
        } else if (option == 3) {
          print('Enter The Departmen name : ');
          String name = stdin.readLineSync() ?? "Default name";
          await hospital.addDepartment(
            Department(
              id: hospital.departments.length + 1,
              name: name,
              doctors: [],
              nurses: [],
              appointments: [],
            ),
          );
        } else if (option == 4) {
          print('Enter The Departmen number to delete : ');
          int? id = int.parse(stdin.readLineSync() ?? "0");
          await hospital.deleteDeparment(id);
        } else if (option == 5) {
          break;
        } else {
          stdout.writeln('Invalid option, Please try agian');
        }
      }
      //****************************************************************/
      // end department control
      //****************************************************************/
    } else if (option == 3) {
      break;
    } else {
      stdout.writeln('Invalid option, Please try agian');
      stdout.writeln('-' * 20);
    }
  }
}
