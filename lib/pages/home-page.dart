import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/widgets/input-field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String studentName, studentDepartment;
  double studentID, studentCG;

  void getStudentName(name) {
    this.studentName = name;
  }

  void getStudentID(id) {
    this.studentID = double.parse(id);
  }

  void getStudentDepartment(department) {
    this.studentDepartment = department;
  }

  void getStudentCG(cg) {
    this.studentCG = double.parse(cg);
  }

  void createData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("StudentsInfo").doc(studentName);
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studentDepartment": studentDepartment,
      "studentCG": studentCG,
    };
    documentReference.set(students).whenComplete(
      () {
        print('$studentName created');
      },
    );
  }

  void readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("StudentsInfo").doc(studentName);
    documentReference.get().then(
      (snapshot) {
        print(
          snapshot.data(),
        );
      },
    );
  }

  void updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("StudentsInfo").doc(studentName);
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studentDepartment": studentDepartment,
      "studentCG": studentCG,
    };
    documentReference.set(students).whenComplete(
      () {
        print('$studentName updated');
      },
    );
  }

  void deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("StudentsInfo").doc(studentName);
    documentReference.delete().whenComplete(
      () {
        print('$studentName deleted');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.amber[50],
        elevation: 0.0,
        title: Text(
          'Student\'s Information',
          style: GoogleFonts.raleway(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Import students\ninformation here!',
                    style: GoogleFonts.raleway(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SvgPicture.asset(
                    'images/city.svg',
                    height: MediaQuery.of(context).size.height * .14,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InputField(
                  label: "Name",
                  hintText: 'Enter student\'s name',
                  onChanged: (String name) {
                    getStudentName(name);
                  },
                ),
                InputField(
                  label: "ID No",
                  hintText: 'Enter students ID no',
                  onChanged: (String id) {
                    getStudentID(id);
                  },
                ),
                InputField(
                  label: "Department",
                  hintText: 'Enter department',
                  onChanged: (String department) {
                    getStudentDepartment(department);
                  },
                ),
                InputField(
                  label: "CGPA",
                  hintText: 'Enter CGPA',
                  onChanged: (String cg) {
                    getStudentCG(cg);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[600],
                  ),
                  onPressed: () {
                    createData();
                  },
                  child: Text('Create'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.purple[600]),
                  onPressed: () {
                    readData();
                  },
                  child: Text('Read'),
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(primary: Colors.blueGrey[600]),
                  onPressed: () {
                    updateData();
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red[600]),
                  onPressed: () {
                    deleteData();
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
