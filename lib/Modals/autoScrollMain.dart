import 'dart:async';
import 'package:flutter/material.dart';
class Autoscrollmain extends StatefulWidget {
  Autoscrollmain({super.key});

  @override
  State<Autoscrollmain> createState() => _AutoscrollmainState();
}

class _AutoscrollmainState extends State<Autoscrollmain>
{
  late ScrollController _scrollController;
  Timer? _timer;
  int _currentIndex = 0;
  List<Widget> _funeralQuotesList = [];
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _funeralQuotesList = _buildFuneralQuotesList(context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }
  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(minutes: 5), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _funeralQuotesList.length;
        _scrollToIndex(_currentIndex);
      });
    });
  }

  void _scrollToIndex(int index) {
    final containerWidth = MediaQuery.of(context).size.width;
    final scrollOffset = index * containerWidth;
    _scrollController.animateTo(
      scrollOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

   List<Widget> _buildFuneralQuotesList(BuildContext context){
    return[
      funeralQoutesBox(
      "Funeral Insurance",() {},Colors.blue,"images/PPP.jpg",context),
    funeralQoutesBox(
      "Travel",
          () {},
      Colors.blue,
      "images/majaziProfile2.jpg",context
    ),
    funeralQoutesBox(
      "Event Essentials",
          (){},
      Colors.blue,
      "images/About101.jpg",context

    ),

  ];}
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.sizeOf(context).height /3,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        children: _funeralQuotesList,
      ),
    );
  }
}
Widget funeralQoutesBox(String textData, VoidCallback onTap, Color contColor, String image,BuildContext context) {
  return InkWell(
    onTap: onTap,
    // Callback for click event
    child: Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(.8),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      width:MediaQuery.sizeOf(context).width /2,

    ),
  );
}