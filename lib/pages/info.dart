import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:myappit2/model/shopmodel.dart';
import 'package:http/http.dart' as http;

class MyInfo extends StatefulWidget {
  const MyInfo({super.key});

  @override
  State<MyInfo> createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  // กำหนดตัวแปรข้อมูล products
  late Future<List<ProductShop>> products;
  // ตัว ScrollController สำหรับจัดการการ scroll ใน ListView
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    products = fetchProduct();
  }

  Future<void> _refresh() async {
    setState(() {
      products = fetchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<ProductShop>>(
          // ชนิดของข้อมูล
          future: products, // ข้อมูล Future
          builder: (context, snapshot) {
            // มีข้อมูล และต้องเป็น done ถึงจะแสดงข้อมูล ถ้าไม่ใช่ ก็แสดงตัว loading
            if (snapshot.hasData) {
              bool _visible =
                  false; // กำหนดสถานะการแสดง หรือมองเห็น เป็นไม่แสดง
              if (snapshot.connectionState == ConnectionState.waiting) {
                // เมื่อกำลังรอข้อมูล
                _visible = true; // เปลี่ยนสถานะเป็นแสดง
              }
              if (_scrollController.hasClients) {
                //เช็คว่ามีตัว widget ที่ scroll ได้หรือไม่ ถ้ามี
                // เลื่อน scroll มาด้านบนสุด
                _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              }
              return Column(
                children: [
                  Visibility(
                    child: const LinearProgressIndicator(),
                    visible: _visible,
                  ),
                  Container(
                    // สร้างส่วน header ของลิสรายการ
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.orange.withAlpha(100),
                    ),
                    child: Row(
                      children: [
                        Text(
                            'Total ${snapshot.data!.length} items'), // แสดงจำนวนรายการ
                      ],
                    ),
                  ),
                  Expanded(
                    // ส่วนของลิสรายการ
                    child: snapshot.data!.isNotEmpty // กำหนดเงื่อนไขตรงนี้
                        ? RefreshIndicator(
                            onRefresh: _refresh,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GridView.builder(
                                controller:
                                    _scrollController, // กำนหนด controller ที่จะใช้งานร่วม
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.67,
                                ),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ProductShop product = snapshot.data![index];

                                  Widget card; // สร้างเป็นตัวแปร
                                  card = Container(
                                      child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(_viewProduct(context, product));
                                    },
                                    child: Card(
                                      child: Column(
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1.0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                              ),
                                              child:
                                                  Image.network(product.image),
                                            ),
                                          ),
                                          Expanded(
                                            child: AspectRatio(
                                              aspectRatio: 2.0,
                                              child: Container(
                                                  color:
                                                      Colors.grey.withAlpha(20),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Text(
                                                          product.title,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Text.rich(
                                                          TextSpan(children: [
                                                            TextSpan(
                                                                text: 'Price: ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                            TextSpan(
                                                              text:
                                                                  '\$ ${product.price}',
                                                            ),
                                                          ]),
                                                        ),
                                                        Text.rich(
                                                          TextSpan(children: [
                                                            TextSpan(
                                                                text:
                                                                    'Category: ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .blue,
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                )),
                                                            TextSpan(
                                                              text:
                                                                  '${product.category}',
                                                            ),
                                                          ]),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                                  return card;
                                },
                                //           separatorBuilder: (BuildContext context, int index) => const SizedBox(),
                              ),
                            ),
                          )
                        : const Center(
                            child: Text('No items')), // กรณีไม่มีรายการ
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              // กรณี error
              return Text('${snapshot.error}');
            }
            // กรณีสถานะเป็น waiting ยังไม่มีข้อมูล แสดงตัว loading
            return const RefreshProgressIndicator();
          },
        ),
      ),
    );
  }

  // สร้างฟังก์ชั่น ที่คืนค่าเป็น route ของ object ฟังก์ชั่นนี้ มี context และ product เป็น parameter
  static Route<Object?> _viewProduct(
      BuildContext context, ProductShop product) {
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
          body: Container(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                      child: Container(
                          width: 350,
                          height: 350,
                          child: Image.network(product.image))),
                  SizedBox(height: 10.0),
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 5.0),
                  Text('Price: \$ ${product.price}'),
                  SizedBox(height: 10.0),
                  Text('Price: ${product.description}'),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}

// สรัางฟังก์ชั่นดึงข้อมูล คืนค่ากลับมาเป็นข้อมูล Future ประเภท List ของ Product
Future<List<ProductShop>> fetchProduct() async {
  // ทำการดึงข้อมูลจาก server ตาม url ที่กำหนด
  String url = 'https://fakestoreapi.com/products';
  final response = await http.get(Uri.parse(url));

  // เมื่อมีข้อมูลกลับมา
  if (response.statusCode == 200) {
    // ส่งข้อมูลที่เป็น JSON String data ไปทำการแปลง เป็นข้อมูล List<Product
    // โดยใช้คำสั่ง compute ทำงานเบื้องหลัง เรียกใช้ฟังก์ชั่นชื่อ parseProducts
    // ส่งข้อมูล JSON String data ผ่านตัวแปร response.body
    return compute(parseProducts, response.body);
  } else {
    // กรณี error
    throw Exception('Failed to load product');
  }
}

// ฟังก์ชั่นแปลงข้อมูล JSON String data เป็น เป็นข้อมูล List<Product>
List<ProductShop> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<ProductShop>((json) => ProductShop.fromJson(json)).toList();
}
