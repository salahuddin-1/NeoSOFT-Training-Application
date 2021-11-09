import 'package:flutter/material.dart';
import 'package:neosoft_training_application/src/constants/images.dart';
import 'package:photo_view/photo_view.dart';

class TestingZoomImage extends StatefulWidget {
  const TestingZoomImage({Key? key}) : super(key: key);

  @override
  _TestingZoomImageState createState() => _TestingZoomImageState();
}

class _TestingZoomImageState extends State<TestingZoomImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          color: Colors.yellow,
          child: ClipRRect(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 200,
                maxWidth: 200,
              ),
              child: PhotoView(
                initialScale: 0.7,
                imageProvider: NetworkImage(tableImages[0]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:neosoft_training_application/src/constants/images.dart';
// import 'package:photo_view/photo_view.dart';

// class TestingZoomImage extends StatefulWidget {
//   const TestingZoomImage({Key? key}) : super(key: key);

//   @override
//   _TestingZoomImageState createState() => _TestingZoomImageState();
// }

// class _TestingZoomImageState extends State<TestingZoomImage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: 200,
//           width: 200,
//           color: Colors.yellow,
//           child: Stack(
//             children: [
//               Container(
//                 height: 200,
//                 width: 200,
//                 color: Colors.yellow,
//               ),
//               ClipRRect(
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     maxHeight: 200,
//                     maxWidth: 200,
//                   ),
//                   child: PhotoView(
//                     imageProvider: NetworkImage(tableImages[0]),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
