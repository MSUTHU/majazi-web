import 'package:flutter/material.dart';
import 'package:untitled_web/Web_pages/About_page.dart';
import 'package:untitled_web/Web_pages/Contact_page.dart';
import 'package:untitled_web/Web_pages/Home_page.dart';
import 'package:untitled_web/Web_pages/services_page.dart';

class MainFragmentPage extends StatefulWidget {
  int intitializer;
  MainFragmentPage({super.key, required this.intitializer});

  @override
  State<MainFragmentPage> createState() => _MainFragmentPageState();
}

class _MainFragmentPageState extends State<MainFragmentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.intitializer,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueGrey,
                  Colors.black12,
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
          ),
          title: Text(
            'Majazi Tech',
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Home', icon: Icon(Icons.home)),
              Tab(text: 'Services', icon: Icon(Icons.miscellaneous_services)),
              Tab(text: 'About', icon: Icon(Icons.note_rounded)),
              Tab(
                  text: 'Contact',
                  icon: Icon(Icons
                      .phone_android)), // Fixed duplicate 'Services' tab text
            ],
            indicator: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.greenAccent, // Border color
                  width: 4.0, // Border width
                ),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            dividerColor: Colors.transparent,
            // This removes the bottom line (indicator)
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(),
            ServicesPage(
              intitializer: 0,
            ),
            AboutPage(),
            ContactPage()
          ],
        ),
      ),
    );
  }
}
