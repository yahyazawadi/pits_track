import 'package:employee_oop/models/imp/daily_employee.dart';
import 'package:employee_oop/models/imp/hourly_employee.dart';
import 'package:employee_oop/models/imp/monthly_employee.dart';
import 'package:employee_oop/pay_type_enum.dart';
import 'package:employee_oop/employee_repo/employee_repo_impl.dart';

void main() {
  final repo = EmployeeRepositoryImplementation();

  var emp1 = DailyEmployee(
    birthdate: DateTime(1995, 4, 12),
    fullName: "Ali Hasan",
    payRate: 50.0,
    timeWorked: 20,
    position: "Technician",
    department: "Maintenance",
  );

  var emp2 = HourlyEmployee(
    birthdate: DateTime(1998, 9, 20),
    fullName: "Sara Ahmad",
    payRate: 10.0,
    timeWorked: 160,
    position: "Assistant",
    //department: "HR",
  );

  var emp3 = MonthlyEmployee(
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
    print(
      "Total Salary: ${e.calculateTotalSalary(bonusTime: 5, bonusRate: 1.2)}\n",
    );
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
 get Employees by PayType: hourly
=================
 ''');
  var hourly = repo.getEmployeesByPayType(PayType.hourly);
  for (var e in hourly) {
    print(e.fullName);
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
