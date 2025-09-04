import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../api_connection/api_connection.dart';
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
{
  var formKey = GlobalKey<FormState>();
  late TextEditingController PhoneNumberController;
  late TextEditingController NameController;
  late TextEditingController MessageController;
  late TextEditingController EmailController;

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
  @override
  void initState() {
    PhoneNumberController = TextEditingController();
    NameController = TextEditingController();
    MessageController = TextEditingController();
    EmailController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    PhoneNumberController.dispose();
    NameController.dispose();
    MessageController.dispose();
    EmailController.dispose();
    super.dispose();
  }
  // validate the inputs
  
  void ValidatingUserInput(){
  String UserName = NameController.text;
  String UserPhone = PhoneNumberController.text;
  String UserEmail = EmailController.text;
  String Usertext = MessageController.text;

  if(isValidName(UserName) && isValidNumber(UserPhone) && isValidEmail(UserEmail) && Usertext.isNotEmpty)
  {
    saveUserInput(context);
  }else{
    _showAlertDialog(context, "Correct Your inputs",Icons.dangerous,Colors.redAccent);
    return;
  }
  }
  Future<void> saveUserInput(BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(API.sendingEnquiry),
        body: {
          'phone': PhoneNumberController.text.toString(),
          'customer_name': NameController.text.toString(),
          'email': EmailController.text.toString(),
          'message': MessageController.text.toString(),
        },
      );

      if (response.statusCode == 200) {
        var getResponseBody = jsonDecode(response.body);
        if (getResponseBody['success'] == true) {
          setState(() {
            PhoneNumberController.clear();
            NameController.clear();
            EmailController.clear();
            MessageController.clear();
          });
          _showAlertDialog(context, "Message Sent", Icons.done, Colors.greenAccent);
          return;
        }if (getResponseBody['requested'] == true) {
          setState(() {
            PhoneNumberController.clear();
            NameController.clear();
            EmailController.clear();
            MessageController.clear();
          });
          _showAlertDialog(context, "We have your enquiry today\nCheck your emails or wait for our call", Icons.crisis_alert, Colors.orange);
          return;
        } else {
          setState(() {
            PhoneNumberController.clear();
            NameController.clear();
            EmailController.clear();
            MessageController.clear();
          });
          _showAlertDialog(context, "Error, try again", Icons.dangerous, Colors.redAccent);
        }
      } else {

        _showAlertDialog(context, "Server error: ${response.statusCode}", Icons.error, Colors.red);
      }
    } catch (e) {
      print("Exception: $e");
      _showAlertDialog(context, "An error occurred", Icons.error, Colors.red);
    }
  }
  void _showAlertDialog(BuildContext context, String text,IconData icon, Color iconColor) {
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
                  style: TextStyle(color:  Color.fromRGBO(1, 77, 78,1)),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BackgroundContainer(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Contact Us",
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 60,
                      height: 2.1,
                      color: Colors.greenAccent, // Line height for better readability
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.greenAccent,
                      width: 3,
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        "Send An Enquiry",
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            height: 2.1,
                            color: Colors.white70, // Line height for better readability
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.cyan,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const Text(
                                  "Phone Number",
                                  style: TextStyle(
                                    fontSize: 18,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.cyan,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: NameController,
                                    keyboardType: TextInputType.text,
                                    validator: (val) => val == "" ? "Number" : null,
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
                                    controller: PhoneNumberController,
                                    keyboardType: TextInputType.phone,
                                    validator: (val) => val == "" ? "Number" : null,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.phone),
                                      hintText: "077...",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30,),
                            Container(
                              width: MediaQuery.sizeOf(context).width /2,
                              child: Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.cyan,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextFormField(
                                        controller: EmailController,
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (val) => val == "" ? "EmailAddress" : null,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          prefixIcon: Icon(Icons.person),
                                          hintText: "email@user.com",
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30,),
                            Container(
                              width: MediaQuery.sizeOf(context).width /2,
                              child: Center(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Message",
                                      style: TextStyle(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.cyan,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    TextFormField(
                                      controller: MessageController,
                                      keyboardType: TextInputType.text,
                                      validator: (val) => val == "" ? "Message" : null,
                                      maxLines: null,
                                      minLines: 5,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.edit),
                                        hintText: "Your Enquiry",
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 60,),
                            Material(
                              color: const Color.fromRGBO(29, 43, 83, 100),
                              borderRadius: BorderRadius.circular(30),
                              child: InkWell(
                                onTap: ()
                                {
                                  if (formKey.currentState!.validate())
                                  {
                                    // Validation succeeded, handle form submission
                                    ValidatingUserInput();
                                  }

                                },
                                borderRadius: BorderRadius.circular(30),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 28,
                                  ),
                                  child: Text(
                                    "Submit",
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
                    ],
                  ),
                ),
                ///footer
                const SizedBox(height: 70,),
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
                        Color.fromRGBO(1, 77, 78,1),
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
                          const SizedBox(height: 50,),
                          Column(
                            children: const [
                              CircleAvatar(
                                backgroundImage: AssetImage('images/company_profile3.jpg'),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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

