import 'package:flutter/material.dart';

class TopSplitLine extends StatelessWidget {
  final double topPadding;
  final int titleFlex;
  late int lineFlex;
  final String mainTitle;
  final String crossTitle;

  TopSplitLine(
      {super.key,
      required this.topPadding,
      required this.titleFlex,
      required this.mainTitle,
      this.lineFlex = 0,
      this.crossTitle = ''});

  @override
  Widget build(BuildContext context) {
    if (lineFlex == 0) lineFlex = titleFlex;
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            color: Colors.grey,
            height: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: lineFlex,
                  child: Container(
                    color: Colors.grey,
                    height: 1.5,
                  )),
              Expanded(
                flex: lineFlex,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mainTitle,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      crossTitle,
                      style: const TextStyle(fontSize: 28, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: lineFlex,
                child: Container(color: Colors.grey, height: 1.5),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            color: Colors.grey,
            height: 1.5,
          ),
        ],
      )
    );
  }
}
