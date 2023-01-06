import '../department/department.dart';
import 'terminal_helper.dart';

class DoctorHelper {
  static printAllDoctors(Department department) {
    department.doctors.forEach((el) {
      print(
          "${el.id}- Doctor Name: ${el.name}, specialization: ${el.specialization}.");
    });
  }

  static Future<Department?>? deleteDoctor(Department department) async {
    if (department.doctors.length > 0) {
      int id = TerminalHelper.deleteDoctor(department);
      if (id > 0) {
        department.removeDoctor(id);
        return department;
      }
    } else {
      TerminalHelper.noDoctors();
    }
    return null;
  }
}
