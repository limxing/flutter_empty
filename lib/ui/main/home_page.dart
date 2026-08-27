import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_empty/extensions/int_extension.dart';
import 'package:flutter_empty/widgets/ImageView.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.red,
        middle: Text(
          "Home",
          style: TextStyle(color: Colors.black, fontSize: 18.pt),
        ),
      ),
      child: Center(
        child: Imageview(
          imagePath: "images/demo.svg",
          height: 100.pt,
          width: 100.pt,
        ),
      ),
    );
  }
}
