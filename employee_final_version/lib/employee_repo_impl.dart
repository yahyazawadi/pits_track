import 'package:employee_oop/employee_repo.dart';
import 'package:employee_oop/employee_model.dart';
import 'package:employee_oop/pay_type_enum.dart';
import 'package:collection/collection.dart';

class EmployeeRepositoryImplementation implements EmployeeRepository {
  final List<Employee> _employees = [];
  @override
  void addEmployee(Employee employee) {
    _employees.add(employee);
  }

  @override
  List<Employee> getAllEmployees() {
    return List.unmodifiable(_employees);
  }

  @override
  Employee? getEmployeeByName(String fullName) {
    return _employees.firstWhereOrNull((e) => e.fullName == fullName);

    // is this ok instead of just using firstWhere and throwing an argument error ?
  }

  @override
  List<Employee> getEmployeesByPayType(PayType payType) {
    return _employees.where((e) => e.payType == payType).toList();
  }

  @override
  void removeEmployee(String fullName) {
    _employees.removeWhere((e) => e.fullName == fullName);
  }
}
