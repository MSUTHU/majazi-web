import 'package:flutter/material.dart';
import 'package:untitled_web/sub_Pages/IT_Support.dart';
import 'package:untitled_web/sub_Pages/Mobile_Desktop_dev.dart';
import 'package:untitled_web/sub_Pages/Web_Development.dart';
class ServicesPage extends StatefulWidget {
   int intitializer;
   ServicesPage({super.key, required this.intitializer});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage>
{
  List<String> topNavigation = [
    'IT Support',
    'Web Development',
    'Mobile/ Desktop App'
  ];

  void updateSelectedoption(int newData) {
    setState(() {
      
    widget.intitializer = newData;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BackgroundContainer(
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topNavigation.length,
                itemBuilder: ( context, int index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          updateSelectedoption(index);
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            topNavigation[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: widget.intitializer == index ? FontWeight.bold :FontWeight.w300,
                              color: widget.intitializer == index ? Colors.white : Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                ),
                  if (widget.intitializer == 0)
                    Container(
                      height: MediaQuery.of(context).size.height - 50,
                      child: ItSupport(),
                    ),
                  if (widget.intitializer == 1)
                    Container(
                      height: MediaQuery.of(context).size.height - 50,
                      child: WebDevelopment(),
                    ),
                  if (widget.intitializer == 2)
                    Container(
                      height: MediaQuery.of(context).size.height - 50,
                      child: MobileDesktopDev(),
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