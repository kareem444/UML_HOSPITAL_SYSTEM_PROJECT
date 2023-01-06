import '../person.dart';

abstract class Staff extends Person {
  int salary;
  DateTime start_date;
  int department_id;

  Staff({
    required this.salary,
    required this.start_date,
    required this.department_id,
    required super.id,
    required super.address,
    required super.age,
    required super.gender,
    required super.name,
    required super.phone,
  });
}
