import 'package:employee_oop/models/employee_model.dart';
import 'package:employee_oop/pay_type_enum.dart';

abstract class EmployeeRepository {
  List<Employee> getAllEmployees();
  Employee? getEmployeeByName(String fullName);
  List<Employee> getEmployeesByPayType(PayType payType);
  void addEmployee(Employee employee);
  void removeEmployee(String fullName);
}
