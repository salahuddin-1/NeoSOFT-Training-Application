import 'dart:async';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<Widget> children;
  final Color indicatorActiveColor;
  final Color indicatorInActiveColor;
  final Duration? pageDelayed;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const Carousel({
    Key? key,
    required this.children,
    this.indicatorActiveColor = Colors.white,
    this.indicatorInActiveColor = Colors.black,
    this.pageDelayed = const Duration(seconds: 3),
    this.animationCurve = Curves.easeIn,
    this.animationDuration = const Duration(seconds: 1),
  }) : super(key: key);
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late final PageController _pageController;
  late final _CarouselBLOC _carouselBLOC;
  late final _CarouselLogic _carouselLogic;
  @override
  void initState() {
    _pageController = new PageController();
    _carouselBLOC = new _CarouselBLOC();
    _carouselLogic = new _CarouselLogic(
      pageCntrl: _pageController,
      animationCurve: widget.animationCurve,
      animationDuration: widget.animationDuration,
      pageDelayed: widget.pageDelayed,
    );
    _carouselLogic.startCarousel();
    super.initState();
  }

  @override
  void dispose() {
    _carouselBLOC.dispose();
    _pageController.dispose();
    print('carousel disposed');
    super.dispose();
  }

  late bool isLandScape;
  @override
  Widget build(BuildContext context) {
    DevicePixels(context).setParameters();
    isLandScape = DevicePixels.orientation == Orientation.landscape;

    return Container(
      color: Colors.black,
      height: isLandScape ? DevicePixels.width * 45 : DevicePixels.height * 35,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (pageNo) {
              _carouselBLOC.updateIndicator(pageNo);
            },
            children: widget.children,
          ),
          _indicator(),
        ],
      ),
    );
  }

  StreamBuilder<int> _indicator() {
    return StreamBuilder<int>(
      initialData: 0,
      stream: _carouselBLOC.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Positioned(
            left: DevicePixels.width * 40,
            right: DevicePixels.width * 40,
            top: isLandScape
                ? DevicePixels.width * 40
                : DevicePixels.height * 31.5,
            child: Row(
              children: [
                for (int i = 0; i < 4; i++)
                  snapshot.data == i
                      ? _rounded(color: widget.indicatorActiveColor)
                      : _rounded(color: widget.indicatorInActiveColor),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  AnimatedContainer _rounded({required Color color}) {
    var width = DevicePixels.width * 2.5;
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      margin: EdgeInsets.only(left: width),
      height: width,
      width: width,
    );
  }
}

class _CarouselBLOC {
  final _indicatorCntrl = new StreamController<int>.broadcast();

  Stream<int> get stream => _indicatorCntrl.stream;

  updateIndicator(int pageNo) {
    _indicatorCntrl.sink.add(pageNo);
  }

  void dispose() {
    _indicatorCntrl.close();
  }
}

class _CarouselLogic {
  late PageController pageCntrl;
  late Duration? pageDelayed;
  late Duration? animationDuration;
  late Curve? animationCurve;

  _CarouselLogic({
    required this.pageCntrl,
    this.pageDelayed,
    this.animationCurve,
    this.animationDuration,
  });

  void startCarousel() async {
    int i = 1;
    while (true) {
      await Future.delayed(
        pageDelayed!,
      ).then(
        (value) {
          if (pageCntrl.hasClients) {
            pageCntrl.animateToPage(
              i,
              duration: animationDuration!,
              curve: animationCurve!,
            );

            if (i == 3)
              i = 0;
            else
              i++;
          }
        },
      );
      // if (stopLoop) {
      //   print('Braked');
      //   break;
      // }
    }
  }
}

class DevicePixels {
  late BuildContext context;
  static late double _height;
  static late double _width;
  static late Orientation _orientation;

  DevicePixels(BuildContext context) {
    this.context = context;
    setParameters();
  }

  setParameters() {
    _height = MediaQuery.of(context).size.height / 100;
    _height = double.parse(_height.toStringAsPrecision(3));

    _width = MediaQuery.of(context).size.width / 100;
    _width = double.parse(_width.toStringAsPrecision(3));

    _orientation = MediaQuery.of(context).orientation;
  }

  static double get height => _height;
  static double get width => _width;
  static Orientation get orientation => _orientation;
}
