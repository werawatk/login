import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyAppbarPage extends StatefulWidget {
  const MyAppbarPage({super.key});

  @override
  State<MyAppbarPage> createState() => _MyAppbarPageState();
}

class _MyAppbarPageState extends State<MyAppbarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          leading: IconButton(
              onPressed: (() {
                print('แสดงเมนู');
              }),
              icon: Icon(
                Icons.menu,
              )),
          title: Text('A P P B A R'),
          actions: [
            IconButton(
                onPressed: () {
                  print('แสดงการทำงานเมนู Actions');
                },
                icon: Icon(Icons.share))
          ],
        ),
        body: SliverBar());
  }

  Widget TabBarview() {
    return Container();
  }

  Widget SliverBar() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Icon(Icons.menu),
          title: Text('S L I V E R A P P B A R'),
          expandedHeight: 300,
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    image: DecorationImage(image: AssetImage('images/1.png'))),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    image: DecorationImage(image: AssetImage('images/2.png'))),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    image: DecorationImage(image: AssetImage('images/2.png'))),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    image: DecorationImage(image: AssetImage('images/3.png'))),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    image: DecorationImage(image: AssetImage('images/3.png'))),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    image: DecorationImage(image: AssetImage('images/4.png'))),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    image: DecorationImage(image: AssetImage('images/5.png'))),
              ),
            ),
          ),
        )
      ],
    );
  }
}
