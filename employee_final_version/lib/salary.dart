import 'package:employee_oop/employee_model.dart';
import 'package:employee_oop/pay_type_enum.dart';

class Salary {
  Employee employee;
  Salary(this.employee);

  // Salary calculations
  double calculateBaseSalary() {
    if (employee.payType == PayType.monthly) {
      return employee.payRate; // this is Fixed salary for monthly employees
    }
    return employee.payRate * employee.timeWorked;
  }

  double calculateBonus({double bonusTime = 0, double bonusRate = 0}) {
    if (employee.payType == PayType.monthly) {
      return employee.payRate * bonusRate;
    }
    return bonusTime * employee.payRate * bonusRate;
  }

  double calculateTotalSalary({double bonusTime = 0, double bonusRate = 0}) {
    return calculateBaseSalary() +
        calculateBonus(bonusTime: bonusTime, bonusRate: bonusRate);
  }
}
