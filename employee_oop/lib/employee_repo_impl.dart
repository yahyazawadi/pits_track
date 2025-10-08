import 'package:employee_oop/employee_repo.dart';
import 'package:employee_oop/pay_type_enum.dart';

class EmployeeRepositoryImplementation extends EmployeeRepository {
  EmployeeRepositoryImplementation(
    super.birthdate,
    super.fullname,
    super.payRate,
    super.type,
  );

  @override
  int get age => DateTime.now().year - birthdate.year;
  @override
  double calculateSalary(double workedUnits) {
    switch (type) {
      case PayType.hourly:
        return payRate * workedUnits;
      case PayType.daily:
        return payRate * workedUnits;
      case PayType.monthly:
        return payRate;
    }
  }
}
