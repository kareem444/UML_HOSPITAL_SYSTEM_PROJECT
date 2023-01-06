import '../../bill/bill.dart';
import '../../medicine/medicine.dart';
import '../Person.dart';

class Patient extends Person {
  String? diagnosis;
  List<Medicine> medicins = [];
  Bill bill = new Bill();

  Patient({
    required super.id,
    required super.name,
    required super.gender,
    required super.age,
    required super.phone,
    required super.address,
    this.diagnosis,
    required this.medicins,
    required this.bill,
  });

  setDiagnosis(String diagnosis) {
    this.diagnosis = diagnosis;
    bill.amount += 100;
  }

  addMedicine(Medicine medicine) {
    this.medicins.add(medicine);
  }

  takeMedicins() {
    medicins.forEach((el) {
      bill.amount += el.cost;
    });
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'diagnosis': diagnosis,
      "id": super.id,
      "name": super.name,
      "address": super.address,
      "phone": super.phone,
      "gender": super.gender,
      "age": super.age,
      'medicins': medicins.map((x) => x.toMap()).toList(),
      'bill': bill.toMap(),
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
      diagnosis: map['diagnosis'] != null ? map['diagnosis'] as String : null,
      medicins: List<Medicine>.from(
        (map['medicins'] as List).map<Medicine>(
          (x) => Medicine.fromMap(x as Map<String, dynamic>),
        ),
      ),
      bill: Bill.fromMap(map['bill'] as Map<String, dynamic>),
      id: map["id"],
      address: map["address"],
      age: map["age"],
      name: map["name"],
      gender: map["gender"],
      phone: map["phone"],
    );
  }
}
