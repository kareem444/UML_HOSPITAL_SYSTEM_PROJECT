import 'dart:io';

import '../department/department.dart';
import '../hospital/hospital.dart';
import 'terminal_helper.dart';

class DepartmentHelper {
  static Future<Department?> addDepartment(Hospital hospital) async {
    print('Enter The Departmen name : ');
    String name = await stdin.readLineSync() ?? "Default name";
    int dept = hospital.departments.indexWhere((el) => el.name == name);
    if (dept == -1) {
      return Department(
        id: hospital.departments.length + 1,
        name: name,
        doctors: [],
        nurses: [],
        appointments: [],
      );
    } else {
      TerminalHelper.departmentNameExist();
      return null;
    }
  }

  static Future<int?>? deleteDepartment(Hospital hospital) async {
    print('Enter The Departmen number to delete : ');
    int id = int.parse(stdin.readLineSync() ?? "0");

    int dept = hospital.departments.indexWhere((el) => el.id == id);

    if (dept != -1) {
      return id;
    } else {
      TerminalHelper.departmentNotFound();
      return null;
    }
  }
}
