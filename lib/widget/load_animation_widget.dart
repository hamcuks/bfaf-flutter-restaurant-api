import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class LoadAnimation extends StatelessWidget {
  const LoadAnimation({
    Key? key,
    required this.fileName,
    required this.text,
    required this.width,
  }) : super(key: key);

  final String fileName;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              child: Lottie.asset('assets/json/$fileName.json', width: width)),
          SizedBox(
            height: 22,
          ),
          Flexible(
            child: Text(
              '$text',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
