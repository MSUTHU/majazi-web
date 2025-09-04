import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled_web/loading_States/Loading_bar.dart';
import '../api_connection/api_connection.dart';

class ItSupport extends StatefulWidget {
  const ItSupport({super.key});

  @override
  State<ItSupport> createState() => _ItSupportState();
}

class _ItSupportState extends State<ItSupport> {
  var formKey = GlobalKey<FormState>();
  late TextEditingController NameController;
  late TextEditingController EmailController;
  late String packageName;
  String VirtualsmallPackage = "Small Business Package: R 5,000 per month";
  String VirtualEnterpricePackage = "Enterprise Package: R 10,000 per month";
  String PhysicalSmallPackage =
      "Basic On-site Support: R 1,200 per hour(minimum 3 hours)";
  String PhysicalAdvPackage =
      "Advanced On-site Support: R 1,600 per hour (minimum 4 hours)";
  bool bottomContainerBeVisible = false;
  bool _isLoading = false;

  getServiceBtn() {
    setState(() {
      bottomContainerBeVisible = true;
    });
  }

  getServiceSingleBtn(String texting) {
    setState(() {
      bottomContainerBeVisible = true;
      packageName = texting.toString();
    });
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

  void closeWidget() {
    setState(() {
      bottomContainerBeVisible = false;
      EmailController.clear();
      NameController.clear();
    });
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

  // validate the inputs
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

  Widget _buildSingleListItem(String text) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
          border: Border.all(
            color: Colors.grey,
            width: 2,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.check, color: Colors.greenAccent),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  getServiceSingleBtn(text);
                });
              },
              child: const Text(
                "Get",
                style: TextStyle(
                  fontSize: 13,
                ),
              ))
        ],
      ),
    );
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
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Virtual IT Support Package',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'Small Business Package: R 5,000 per month',
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              children: [
                                                _buildListItem(
                                                    "Remote Desktop Support (RDS)"),
                                                _buildListItem(
                                                    "Software Updates and Patch Management"),
                                                _buildListItem(
                                                    "Email and Collaboration Tool Support"),
                                                _buildListItem(
                                                    "Data Backup and Recovery"),
                                                _buildListItem(
                                                    "Static Website"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  packageName =
                                                      VirtualsmallPackage
                                                          .toString();
                                                  getServiceBtn();
                                                });
                                                // Handle button press
                                              },
                                              color: Colors.blue,
                                              textColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 32.0,
                                                vertical: 16.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                'Get Service',
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
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 184, 134, 11),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Virtual IT Support Package',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'Enterprise Package: R 10,000 per month',
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              children: [
                                                _buildListItem(
                                                    "Remote Desktop Support (RDS)"),
                                                _buildListItem(
                                                    "Cloud Services Management"),
                                                _buildListItem(
                                                    "Cybersecurity and Threat Management"),
                                                _buildListItem(
                                                    "Network Monitoring and Management"),
                                                _buildListItem(
                                                    "Software Updates and Patch Management"),
                                                _buildListItem(
                                                    "Email and Collaboration Tool Support"),
                                                _buildListItem(
                                                    "Virtual Private Network (VPN) Setup"),
                                                _buildListItem(
                                                    "Data Backup and Recovery"),
                                                _buildListItem(
                                                    "IT Consulting and Advisory"),
                                                _buildListItem(
                                                    "Help Desk Support"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  packageName =
                                                      VirtualEnterpricePackage
                                                          .toString();
                                                  getServiceBtn();
                                                });
                                              },
                                              color: Colors.blue,
                                              textColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 32.0,
                                                vertical: 16.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                'Get Service',
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
                    const SizedBox(
                      height: 10,
                    ),
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
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    decoration: const BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Physical IT Support Package',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'Basic On-site Support: R 1,200 per hour (minimum 3 hours)',
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              children: [
                                                _buildListItem(
                                                    "Hardware Installation and Repair"),
                                                _buildListItem(
                                                    "Network Cabling and Infrastructure Setup"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  packageName =
                                                      PhysicalSmallPackage
                                                          .toString();
                                                  getServiceBtn();
                                                });
                                              },
                                              color: Colors.redAccent,
                                              textColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 32.0,
                                                vertical: 16.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                'Get Service',
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
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    decoration: const BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Physical IT Support Package',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'Advanced On-site Support: R 1,600 per hour (minimum 4 hours)',
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              children: [
                                                _buildListItem(
                                                    "Cybersecurity Audits and Risk Assessment"),
                                                _buildListItem(
                                                    "IT Infrastructure Upgrades and Migration"),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  packageName =
                                                      PhysicalAdvPackage
                                                          .toString();
                                                  getServiceBtn();
                                                });
                                              },
                                              color: Colors.blueGrey,
                                              textColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 32.0,
                                                vertical: 16.0,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                'Get Service',
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        "Virtual IT Support Single Service",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ///singles
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.greenAccent,
                                    width: 3,
                                  )),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView(
                                          padding: const EdgeInsets.all(16.0),
                                          children: [
                                            _buildSingleListItem(
                                                "Remote Desktop Support(RDS) R40 /per session"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Cloud Services Management R50 /per session"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Cybersecurity and Threat Management  R67 /per session"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Network Monitoring and Management  R60 /per session"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Software Updates and Patch R34 /per session"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Email and Collaboration Tool Support R27 /per session"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Virtual Private Network (VPN) Setup R40 /per session"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Data Backup and Recovery R50 /per session"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "IT Consulting and Advisory  R84/per session"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Help Desk Support R50 /per session")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        "Physical IT Support Single Service",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                    ),

                    ///singles
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.greenAccent,
                                    width: 3,
                                  )),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView(
                                          padding: const EdgeInsets.all(16.0),
                                          children: [
                                            _buildSingleListItem(
                                                "On-site Hardware Installation and Repair R400 /per hour"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Network Cabling and Infrastructure Setup R450 /per hour"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Device Installation and Configuration R350 /per hour"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "IT Asset Disposal and Recycling R300 /per hour"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Cybersecurity Audits and Risk Assessment R600 / per hour"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "IT Infrastructure Upgrades and Migration R500 / per hour"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Wireless Network Setup and Optimization R400 / per hour"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Printer and Peripheral Support R300 / per hour"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "Smart Home Automation Setup R350 / per hour"),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            _buildSingleListItem(
                                                "IT Training and Workspace R450 /per hour")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
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
                                    backgroundImage: AssetImage(
                                        'images/company_profile3.jpg'),
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
                                      child:
                                          const Icon(Icons.facebook, size: 24),
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
          visible: bottomContainerBeVisible == true,
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
