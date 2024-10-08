import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project/utils/routes.dart';
import 'package:my_project/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:convert';
import '../models/data.dart';
import '../widgets/Home_widgets/catalog_List.dart';
import '../widgets/Home_widgets/catalog_heders.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final String name = "Codepur";

  @override
  void initState() {
    super.initState();
    loadData();
  }
  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
    // print(ProductData);
  }

  @override
  Widget build(BuildContext context) {
    // final dummyList = List.generate(10, (index) => CatalogModel.items[0]);
    return Scaffold(
      backgroundColor: context.canvasColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyTheme.darkBluishColor,
          onPressed: ()=>
          Navigator.pushNamed(context, MyRoutes.cartRoute),
          // backgroundColor:Context.theme.buttonColor,
          child:Icon(CupertinoIcons.cart,color: Colors.white,)),

      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatalogHeader(),
              if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                CatalogList().py16().expand()
              else
                CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}




