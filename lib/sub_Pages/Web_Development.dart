import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled_web/loading_States/Loading_bar.dart';
import '../api_connection/api_connection.dart';
import 'dart:convert';
class WebDevelopment extends StatefulWidget {
  const WebDevelopment({super.key});

  @override
  State<WebDevelopment> createState() => _WebDevelopmentState();
}

class _WebDevelopmentState extends State<WebDevelopment> {
  var formKey = GlobalKey<FormState>();
  late TextEditingController NameController;
  late TextEditingController EmailController;

  String StaticWebPackage ="Static website Package";
  String DynamicWebApp ="Dynamic Web Package";
  late String packageName;
  bool bottomContainerBeVisible = false;
  Widget _buildSingleListItem(String text) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.check, color: Colors.green),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
          TextButton(
              onPressed: () {},
              child: const Text(
                "Get",
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
    );
  }
  Widget _buildListItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  bool isValidName(String name) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');
    return nameRegExp.hasMatch(name);
  }

  bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    return emailRegExp.hasMatch(email);
  }

  bool isValidNumber(String number) {
    final RegExp numberRegExp = RegExp(r'^(?:0[1-8][0-9]{8})$');
    return numberRegExp.hasMatch(number);
  }

  sendingRequest(String package) async {
    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingApp();
      },
    );
    await Future.delayed(Duration(seconds: 3));
    // Validating
    String userName = NameController.text.toString();
    String userEmail = EmailController.text.toString();

    if (isValidName(userName) && isValidEmail(userEmail)) {
      try {
        var response = await http.post(
          Uri.parse(API.sendingPackageEnquiry),
          body: {
            'customer_name': userName.toUpperCase(),
            'Email': userEmail.toLowerCase(),
            'packageName': package.trim(),
          },
        );

        Navigator.of(context).pop(); // Dismiss the loading dialog

        if (response.statusCode == 200) {
          try {
            var getResponseBody = jsonDecode(response.body);
            print(getResponseBody);
            if (getResponseBody['success'] == true) {
              setState(() {
                NameController.clear();
                EmailController.clear();
              });
              _showAlertDialog(
                  context, "Request Sent", Icons.done, Colors.greenAccent);
            } else if (getResponseBody['requested'] == true) {
              setState(() {
                NameController.clear();
                EmailController.clear();
              });
              _showAlertDialog(context, "Service requested", Icons.crisis_alert,
                  Colors.orangeAccent);
            } else if (getResponseBody.containsKey('error')) {
              _showAlertDialog(
                  context, getResponseBody['error'], Icons.error, Colors.red);
            } else {
              _showAlertDialog(
                  context, "Error\n try again", Icons.error, Colors.red);
            }
          } catch (e) {
            print("JSON decode error: $e");
            _showAlertDialog(
                context, "Invalid server response", Icons.error, Colors.red);
          }
        } else {
          print("HTTP error: ${response.statusCode}");
          _showAlertDialog(
              context, "Error\n try again", Icons.error, Colors.red);
        }
      } catch (e) {
        print("Exception: $e");
        _showAlertDialog(context, "Message not sent", Icons.error, Colors.red);
      } finally {
        setState(() {
          NameController.clear();
          EmailController.clear();
        });
      }
    } else {
      Navigator.of(context)
          .pop(); // Dismiss the loading dialog for invalid input
      setState(() {
        NameController.clear();
        EmailController.clear();
      });
      _showAlertDialog(context, "Invalid input", Icons.error, Colors.red);
    }
  }

  void _showAlertDialog(
      BuildContext context, String text, IconData icon, Color iconColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                text,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Icon(
                icon,
                color: iconColor,
                size: 50,
              ),
            ],
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Color.fromRGBO(1, 77, 78, 1)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    NameController = TextEditingController();
    EmailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    NameController.dispose();
    EmailController.dispose();
    super.dispose();
  }
  void closeWidget() {
    setState(() {
      bottomContainerBeVisible = false;
      EmailController.clear();
      NameController.clear();
    });
  }
  void getServiceBtn() {
    setState(() {
      bottomContainerBeVisible = !bottomContainerBeVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: BackgroundContainer(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 400,
                              height: MediaQuery.of(context).size.height / 1.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  )),
                              child: Column(
                                children: [
                                  // Top half with background color and text
                                  Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * 0.3,
                                    decoration: const BoxDecoration(
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Website Package',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'Static Website Package',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Bottom half with list of items and button
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ListView(
                                              padding: const EdgeInsets.all(16.0),
                                              children: [
                                                _buildListItem(
                                                    "domain name(.co.za)  R 125 /yearly"),
                                                _buildListItem(
                                                    "Four Web Pages  R4185 /once off"),
                                                _buildListItem(
                                                    "Emails R 0/free service"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  packageName = StaticWebPackage.toString();
                                                  getServiceBtn();
                                                });
                                              },
                                              color: Colors.teal,
                                              textColor: Colors.white,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 32.0,
                                                vertical: 16.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                'Get Package',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 400,
                              height: MediaQuery.of(context).size.height / 1.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 2,
                                  )),
                              child: Column(
                                children: [
                                  // Top half with background color and text
                                  Container(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height * 0.3,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 184, 134, 11),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Web Gold Package',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'Dynamic Website Package',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Bottom half with list of items and button
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ListView(
                                              padding: const EdgeInsets.all(16.0),
                                              children: [
                                                _buildListItem(
                                                    "Domain name(.co.za) R125 /yearly"),
                                                _buildListItem(
                                                    "Emails R0 /free service"),
                                                _buildListItem(
                                                    "Cloud Services R3000/yearly"),
                                                _buildListItem(
                                                    "Four Web Pages R5560/ once off"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  packageName = DynamicWebApp.toString();
                                                  getServiceBtn();
                                                });
                                              },
                                              color:
                                                  Color.fromARGB(255, 184, 134, 11),
                                              textColor: Colors.white,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 32.0,
                                                vertical: 16.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                'Get Package',
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
        
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
          ),
        ),
        Visibility(
          visible: bottomContainerBeVisible,
          child: Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedSize(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 122),
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 2.4,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(1, 77, 78, 1),
                    border: Border(
                      top: BorderSide(
                        color: Colors.greenAccent, // Border color
                        width: 4.0, // Border width
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(21),
                        topRight: Radius.circular(21)),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () {
                                closeWidget();
                              },
                              child: Icon(Icons.clear),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: NameController,
                                keyboardType: TextInputType.text,
                                validator: (val) =>
                                val == "" ? "Your Name" : null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person),
                                  hintText: "Name",
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: EmailController,
                                keyboardType: TextInputType.text,
                                validator: (val) =>
                                val == "" ? "Your Email" : null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.phone),
                                  hintText: "customer@gmail.com",
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Material(
                          color: const Color.fromRGBO(29, 43, 83, 100),
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                // Validation succeeded, handle form submission
                                sendingRequest(packageName);
                              }
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 28,
                              ),
                              child: Text(
                                "request",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ],
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
