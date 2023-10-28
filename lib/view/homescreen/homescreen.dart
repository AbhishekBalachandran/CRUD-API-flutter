import 'package:api_methods/controller/homescreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController employeeController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  @override
  void initState() {
    Provider.of<HomeScreenController>(context, listen: false).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenController>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Employee details'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 500,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: employeeController,
                        decoration: InputDecoration(
                            hintText: 'Employee name',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: designationController,
                        decoration: InputDecoration(
                            hintText: 'Designation',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Provider.of<HomeScreenController>(context,
                                        listen: false)
                                    .addData(employeeController.text,
                                        designationController.text);
                                Navigator.pop(context);
                              },
                              child: Text('Save'))),
                    )
                  ]),
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.employeeList.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title:
                        Text(provider.employeeList[index].employeeName ?? ''),
                    subtitle:
                        Text(provider.employeeList[index].designation ?? ''),
                    trailing: Container(
                      width: 100,
                      child: Row(children: [
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              employeeController.text =
                                  Provider.of<HomeScreenController>(context,
                                              listen: false)
                                          .employeeList[index]
                                          .employeeName ??
                                      '';
                              designationController.text =
                                  Provider.of<HomeScreenController>(context,
                                              listen: false)
                                          .employeeList[index]
                                          .designation ??
                                      '';
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    height: 400,
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: employeeController,
                                          decoration: InputDecoration(
                                              hintText: 'Employee name',
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: designationController,
                                          decoration: InputDecoration(
                                              hintText: 'Designation',
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Provider.of<HomeScreenController>(
                                                          context,
                                                          listen: false)
                                                      .patch(
                                                          id: '${Provider.of<
                                                                      HomeScreenController>(
                                                                  context,
                                                                  listen: false)
                                                              .employeeList[
                                                                  index]
                                                              .id}',
                                                          name:
                                                              employeeController
                                                                  .text,
                                                          designation:
                                                              designationController
                                                                  .text);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Update'))),
                                      )
                                    ]),
                                  ),
                                ),
                              );
                            }),
                        IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {
                              Provider.of<HomeScreenController>(context,
                                      listen: false)
                                  .deleteData(
                                      id: '${Provider.of<HomeScreenController>(context, listen: false).employeeList[index].id}');
                            })
                      ]),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ));
  }
}
