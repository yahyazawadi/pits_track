import 'package:employee_oop/pay_type_enum.dart';

abstract class Employee {
  // Private fields
  DateTime _birthdate;
  String _fullName;
  double _payRate;
  double _timeWorked;
  String _position;
  String _department;

  // named optional and required constructor
  Employee({
    required DateTime birthdate,
    required String fullName,
    required double payRate,
    double timeWorked = 0,
    String position = "unknown",
    String department = "unknown",
  }) : _birthdate = birthdate,
       _fullName = fullName,
       _payRate = payRate,
       _timeWorked = timeWorked,
       _position = position,
       _department = department;

  // getters
  PayType get payType;
  DateTime get birthdate => _birthdate;
  String get fullName => _fullName;
  double get payRate => _payRate;
  double get timeWorked => _timeWorked;
  String get position => _position;
  String get department => _department;
  int get age => DateTime.now().year - _birthdate.year;

  // Salary calculations
  double calculateBaseSalary() => payRate * timeWorked;

  double calculateBonus({double bonusTime = 0, double bonusRate = 1}) =>
      bonusTime * payRate * bonusRate;

  double calculateTotalSalary({double bonusTime = 0, double bonusRate = 1}) =>
      calculateBaseSalary() +
      calculateBonus(bonusTime: bonusTime, bonusRate: bonusRate);

  @override
  String toString() {
    return 'Name: $_fullName, Age: $age, Position: $_position, Department: $_department, Pay Rate: $_payRate, Pay Type: $payType';
  }
}
