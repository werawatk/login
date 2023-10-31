import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myappit2/model/facultymodel.dart';
import 'package:http/http.dart' as http;

class MyContact extends StatefulWidget {
  const MyContact({super.key});

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  // กำหนดตัวแปรข้อมูล facultys
  late Future<List<FacultyModel>> facultys;

  @override
  void initState() {
    super.initState();
    facultys = fetchFaculty();
  }

  Future<void> _refresh() async {
    setState(() {
      facultys = fetchFaculty();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: facultys,
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: Text("${data.error}"),
              );
            } else if (data.hasData) {
              var items = data.data as List<FacultyModel>;
              return ListView.builder(
                itemCount: items == null ? 0 : items.length,
                itemBuilder: (BuildContext context, int index) {
                  FacultyModel faculty = data.data![index];

                  Widget card; // สร้างเป็นตัวแปร
                  card = Container(
                      child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(_viewFaculty(context, faculty));
                    },
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Image(
                              width: 150,
                              height: 150,
                              image: NetworkImage(
                                  'http://10.50.200.102/webit65/img/' +
                                      items[index].facImg.toString()),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.business),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              items[index].facName.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.phone),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              items[index].facPhone.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(onPressed: () {}, child: Icon(Icons.edit)),
                          TextButton(
                            onPressed: () {},
                            child: Icon(Icons.delete),
                          )
                        ],
                      ),
                    ),
                  ));
                  return card;
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  // สร้างฟังก์ชั่น ที่คืนค่าเป็น route ของ object ฟังก์ชั่นนี้ มี context และ faculty เป็น parameter
  static Route<Object?> _viewFaculty(
      BuildContext context, FacultyModel faculty) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) => // ใช้ arrow aฟังก์ชั่น
          Dismissible(
        // คืนค่าเป็น dismissible widget
        direction: DismissDirection.vertical, // เมื่อปัดลงในแนวตั้ง
        key: const Key('key'), // ต้องกำหนด key ใช้ค่าตามนี้ได้เลย
        onDismissed: (_) => Navigator.of(context).pop(), // ปัดลงเพื่อปิด
        child: Scaffold(
          extendBodyBehindAppBar: true, // แสดงพื้นที่ appbar แยก ให้ขายเต็มจอ
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close, color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Center(
            child: Container(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                        'http://10.50.200.102/webit65/img/' + faculty.facImg),
                    SizedBox(height: 10.0),
                    Text(
                      faculty.facName,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 5.0),
                    Text('เบอร์โทร:  ${faculty.facPhone}'),
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}

// สรัางฟังก์ชั่นดึงข้อมูล คืนค่ากลับมาเป็นข้อมูล Future ประเภท List ของ Product
Future<List<FacultyModel>> fetchFaculty() async {
  // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
  String url = 'http://10.50.200.102/webit65/selectfacs.php';
  final response = await http.get(Uri.parse(url));

  // เมื่อมีข้อมูลกลับมา
  if (response.statusCode == 200) {
    // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<Product
    // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parseProducts
    // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
    return compute(parseFacultys, response.body);
  } else {
    // กรณี error
    throw Exception('Failed to load Facultys');
  }
}

// ฟังก์ชั่นแปลงข้อมูล JSON String data เป็น เป็นข้อมูล List<Product>
List<FacultyModel> parseFacultys(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<FacultyModel>((json) => FacultyModel.fromJson(json))
      .toList();
}
