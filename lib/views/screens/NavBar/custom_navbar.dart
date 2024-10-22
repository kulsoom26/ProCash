import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pro_cash_food/utils/app_colors.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Home/home_screen.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Items/items_screen.dart';
import 'package:pro_cash_food/views/screens/NavBar/controller/custom_navbar_controller.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/settings_screen.dart';
import 'package:pro_cash_food/views/screens/TransactionScreens/Transactions/transactions_history_screen.dart';
import 'package:pro_cash_food/views/screens/TransferScreens/transfer_screen.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomNavBarController controller = Get.put(CustomNavBarController());

    List<Widget> screens = [
      const HomeScreen(),
      const ItemsScreen(),
      const TransferScreen(),
      const TransactionHistoryScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            items: [
              _buildNavBarItem(
                index: 0,
                asset: 'assets/icons/home.svg',
                label: 'Home',
              ),
              _buildNavBarItem(
                index: 1,
                asset: 'assets/icons/items.svg',
                label: 'Items',
              ),
              _buildNavBarItem(
                index: 2,
                asset: 'assets/icons/transfer.svg',
                label: 'Transfer',
              ),
              _buildNavBarItem(
                index: 3,
                asset: 'assets/icons/history.svg',
                label: 'History',
              ),
              _buildNavBarItem(
                index: 4,
                asset: 'assets/icons/settings.svg',
                label: 'Settings',
              ),
            ],
            onTap: controller.changeIndex,
            selectedLabelStyle: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w400,
            ),
            unselectedLabelStyle: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w400,
            ),
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kDarkGreyButtonColor,
          )),
    );
  }

  BottomNavigationBarItem _buildNavBarItem({
    required int index,
    required String asset,
    required String label,
  }) {
    final CustomNavBarController controller =
        Get.find<CustomNavBarController>();

    return BottomNavigationBarItem(
      icon: Align(
        alignment: Alignment.center,
        child: Obx(() => SvgPicture.asset(
              asset,
              color: controller.currentIndex.value == index
                  ? kPrimaryColor
                  : kDarkGreyButtonColor,
            )),
      ),
      label: label,
    );
  }
}
