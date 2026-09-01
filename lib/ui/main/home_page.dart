import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_empty/extensions/int_extension.dart';
import 'package:flutter_empty/extensions/string_extension.dart';
import 'package:flutter_empty/ui/main/home_view_model.dart';
import 'package:flutter_empty/widgets/ImageView.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../network/net.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomeViewModel _homeViewModel = HomeViewModel();
  dynamic _imagePath = "images/demo.svg";

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext context) => _homeViewModel,
      builder: (context, child) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.white,
          middle: Text(
            "Home",
            style: TextStyle(color: Colors.black, fontSize: 18.pt),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(color: Colors.green, width: 370.pt, height: 20, margin: EdgeInsets.only(bottom: 10)),
            Imageview(
              imagePath: _imagePath,
              height: 100.pt,
              width: 100.pt,
              onTap: () async {
                var data = await Net.api.demo(0, {"data": "dd"});
                data.toString().toast;
              },
            ),
            Observer(
              builder: (context) => Text(
                "Num:${_homeViewModel.num}",
                style: TextStyle(fontSize: 20.pt, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton.filled(onPressed: _homeViewModel.numPlus, child: Text("Click")),
                TextButton(onPressed: () async {
                  final file = await ImagePicker().pickImage(source: ImageSource.gallery);
                  setState(() {
                    _imagePath = file;
                  });
                }, child: Text("Image")),
                TextButton(onPressed: ()async{
                  final file = await ImagePicker().pickImage(source: ImageSource.camera);
                  setState(() {
                    _imagePath = file;
                  });
                }, child: Text("Camera")),
              ],
            ),
            Expanded(
              child: Observer(
                builder: (context) => ListView(
                  children: _homeViewModel.demoList
                      .map(
                        (demo) => Container(
                          height: 40.pt,
                          alignment: Alignment.center,
                          child: Text(
                            demo.name,
                            style: TextStyle(color: Colors.black, fontSize: 15.pt),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            CupertinoTabBar(
              backgroundColor: Colors.white,
              height: 60.pt,
              border: null,
              currentIndex: 1,
              items: [
                BottomNavigationBarItem(
                  icon: Imageview(imagePath:"images/demo.svg", width: 30.pt, height: 30.pt),
                  label: "首页"
                ),
                BottomNavigationBarItem(
                  icon: Imageview(imagePath: "images/demo.svg", width: 30.pt, height: 30.pt),
                  label: "我的"
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
