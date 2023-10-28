import 'dart:convert';

import 'package:api_methods/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  EmployeeApiModel? employeeData;
  List<Employee> employeeList = [];
  final base_URL = 'http://3.92.68.133:8000/';
  fetchData() async {
    final url = Uri.parse("${base_URL}api/addemployee/");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      employeeData = EmployeeApiModel.fromJson(decodedData);
      employeeList = employeeData?.employees ?? [];
      print('Loading success');
    } else {
      print('Failed toload employee');
    }
    notifyListeners();
  }

  addData(String name, String designation) async {
    final url = Uri.parse("${base_URL}api/addemployee/");
    final response = await http
        .post(url, body: {'employee_name': name, 'designation': designation});
    if (response.statusCode == 200) {
      fetchData();
    } else {
      throw Exception("Error while adding data");
    }
    notifyListeners();
  }

  deleteData({required String id}) async {
    final url = Uri.parse("${base_URL}api/addemployee/$id/");
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      fetchData();
    } else {
      print('Deletion failed');
    }
    notifyListeners();
  }

  patch({required String id, required String name, required String designation}) async {
    final url = Uri.parse("${base_URL}api/addemployee/$id/");
    final response = await http
        .put(url, body: {'employee_name': name, 'designation': designation});
    if (response.statusCode == 200) {
      fetchData();
      print('Successfully updated');
    } else {
      print('Failed');
    }
    notifyListeners();
  }
}
