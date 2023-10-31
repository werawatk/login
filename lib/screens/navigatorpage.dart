import 'package:flutter/material.dart';
import 'package:myappit2/model/user.dart';

import '../pages/contact.dart';
import '../pages/home.dart';
import '../pages/info.dart';

class MyNavigatorPage extends StatefulWidget {
  const MyNavigatorPage({super.key});

  @override
  State<MyNavigatorPage> createState() => _MyNavigatorPageState();
}

class _MyNavigatorPageState extends State<MyNavigatorPage> {
  int _selectIndex = 0;

  //สร้างฟังก์เช็ค login
  Future checklogin() async {
    bool? signin = await User.getsignin();
    if (signin == false) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  //สร้างฟังก์ชัน logout
  Future logout() async {
    await User.setsignin(false);
    Navigator.pushReplacementNamed(context, 'login');
  }

  void _onPressIndex(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List<Widget> _pages = [
    Myhome(),
    MyInfo(),
    MyContact(),
    Center(
      child: Text(
        'ออกจากระบบ',
        style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 242, 55, 4)),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('A P P I T'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.countertops),
              title: Text('Counter'),
              onTap: () {
                Navigator.pushNamed(context, 'counter');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Button Bar'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.app_blocking),
              title: Text('Sliver Bar'),
              onTap: () {
                Navigator.pushNamed(context, 'sliver');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('ออกจากระบบ'),
              onTap: () {
                logout();
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.blueGrey,
          currentIndex: _selectIndex,
          onTap: _onPressIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag), label: 'หน้าแรก'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'ข้อมูลสินค้า'),
            BottomNavigationBarItem(icon: Icon(Icons.business), label: 'อาคาร'),
            BottomNavigationBarItem(
              icon: Icon(Icons.production_quantity_limits),
              label: 'สินค้า',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'settings',
            ),
          ]),
    );
  }
}

class MyHome {}
