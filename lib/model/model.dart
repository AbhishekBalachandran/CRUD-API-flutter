class EmployeeApiModel {
    String? status;
    List<Employee>? employees;
    int? totalResults;

    EmployeeApiModel({
        this.status,
        this.employees,
        this.totalResults,
    });

    factory EmployeeApiModel.fromJson(Map<String, dynamic> json) => EmployeeApiModel(
        status: json["status"],
        employees: json["employees"] == null ? [] : List<Employee>.from(json["employees"]!.map((x) => Employee.fromJson(x))),
        totalResults: json["totalResults"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "employees": employees == null ? [] : List<dynamic>.from(employees!.map((x) => x.toJson())),
        "totalResults": totalResults,
    };
}

class Employee {
    String? id;
    String? employeeName;
    String? designation;

    Employee({
        this.id,
        this.employeeName,
        this.designation,
    });

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        employeeName: json["employee_name"],
        designation: json["designation"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "employee_name": employeeName,
        "designation": designation,
    };
}
