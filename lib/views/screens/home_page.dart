import 'package:db_demo_app/controller/db_controller.dart';
import 'package:db_demo_app/models/stud_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DbController dbController = Get.find<DbController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Db App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => ListView.builder(
            itemCount: dbController.allStudents.length,
            itemBuilder: (context, index) {
              Student student = dbController.allStudents[index];

              return ExpansionTile(
                leading: Text(student.id.toString()),
                title: Text(student.name),
                trailing: Text(student.age.toString()),
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Edit student"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                initialValue: student.name,
                                onChanged: (val) => student.name = val,
                              ),
                              TextFormField(
                                initialValue: student.age.toString(),
                                onChanged: (val) =>
                                    student.age = int.parse(val),
                              ),
                            ],
                          ),
                          actions: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                dbController
                                    .updateStudent(student: student)
                                    .then(
                                      (value) => Navigator.pop(context),
                                    );
                              },
                              child: const Text("Add"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text("Update"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      dbController.deleteStudent(student: student);
                    },
                    child: const Text("Delete"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Student student = Student('demo', 1, 1);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Add student"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (val) => student.name = val,
                  ),
                  TextField(
                    onChanged: (val) => student.age = int.parse(val),
                  ),
                ],
              ),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    dbController.addStudent(student: student).then(
                          (value) => Navigator.pop(context),
                        );
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
