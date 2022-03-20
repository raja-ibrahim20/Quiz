import 'package:flutter/material.dart';

class UpperBar extends StatelessWidget {
  // const UpperBar({ Key? key }) : super(key: key);
  final int index;
  final double size;
  UpperBar(this.index, this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Scaffold.of(context).appBarMaxHeight,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
            height: AppBar().preferredSize.height,
            width: AppBar().preferredSize.width,
            color: Colors.blue,
          ),
          Container(
            height: AppBar().preferredSize.height,
            width: (MediaQuery.of(context).size.width / 20) * index,
            color: Colors.black54,
          )
        ],
      ),
    );
  }
}
