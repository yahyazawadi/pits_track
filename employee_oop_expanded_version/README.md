all Dart Concepts Used here:

Classes:
Abstract classes and methods 
concrete methods and implementation (extends)
Constructs (Named required and optional parameters) 
Method overriding (@override)
Return type annotations 

Encapsulation:
Private fields (using _)
Getters
Computed getters instead of variables (int get age => return DateTime.now().year-birthdate.year;) 
return unmodifiable collections 

collections:
Enums PayType
List of custom objects (List<Employee> _employees = [];)
collection manipulation (add, remove, where...)
List.unmodifiable()

other dart concepts:
Null safety (Nullable types (Employee?))
Arrow syntax (=>)
String interpolation ('Name: $_fullName, Age: $age')
DateTime datatype 



OOP concepts used here:
Abstraction:
abstract classes (Employee, EmployeeRepository) and methods 

Inheritance and implementation: 
MonthlyEmployee and HourlyEmployee extends Employee (because I want to use common functions between subclasses), EmployeeRepositoryImpl implements EmployeeRepository (because I want to enforce an interface)

Polymorphism
The repository stores different employee types in a single List<Employee>.
Methods like calculateTotalSalary() or the getter payType behave differently depending on the subclass (dynamic dispatch).

Encapsulation
private fields (_fullName, _birthdate) and public getters.
This protects data integrity and prevents unwanted or possibly dangerous external modifications.




