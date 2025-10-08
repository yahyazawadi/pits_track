import 'package:employee_oop/employee_repo_impl.dart';
import 'package:employee_oop/pay_type_enum.dart';

void main() {
  var emp1 = EmployeeRepositoryImplementation(
    DateTime(1995, 5, 10),
    "Alice",
    50,
    PayType.hourly,
  );

  print("Name: ${emp1.fullname}");
  print("Age: ${emp1.age}");
  print("Salary for 160 hours: ${emp1.calculateSalary(160)}");
}
