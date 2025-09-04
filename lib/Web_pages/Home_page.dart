import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled_web/Modals/animatedOffers.dart';
import 'package:untitled_web/Modals/autoScrollMain.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled_web/Web_pages/About_page.dart';
import 'package:untitled_web/Web_pages/MainFragment_page.dart';
import 'package:untitled_web/Web_pages/services_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundContainer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: Autoscrollmain()),
            ),
            //text for view insurances
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
              child: const Text(
                "Our Offers",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: MediaQuery.sizeOf(context).height / 2.3,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Animatedoffers(
                        iconType: Icons.support_agent,
                        serviceType: "IT Support",
                        routePage: ServicesPage(intitializer: 0),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 9,
                      ),
                      Animatedoffers(
                          iconType: Icons.web_sharp,
                          serviceType: "Web Design",
                          routePage: ServicesPage(intitializer: 1)),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 9,
                      ),
                      Animatedoffers(
                        iconType: Icons.phone_android,
                        serviceType: "Mobile App Design",
                        routePage: ServicesPage(intitializer: 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )),
                child: const Text(
                  "About Us",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Center(
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => MainFragmentPage(intitializer: 2))),
                child: Container(
                  decoration: BoxDecoration(
                      border: const Border(
                          top: BorderSide(
                            color: Colors.grey,
                            width: 6.0,
                          ),
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 6.0,
                          ),
                          left: BorderSide(
                            color: Colors.grey,
                            width: 6.0,
                          ),
                          right: BorderSide(
                            color: Colors.grey,
                            width: 6.0,
                          )),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      )),
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Icon(Icons.arrow_forward)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                            "Majazi Tech is a comprehensive IT services company based in Hillaria,\n"
                            " offering a wide range of virtual and physical IT support services,\n"
                            " software engineering solutions, and community-focused services such as an internet café, copying, and printing.\n"
                            " Our mission is to deliver high-quality, reliable, and innovative technology solutions to businesses and individuals alike",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  height: 1.5,
                                  color: Colors
                                      .white // Line height for better readability
                                  ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.black12,
                    Color.fromRGBO(1, 77, 78, 1),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.greenAccent,
                    width: 5.0,
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: const [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('images/company_profile3.jpg'),
                            radius: 20.5,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 2.0,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Mazaji Tech 2024 | All rights reserved",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Terms & conditions",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Privacy Policy",
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                // Handle Facebook link tap
                              },
                              child: const Icon(Icons.facebook, size: 24),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                // Handle Twitter link tap
                              },
                              child: const Icon(Icons.tiktok, size: 24),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                // Handle Instagram link tap
                              },
                              child: const Icon(Icons.email, size: 24),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background4.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
