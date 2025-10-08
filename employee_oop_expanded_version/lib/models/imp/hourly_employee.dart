import 'package:employee_oop/models/employee_model.dart';
import 'package:employee_oop/pay_type_enum.dart';

class HourlyEmployee extends Employee {
  HourlyEmployee({
    required super.birthdate,
    required super.fullName,
    required super.payRate,
    required super.timeWorked,
    super.position,
    super.department,
  });

  @override
  PayType get payType => PayType.hourly;
}
