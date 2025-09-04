import 'package:flutter/material.dart';
import 'package:untitled_web/Modals/responsiveModal.dart';

class Animatedoffers extends StatefulWidget {
  final IconData iconType;
  final String serviceType;
  final Widget routePage;
  Animatedoffers(
      {super.key,
      required this.iconType,
      required this.serviceType,
      required this.routePage});

  @override
  State<Animatedoffers> createState() => _AnimatedoffersState();
}

class _AnimatedoffersState extends State<Animatedoffers>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true); // Repeat the animation loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final value = _controller.value;
          return Transform.translate(
            offset: Offset(0, 2 * value),
            child: Container(
              height: Responsivemodal.isDesktop(context)
                  ? MediaQuery.sizeOf(context).height / 2.5
                  : Responsivemodal.isMobile(context)
                      ? MediaQuery.sizeOf(context).height / 4
                      : 200,
              width: Responsivemodal.isDesktop(context)
                  ? MediaQuery.sizeOf(context).width / 4
                  : Responsivemodal.isMobile(context)
                      ? MediaQuery.sizeOf(context).width / 3
                      : 200,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(colors: [
                  Colors.greenAccent,
                  Colors.black,
                ]),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.greenAccent,
                    offset: Offset(-2, 0),
                    blurRadius: 20,
                  ),
                  BoxShadow(
                    color: Colors.greenAccent,
                    offset: Offset(2, 0),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      height: Responsivemodal.isLargeMobile(context)
                          ? MediaQuery.sizeOf(context).width * 0.2
                          : Responsivemodal.isTablet(context)
                              ? MediaQuery.sizeOf(context).width * 0.14
                              : 200,
                      width: Responsivemodal.isLargeMobile(context)
                          ? MediaQuery.sizeOf(context).width * 0.2
                          : Responsivemodal.isTablet(context)
                              ? MediaQuery.sizeOf(context).width * 0.14
                              : 200,
                      child: Icon(
                        widget.iconType,
                        size: 40,
                      ),
                    ),
                  ),
                  //header
                  Text(
                    "${widget.serviceType}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Material(
                    color: const Color.fromRGBO(29, 43, 83, 100),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => widget.routePage),
                        );
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 28,
                        ),
                        child: Text(
                          "View",
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
          );
        });
  }
}
