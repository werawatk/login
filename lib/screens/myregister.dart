import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:myappit2/untility/normaldialog.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key});

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final keyform = GlobalKey<FormState>();

  TextEditingController user = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: ListView(children: [
        Form(
          key: keyform,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyLogo(),
              LineSizeBox(),
              UserForm(),
              LineSizeBox(),
              EmailForm(),
              LineSizeBox(),
              PasswordForm(),
              LineSizeBox(),
              RePasswordForm(),
              LineSizeBox(),
              ButtonInput()
            ],
          ),
        ),
      ]),
    );
  }

  SizedBox LineSizeBox() => SizedBox(
        height: 10,
      );

  Container ButtonInput() {
    return Container(
      child: MaterialButton(
        onPressed: () {
          bool password = keyform.currentState!.validate();
          if (password) {
            insertrecord();
          } else {
            print('บันทึกข้อมูลไม่สำเร็จ');
          }
        },
        child: Text(
          'สมัครสมาชิก',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        color: Colors.red,
      ),
    );
  }

  Container UserForm() {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 244, 241, 240),
          border: Border.all(width: 1.2, color: Colors.black12),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_box),
            labelText: 'Username :',
            hintText: 'กรุณากรอกชื่อผู้ใช้',
            contentPadding: EdgeInsets.all(20.0),
            border: InputBorder.none),
        controller: user,
        keyboardType: TextInputType.text,
        autocorrect: false,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกชื่อผู้ใช้งาน';
          }
          return null;
        },
      ),
    );
  }

  Container EmailForm() {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 244, 241, 240),
          border: Border.all(width: 1.2, color: Colors.black12),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: 'Email :',
            hintText: 'กรุณากรอกชื่ออีเมล์',
            contentPadding: EdgeInsets.all(20.0),
            border: InputBorder.none),
        controller: email,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกชื่ออีเมล์';
          }
          return null;
        },
      ),
    );
  }

  Container PasswordForm() {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 244, 241, 240),
          border: Border.all(width: 1.2, color: Colors.black12),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: 'Password :',
            hintText: 'กรุณากรอกรหัสผ่าน',
            contentPadding: EdgeInsets.all(20.0),
            border: InputBorder.none),
        controller: password,
        keyboardType: TextInputType.text,
        autocorrect: false,
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกรหัสผ่าน';
          }
          return null;
        },
      ),
    );
  }

  Container RePasswordForm() {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 244, 241, 240),
          border: Border.all(width: 1.2, color: Colors.black12),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: 'Re-Type Password :',
            hintText: 'กรุณากรอกรหัสผ่านอีกครั้ง',
            contentPadding: EdgeInsets.all(20.0),
            border: InputBorder.none),
        keyboardType: TextInputType.text,
        autocorrect: false,
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกชื่อผู้ใช้งาน';
          } else if (value != password.text) {
            return 'รหัสผ่านที่กรอกไม่ตรงกัน';
          }
          return null;
        },
      ),
    );
  }

  Container MyLogo() {
    return Container(
      width: 250,
      height: 250,
      child: Lottie.network(
          'https://lottie.host/807cc9b8-1900-4810-813f-e78ba27e7f7b/FPuRryeMaT.json'),
    );
  }

  //สร้างฟังก์ชันเชื่อมต่อ
  Future<void> insertrecord() async {
    if (user.text != "" || email.text != "" || password.text != "") {
      try {
        String uri = "http://10.50.200.102/flutter_api/register.php";
        var res = await http.post(Uri.parse(uri), body: {
          "user": user.text,
          "email": email.text,
          "password": password.text
        });
        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          Navigator.pushReplacementNamed(context, 'login');
          print('บันทึกข้อมูลสำเร็จ');
        } else if (response["success"] == "false") {
          normalDialog(context, 'มีชื่ออีเมล์นี้ถูกใช้ไปแล้ว');
          // Navigator.pushReplacementNamed(context, 'register');
          print('บันทึกไม่สำเร็จ');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('กรุณากรอกข้อความ');
    }
  }
}
