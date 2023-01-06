import 'dart:io';
import '../constants.dart';
import '../department/department.dart';
import '../helpers/terminal_helper.dart';
import '../jsonHelper.dart';
import '../medicine/medicine.dart';

class Hospital {
  String name;
  String phone;
  String address;

  List<Department> departments = [];
  List<Medicine> medicines = [];

  Hospital({
    required this.name,
    required this.phone,
    required this.address,
    required this.departments,
    required this.medicines,
  });

  viewData() {
    print("- The hospital name is : $name");
    print("- The hospital address is : $address");
    print("- The hospital phone is : $phone");
    print("Enter any button to back");
    stdin.readLineSync();
  }

  editHospitalName() async {
    print('1. Enter the new name : ');
    String hospitalName = stdin.readLineSync() ?? "Default Name";
    this.name = hospitalName;
    await saveData(this);
  }

  editHospitalAddress() async {
    print('1. Enter the new address : ');
    String hospitalAddress = stdin.readLineSync() ?? "Default Address";
    this.address = hospitalAddress;
    await saveData(this);
  }

  editHospitalPhone() async {
    print('1. Enter the new phone : ');
    String hospitalPhone = stdin.readLineSync() ?? "Default Phone";
    this.phone = hospitalPhone;
    await saveData(this);
  }

  addDepartment(Department department) async {
    try {
      int dept = departments.indexWhere((el) => el.id == department.id);
      if (dept != -1) {
        departments.removeWhere((element) => element.id == department.id);
      }
      this.departments.add(department);
      await saveData(this);
    } catch (e) {
      print(e);
    }
  }

  deleteDeparment(int? id) async {
    if (departments.length > 0) {
      if (id != null) {
        if (id <= departments.length && id > 0) {
          departments.removeWhere((el) => el.id == id);
          await saveData(this);
        } else {
          print("thi department not exist");
        }
      } else {
        TerminalHelper.invalidOption();
      }
    } else {
      TerminalHelper.noDepartments();
    }
  }

  Department? getDepartmentByName(String departmentName) {
    try {
      Department? dept =
          departments.firstWhere((Department el) => el.name == departmentName);
      return dept;
    } catch (e) {
      print("No department in this name, press any key to continue");
      stdin.readLineSync();
      return null;
    }
  }

  addMedicine() async {
    print("Add medicine");
    print("-" * 20);
    print("Enter the medicine name : ");
    String medicineName = stdin.readLineSync() ?? "Default Medicine";
    print("Enter the medicine cost : ");
    double medicineCost = double.parse(stdin.readLineSync() ?? "100");
    print("Enter the medicine description : ");
    String medicineDesc = stdin.readLineSync() ?? "Default Description";
    print("Enter the medicine company : ");
    String medicineCompany = stdin.readLineSync() ?? "Default Company";

    medicines.add(
      Medicine(
        id: medicines.length + 1,
        cost: medicineCost,
        name: medicineName,
        description: medicineDesc,
        company: medicineCompany,
      ),
    );
    await saveData(this);
  }

  removemedicine() async {
    if (medicines.length > 0) {
      print("select one of thes medicins to Remove, or press 0 to leave");
      print("-" * 20);

      medicines.forEach((el) {
        print("${el.id} - the name : ${el.name}, the company : ${el.company}.");
      });

      int option = int.parse(stdin.readLineSync() ?? "0");

      if (option > 0) {
        int index = medicines.indexWhere((el) => el.id == option);
        if (index != -1) {
          medicines.removeWhere((el) => el.id == option);
          await saveData(this);
        } else {
          TerminalHelper.invalidOption();
        }
      }
    } else {
      TerminalHelper.noMedicens();
    }
  }

  void removeDepartment(Department department) {
    departments.removeWhere((Department el) => el.id == department.id);
  }

  static enter() async {
    Map<String, dynamic>? data = await JsonHelper.readJsonFile();
    if (data?[Constants.hospital] != null) {
      return;
    }
    print('Hospital Management System');
    print('-' * 20);
    print('Enter the hospital name : ');
    String hospitalName = stdin.readLineSync() ?? "Default Name";
    print('Enter the hospital address : ');
    String hospitalAddress = stdin.readLineSync() ?? "Default address";
    print('Enter the hospital phone : ');
    String hospitalPhone = stdin.readLineSync() ?? "Default phone";

    await JsonHelper.writeJsonFile(
      data: {
        Constants.hospital: Hospital(
          name: hospitalName,
          phone: hospitalPhone,
          address: hospitalAddress,
          departments: [],
          medicines: [],
        ).toMap(),
      },
    );
  }

  control() async {
    while (true) {
      print("\x1B[2J\x1B[0;0H");
      print('Hospital $name System');
      print('-' * 20);
      print('1. view hospital information');
      print('2. Edit hospital name');
      print('3. Edit hospital address');
      print('4. Edit hospital phone');
      print('5. Add medicine');
      print('6. remove medicine');
      print('7. Cancel');

      int option = int.parse(stdin.readLineSync() ?? "");
      print("\x1B[2J\x1B[0;0H");

      if (option == 1) {
        viewData();
      } else if (option == 2) {
        await editHospitalName();
      } else if (option == 3) {
        await editHospitalAddress();
      } else if (option == 4) {
        await editHospitalPhone();
      } else if (option == 5) {
        await addMedicine();
      } else if (option == 6) {
        await removemedicine();
      } else if (option == 7) {
        break;
      } else {
        TerminalHelper.invalidOption();
      }
    }
  }

  saveData(Hospital hospital) async {
    await JsonHelper.writeJsonFile(
      data: {
        Constants.hospital: hospital.toMap(),
      },
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'address': address,
      'departments': departments.map((x) => x.toMap()).toList(),
      'medicines': medicines.map((x) => x.toMap()).toList(),
    };
  }

  factory Hospital.fromMap(Map<String, dynamic> map) {
    return Hospital(
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] as String,
      departments: List<Department>.from(
        (map['departments'] as List).map<Department>(
          (x) => Department.fromMap(x as Map<String, dynamic>),
        ),
      ),
      medicines: List<Medicine>.from(
        (map['medicines'] as List).map<Medicine>(
          (x) => Medicine.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
