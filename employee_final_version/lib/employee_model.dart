import 'package:employee_oop/pay_type_enum.dart';

class Employee {
  // Private fields
  DateTime _birthdate;
  String _fullName;
  double _payRate;
  double _timeWorked;
  String _position;
  String _department;
  PayType _payType;

  //  private named constructor
  Employee._internal({
    required DateTime birthdate,
    required String fullName,
    required double payRate,
    double timeWorked = 0,
    String position = "unknown",
    String department = "unknown",
    required PayType payType,
  }) : _birthdate = birthdate,
       _fullName = fullName,
       _payRate = payRate,
       _timeWorked = timeWorked,
       _position = position,
       _department = department,
       _payType = payType;

  // other Named constructors instead of subclasses
  Employee.daily({
    required DateTime birthdate,
    required String fullName,
    required double payRate,
    required double timeWorked,
    String position = "unknown",
    String department = "unknown",
  }) : this._internal(
         birthdate: birthdate,
         fullName: fullName,
         payRate: payRate,
         timeWorked: timeWorked,
         position: position,
         department: department,
         payType: PayType.daily,
       );

  Employee.hourly({
    required DateTime birthdate,
    required String fullName,
    required double payRate,
    required double timeWorked,
    String position = "unknown",
    String department = "unknown",
  }) : this._internal(
         birthdate: birthdate,
         fullName: fullName,
         payRate: payRate,
         timeWorked: timeWorked,
         position: position,
         department: department,
         payType: PayType.hourly,
       );

  Employee.monthly({
    required DateTime birthdate,
    required String fullName,
    required double payRate,
    String position = "unknown",
    String department = "unknown",
  }) : this._internal(
         birthdate: birthdate,
         fullName: fullName,
         payRate: payRate,
         payType: PayType.monthly,
         position: position,
         department: department,
       );

  // getters
  PayType get payType => _payType;
  DateTime get birthdate => _birthdate;
  String get fullName => _fullName;
  double get payRate => _payRate;
  double get timeWorked => _timeWorked;
  String get position => _position;
  String get department => _department;
  DateTime get birthDate => _birthdate;
  int get age => DateTime.now().year - _birthdate.year;

  // setters
  set fullName(String name) => _fullName = name;
  set payRate(double rate) => _payRate = rate;
  set timeWorked(double hours) => _timeWorked = hours;
  set position(String pos) => _position = pos;
  set department(String dept) => _department = dept;
  set birthdate(DateTime date) => _birthdate = date;
  set payType(PayType type) => _payType = type;

  @override
  String toString() {
    return 'Name: $_fullName, Age: $age, Position: $_position, Department: $_department, Pay Rate: $_payRate, Pay Type: ${_payType.name}';
  }
}
