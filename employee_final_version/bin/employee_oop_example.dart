import 'package:employee_oop/Salary.dart';
import 'package:employee_oop/employee_model.dart';
import 'package:employee_oop/pay_type_enum.dart';
import 'package:employee_oop/employee_repo_impl.dart';

void main() {
  final repo = EmployeeRepositoryImplementation();

  var emp1 = Employee.daily(
    birthdate: DateTime(1995, 4, 12),
    fullName: "Ali Hasan",
    payRate: 50.0,
    timeWorked: 20,
    position: "Technician",
    department: "Maintenance",
  );

  var emp2 = Employee.hourly(
    birthdate: DateTime(1998, 9, 20),
    fullName: "Sara Ahmad",
    payRate: 10.0,
    timeWorked: 160,
    position: "Assistant",
    //department: "HR",
  );

  var emp3 = Employee.monthly(
    birthdate: DateTime(1990, 2, 5),
    fullName: "Mohammad Ali",
    payRate: 3000.0,
    //timeWorked is zero for monthly employees so no need to add it
    //position: "Manager",
    department: "Finance",
  );

  // Add all employees to repo
  repo.addEmployee(emp1);
  repo.addEmployee(emp2);
  repo.addEmployee(emp3);

  //testing functionalities

  print('''
=================
 All Employees
=================
 ''');
  for (var e in repo.getAllEmployees()) {
    print(e);
  }

  print('''
=================
 get by name: Sara Ahmad
=================
 ''');
  var found = repo.getEmployeeByName("Sara Ahmad");
  if (found != null) {
    print("Found: ${found.fullName}, Department: ${found.department}");
  } else {
    print("Employee not found.");
  }

  print('''
=================
 get Employees by PayType: hourly, and print salary details
=================
 ''');
  var hourly = repo.getEmployeesByPayType(PayType.hourly);
  for (var e in hourly) {
    print(e.fullName);
    final salary = Salary(e);
    print("Base Salary: \$${salary.calculateBaseSalary()}");
    print("Bonus: \$${salary.calculateBonus(bonusTime: 10, bonusRate: 0.1)}");
    print(
      "Total Salary: \$${salary.calculateTotalSalary(bonusTime: 10, bonusRate: 0.1)}",
    );
  }

  print('''
=================
 get Employees by name: Ali Hasan
=================
 ''');
  repo.removeEmployee("Ali Hasan");

  print("Remaining employees:");
  for (var e in repo.getAllEmployees()) {
    print(e.fullName);
  }
}
