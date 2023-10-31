import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:myappit2/model/productmodel.dart';
import 'package:myappit2/model/shopmodel.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  // กำหนดตัวแปรข้อมูล facultys
  late Future<List<ModelProduct>> shops;

  @override
  void initState() {
    super.initState();
    shops = ReadJsonData();
  }

  Future<void> _refresh() async {
    setState(() {
      shops = ReadJsonData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: shops,
          builder: (context, data) {
            if (data.hasError) {
              return Center(
                child: Text("${data.error}"),
              );
            } else if (data.hasData) {
              var items = data.data as List<ModelProduct>;
              return ListView.builder(
                itemCount: items == null ? 0 : items.length,
                itemBuilder: (BuildContext context, int index) {
                  ModelProduct shop = data.data![index];

                  Widget card; // สร้างเป็นตัวแปร
                  card = Container(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(_viewShop(context, shop));
                          },
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    child: Image(
                                      width: 150,
                                      height: 150,
                                      image: NetworkImage(
                                          items[index].imageUrl.toString()),
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
                                                Text('ยี่ห้อ :'),
                                                Text(items[index]
                                                    .name
                                                    .toString())
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('ราคา : '),
                                                Text(items[index]
                                                    .price
                                                    .toString()),
                                                Text(' บาท')
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )));
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
  static Route<Object?> _viewShop(BuildContext context, ModelProduct shop) {
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
                    Image.network(shop.imageUrl),
                    SizedBox(height: 10.0),
                    Text(
                      shop.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ราคา:  ${shop.price}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' บาท',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
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

Future<List<ModelProduct>> ReadJsonData() async {
  final jsondata =
      await rootBundle.loadString('assets/images/productlist.json');
  final list = jsonDecode(jsondata) as List<dynamic>;
  return list.map((e) => ModelProduct.fromJson(e)).toList();
}
