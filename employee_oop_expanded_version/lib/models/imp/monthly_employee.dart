import 'package:employee_oop/models/employee_model.dart';
import 'package:employee_oop/pay_type_enum.dart';

class MonthlyEmployee extends Employee {
  MonthlyEmployee({
    required super.birthdate,
    required super.fullName,
    required super.payRate,
    super.timeWorked,
    super.position,
    super.department,
  });

  @override
  PayType get payType => PayType.monthly;

  @override
  double calculateBaseSalary() {
    return payRate;
  }

  @override
  double calculateBonus({double bonusTime = 0, double bonusRate = 1}) {
    return payRate * bonusRate;
  }
}
