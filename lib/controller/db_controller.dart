import 'package:db_demo_app/helpers/db_helper.dart';
import 'package:db_demo_app/models/stud_model.dart';
import 'package:get/get.dart';

class DbController extends GetxController {
  RxList<Student> allStudents = <Student>[].obs;

  Future<void> init() async {
    allStudents(await DbHelper.dbHelper.getData());
  }

  Future<void> updateStudent({required Student student}) async {
    await DbHelper.dbHelper.update(student: student).then(
          (value) => init(),
        );
  }

  Future<void> addStudent({required Student student}) async {
    await DbHelper.dbHelper.insert(student: student).then(
          (value) => init(),
        );
  }

  Future<void> deleteStudent({required Student student}) async {
    await DbHelper.dbHelper.delete(student: student).then(
          (value) => init(),
        );
  }
}
