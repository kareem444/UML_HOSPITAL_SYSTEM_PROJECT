import 'dart:io';
import 'constants.dart';
import 'department/department.dart';
import 'hospital/hospital.dart';
import 'helpers/jsonHelper.dart';
import 'person/staff/doctor.dart';
import 'person/staff/nurse.dart';
import 'terminal_helper.dart';

void main(List<String> args) async {
  TerminalHelper.clearTerminal();

  await Hospital.setHospital();
  TerminalHelper.clearTerminal();

  while (true) {
    Map<String, dynamic>? data = await JsonHelper.readJsonFile();
    Hospital hospital = Hospital.fromMap(data?[Constants.hospital]);

    int option = await TerminalHelper.systemControl(hospital);

    if (option == 1) {
      hospital.control();
    } else if (option == 2) {
      //****************************************************************/
      // start department control
      //****************************************************************/
      while (true) {
        Map<String, dynamic>? data = await JsonHelper.readJsonFile();
        Hospital hospital = Hospital.fromMap(data?[Constants.hospital]);

        int option = await TerminalHelper.departmentControl();

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
                int option =
                    await TerminalHelper.selectedDepartmentControl(department);

                if (option == 1) {
                  while (true) {
                    int option = await TerminalHelper.doctorControl(department);

                    if (option == 1) {
                      department.addDoctor();
                      await hospital.addDepartment(department);
                    } else if (option == 2) {
                      print("Select Doctor to delete, or enter 0 to cancle : ");
                      print("-" * 40);
                      department.doctors.forEach((el) {
                        print(
                            "${el.id}- Doctor Name: ${el.name}, specialization: ${el.specialization}.");
                      });
                      int option = int.parse(stdin.readLineSync() ?? "0");
                      department.removeDoctor(option);
                      await hospital.addDepartment(department);
                    } else if (option == 3) {
                      Doctor? doctor = Doctor.selectDoctor(department);
                      if (doctor != null) {
                        while (true) {
                          int option =
                              await TerminalHelper.selectedDoctor(doctor);
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
                      TerminalHelper.invalidOption();
                    }
                  }
                } else if (option == 2) {
                  while (true) {
                    int option = await TerminalHelper.nurseControl(department);

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
                          int option =
                              await TerminalHelper.selectedNurse(nurse);

                          if (option == 1) {
                            Department? dept =
                                nurse.administerMedicine(hospital, department);
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
                      TerminalHelper.invalidOption();
                    }
                  }
                } else if (option == 3) {
                  int option =
                      await TerminalHelper.receptionistControl(department);
                  if (option == 1) {
                    bool isAdded = department.addReceptionist();
                    if (isAdded) {
                      await hospital.addDepartment(department);
                    }
                  } else if (option == 2) {
                    bool isRemoved = department.removeReceptionist();
                    if (isRemoved) {
                      await hospital.addDepartment(department);
                    }
                  } else if (option == 3) {
                    if (department.receptionist != null) {
                      while (true) {
                        int option = await TerminalHelper.selectdReceptionist();
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
                          TerminalHelper.invalidOption();
                        }
                      }
                    } else {
                      TerminalHelper.invalidOption();
                    }
                  } else if (option == 4) {
                    break;
                  } else {
                    TerminalHelper.invalidOption();
                  }
                } else if (option == 4) {
                  break;
                } else {
                  TerminalHelper.invalidOption();
                }
              }
              //******************************************************************* end Handle Singel department/
            }
          }
        } else if (option == 3) {
          print('Enter The Departmen name : ');
          String name = stdin.readLineSync() ?? "Default name";
          int dept = hospital.departments.indexWhere((el) => el.name == name);
          if (dept == -1) {
            await hospital.addDepartment(
              Department(
                id: hospital.departments.length + 1,
                name: name,
                doctors: [],
                nurses: [],
                appointments: [],
              ),
            );
          } else {
            TerminalHelper.departmentNameExist();
          }
        } else if (option == 4) {
          print('Enter The Departmen number to delete : ');
          int? id = int.parse(stdin.readLineSync() ?? "0");

          int dept = hospital.departments.indexWhere((el) => el.id == id);

          if (dept != -1) {
            await hospital.deleteDeparment(id);
          } else {
            TerminalHelper.departmentNotFound();
          }
        } else if (option == 5) {
          break;
        } else {
          TerminalHelper.invalidOption();
        }
      }
      //****************************************************************/
      // end department control
      //****************************************************************/
    } else if (option == 3) {
      break;
    } else {
      TerminalHelper.invalidOption();
    }
  }
}
