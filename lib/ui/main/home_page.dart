import 'package:any_image_view/any_image_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_empty/extensions/int_extension.dart';
import 'package:flutter_empty/extensions/kotlin_func.dart';
import 'package:flutter_empty/extensions/obj_extension.dart';
import 'package:flutter_empty/extensions/string_extension.dart';
import 'package:flutter_empty/widgets/ImageView.dart';

import '../../network/net.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(color: Colors.red,width: 370.pt,height: 20,margin: EdgeInsets.only(bottom: 10),),
            Imageview(
              imagePath: "images/demo.svg",
              height: 100.pt,
              width: 100.pt,
              onTap: ()async{
                "No touch me".toast;
                var data = await Net.api.demo(0, {"data":"dd"});
                print(data);

              },
            ),
          ],
        ),
      ),
    );
  }
}
