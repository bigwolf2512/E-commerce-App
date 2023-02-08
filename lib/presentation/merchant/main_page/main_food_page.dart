import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/controller/popular_product_controller.dart';
import '../../../share/constant/constant.dart';
import '../home_page/food_page_body.dart';
import '../order_page/order_page.dart';

class MerchantMainFoodPage extends StatefulWidget {
  const MerchantMainFoodPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MerchantMainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MerchantMainFoodPage> {
  List pages = [
    Container(
      child: FoodPageBody(),
    ),
    Container(
      child: OrderPage(),
    ),
  ];
  int isSelected = 0;
  void _onItemTapped(int index) {
    setState(
      () {
        isSelected = index;
        Get.find<PopularProductController>().getpopularproductList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(
          content: Text("Back again to exit."),
          backgroundColor: Colors.black,
        ),
        child: Container(
          child: pages[isSelected],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            activeIcon: Icon(Icons.archive_rounded),
            label: "Order",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart_rounded),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person_rounded),
            label: "Personal",
          ),
        ],
        currentIndex: isSelected,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        backgroundColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}