import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // profile image
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                        image: AssetImage("images/about102.jpeg"),
                        fit: BoxFit.cover)),
                child: Center(
                    child: Text(
                  "About Us",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.all(30),
                  child: Container(
                    width: 400,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Column(
                      children: [
                        Text(
                          "Welcome to Majazi Tech, your one-stop solution for all your IT and technology needs. Located in Hillaria,"
                          " opposite Elegant Garage inside Xativa Kitchen Decor Firm,"
                          " we are committed to providing top-notch IT support,"
                          " cutting-edge software engineering, and essential community services.",
                          style: GoogleFonts.oswald(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                height: 1.5,
                                color: Colors
                                    .white // Line height for better readability
                                ),
                          ),
                        )
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        width: 400,
                        height: MediaQuery.of(context).size.height / 2.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.yellowAccent,
                            width: 4,
                          ),
                        ),
                        child: Container(
                          color: Colors.black,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Our Mission",
                                    style: GoogleFonts.oswald(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        height: 1.5,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationThickness:
                                            2, // Line height for better readability
                                      ),
                                    )),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "At Majazi Tech, our mission is to empower businesses and individuals through innovative software solutions that drive growth,"
                                  " efficiency, and transformation. We strive to be at the forefront of technological advancement,"
                                  " delivering high-quality, reliable, and scalable software products tailored to meet the unique needs of our clients.",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors
                                            .white // Line height for better readability
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        width: 400,
                        height: MediaQuery.of(context).size.height / 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 4,
                            )),
                        child: Container(
                          color: Colors.black,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Innovation and Excellence",
                                    style: GoogleFonts.oswald(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        height: 1.5,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationThickness:
                                            2, // Line height for better readability
                                      ),
                                    )),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "We are committed to fostering a culture of innovation and excellence."
                                  " Our team of skilled engineers, developers, and designers continually"
                                  " explore emerging technologies and methodologies to create cutting-edge software "
                                  "that addresses real-world challenges. We aim to set industry standards by delivering "
                                  "products that exceed expectations in performance, usability, and reliability.",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors
                                            .white // Line height for better readability
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        width: 400,
                        height: MediaQuery.of(context).size.height / 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.lightGreen,
                              width: 4,
                            )),
                        child: Container(
                          color: Colors.black,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Customer-Centric Approach",
                                    style: GoogleFonts.oswald(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        height: 1.5,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationThickness:
                                            2, // Line height for better readability
                                      ),
                                    )),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "Our clients are at the heart of everything we do. We believe in building strong,"
                                  " collaborative relationships with our clients to understand their specific requirements and goals."
                                  " By adopting a customer-centric approach,"
                                  " we ensure that our solutions are not only technically robust but also aligned with our clients' business objectives."
                                  " Our goal is to help our clients achieve success and growth through the strategic use of technology.",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors
                                            .white // Line height for better readability
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        width: 400,
                        height: MediaQuery.of(context).size.height / 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.redAccent,
                              width: 4,
                            )),
                        child: Container(
                          color: Colors.black,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Integrity and Transparency",
                                    style: GoogleFonts.oswald(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        height: 1.5,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationThickness:
                                            2, // Line height for better readability
                                      ),
                                    )),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "Integrity and transparency are the cornerstones of our business."
                                  " We conduct our operations with honesty and uphold the highest ethical standards."
                                  " Our clients can trust us to provide clear communication, timely updates,"
                                  " and transparent processes throughout the project lifecycle."
                                  " We believe that trust and integrity are fundamental to long-lasting partnerships.",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors
                                            .white // Line height for better readability
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        width: 400,
                        height: MediaQuery.of(context).size.height / 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.lime,
                              width: 4,
                            )),
                        child: Container(
                          color: Colors.black,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Continuous Improvement and Learning",
                                    style: GoogleFonts.oswald(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        height: 1.5,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationThickness:
                                            2, // Line height for better readability
                                      ),
                                    )),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "At Majazi Tech, we embrace the philosophy of continuous improvement."
                                  " We invest in the professional development of our team,"
                                  " encouraging ongoing learning and skill enhancement."
                                  " By staying abreast of the latest industry trends and best practices,"
                                  " we ensure that our solutions remain relevant and effective in an ever-evolving technological landscape.",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors
                                            .white // Line height for better readability
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        width: 400,
                        height: MediaQuery.of(context).size.height / 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.brown,
                              width: 4,
                            )),
                        child: Container(
                          color: Colors.black,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Social Responsibility",
                                    style: GoogleFonts.oswald(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        height: 1.5,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationThickness:
                                            2, // Line height for better readability
                                      ),
                                    )),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "We recognize our responsibility to contribute positively to society."
                                  " Majazi Tech is dedicated to leveraging technology for social good."
                                  " We support initiatives that promote digital literacy, accessibility,"
                                  " and sustainability. Our mission extends beyond business success to making a meaningful impact on the communities we serve.",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors
                                            .white // Line height for better readability
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Padding(
                      padding: EdgeInsets.all(30),
                      child: Container(
                        width: 400,
                        height: MediaQuery.of(context).size.height / 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 4,
                            )),
                        child: Container(
                          color: Colors.black,
                          child: Container(
                            child: Column(
                              children: [
                                Text("Delivering Value",
                                    style: GoogleFonts.oswald(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        height: 1.5,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 2,
                                        // Line height for better readability
                                      ),
                                    )),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "Our mission is to deliver tangible value to our clients through innovative software solutions."
                                  " We measure our success by the success of our clients."
                                  " By providing software that improves efficiency, enhances user experience,"
                                  " and drives business growth, we aim to be a trusted partner in our clients' "
                                  "journey towards digital transformation.",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        height: 1.5,
                                        color: Colors
                                            .white // Line height for better readability
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.all(30),
                  child: Container(
                    width: 400,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: Column(
                      children: [
                        Text(
                          "Majazi Tech is not just a software engineering company;"
                          " we are a team of passionate technologists committed to making a difference."
                          " We envision a future where technology empowers everyone to achieve their fullest potential,"
                          " and we are dedicated to turning this vision into reality.",
                          style: GoogleFonts.oswald(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                height: 1.5,
                                color: Colors
                                    .white // Line height for better readability
                                ),
                          ),
                        )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              //todo: put location

              ///footer
              const SizedBox(
                height: 70,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  border: Border(
                    top: BorderSide(
                      color: Colors.greenAccent,
                      width: 5.0,
                    ),
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
      ),
    );
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
