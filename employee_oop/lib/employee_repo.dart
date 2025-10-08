import 'package:employee_oop/pay_type_enum.dart';

abstract class EmployeeRepository {
  DateTime _birthdate;
  String _fullname;
  double _payRate;
  PayType _type;
  EmployeeRepository(
    this._birthdate,
    this._fullname,
    this._payRate,
    this._type,
  );
  double calculateSalary(double workedUnits);
  int get age;
  DateTime get birthdate => _birthdate;
  String get fullname => _fullname;
  double get payRate => _payRate;
  PayType get type => _type;
}
