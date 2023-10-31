import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:lottie/lottie.dart';
import 'package:myappit2/model/usermodel.dart';
import 'package:dio/dio.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final keyform = GlobalKey<FormState>();
  // final RegExp emailRegExperssion =
  //     RegExp('[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}');
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextFormField LoginEmail() {
      return TextFormField(
        controller: email,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: 'EmailAddress :',
            hintText: 'กรุณากรอกชื่ออีเมล์',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(25)),
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        validator: (value) {
          if (value!.isEmpty) {
            return ('กรุณากรอกอีเมล์ให้ถูกต้อง');
            // } else if (!emailRegExperssion.hasMatch(value)) {
            //   return ('กรอกรูปแบบอีเมล์ไม่ถูกต้อง');
          }
          return null;
        },
      );
    }

    TextFormField LoginPass() {
      return TextFormField(
        controller: password,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            labelText: 'PassWord :',
            hintText: 'กรุณากรอกรหัสผ่าน',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(25)),
        keyboardType: TextInputType.text,
        autocorrect: false,
        obscureText: true,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกรหัสผ่าน';
          }
          return null;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('L O G I N  P A G E'),
      ),
      body: ListView(children: [
        Form(
          key: keyform,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 250,
                  child: Lottie.network(
                      'https://lottie.host/0967a086-5b78-4d60-bc03-ed2f17cb6ce8/3SRHm6wxJT.json'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 223, 222),
                    border: Border.all(width: 2.0, color: Colors.black12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: LoginEmail(),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 223, 222),
                    border: Border.all(width: 2.0, color: Colors.black12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: LoginPass(),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    bool password = keyform.currentState!.validate();
                    if (password != "") {
                      singin();
                      checkAuthen();
                    }
                  },
                  child: Text(
                    'เข้าสู่ระบบ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ลงทะเบียนเพื่อสมัครเป็นสมาชิก',
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: Text(
                          'Click Here...',
                          style: TextStyle(color: Colors.red),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Future<Null> checkAuthen() async {
    String url = "http://10.50.200.102/flutter_api/logins.php";
    try {
      Response response = await Dio().get(url);
      print('res = $response');
      var result = json.decode(response.data);
    } catch (e) {}
  }

  Future<void> singin() async {
    String url = "http://10.50.200.102/flutter_api/login.php";
    var res = await http.post(Uri.parse(url), body: {
      "email": email.text,
      "password": password.text,
    });
    print('$email');
    print('$password');
    var respone = jsonDecode(res.body);
    // print(respone);
    if (respone == "error") {
      _showDialog();
    } else {
      // await User.setsignin(true);

      Navigator.popAndPushNamed(context, 'home');
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('กรุณากรอกชื่อผู้ใช้และรหัสผ่านให้ถูกต้อง'),
            content: Text('กรุณากรอกใหม่อีกครั้ง'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'))
            ],
          );
        });
  }
}
