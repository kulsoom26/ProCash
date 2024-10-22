import 'package:get/get.dart';
import 'package:pro_cash_food/views/custom_widgets/custom_text_field.dart';
import 'package:pro_cash_food/views/screens/AdminScreens/AdminHome/controller/admin_home_controller.dart';
import 'package:pro_cash_food/views/screens/AdminScreens/AdminRequests/controller/admin_requests_controller.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/AddItems/controller/register_new_items_controller.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/AddMembers/controller/add_member_controller.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/EditHome/controller/edit_home_controller.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/LowStockAlert/SafetyStock/controller/safety_stock_controller.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/LowStockAlert/SafetyStockSettings/controller/safety_stock_settings_controller.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Stocks/controller/stock_controller.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/authentication/controller/auth_controller.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/createteam/controller/create_team_controller.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/onboarding/controller/onboarding_controller.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/teamprofile/controller/team_profile_controller.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/user%20profiling/controller/profile_controller.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/EditItems/controller/edit_items_controller.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/ItemDetails/controller/item_details_controller.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Items/controller/items_controller.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Transactions/controller/transaction_controller.dart';
import 'package:pro_cash_food/views/screens/NavBar/controller/custom_navbar_controller.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/controller/settings_screens_controller.dart';
import 'package:pro_cash_food/views/screens/TransactionScreens/TransactionFilters/controller/transaction_filter_controller.dart';
import 'package:pro_cash_food/views/screens/TransactionScreens/Transactions/controller/transaction_history_controller.dart';
import 'package:pro_cash_food/views/screens/TransferScreens/controller/transfer_screen_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut(() => OnBoardingController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => TextFieldController());
    Get.lazyPut(() => CreateTeamController());
    Get.lazyPut(() => TeamProfileController());
    Get.lazyPut(() => StockController());
    Get.lazyPut(() => SafetyStockController());
    Get.lazyPut(() => SafetyStockSettingsController());
    Get.lazyPut(() => AddMemberController());
    Get.lazyPut(() => RegisterNewItemController());
    Get.lazyPut(() => EditHomeController());
    Get.lazyPut(() => CustomNavBarController());
    Get.lazyPut(() => ItemsController());
    Get.lazyPut(() => EditItemsController());
    Get.lazyPut(() => ItemDetailsController());
    Get.lazyPut(() => TransactionsController());
    Get.lazyPut(()=>TransferScreenController());
    Get.lazyPut(() => TransactionHistoryController());
    Get.lazyPut(() => TransactionFilterController());
    Get.lazyPut(() => AdminHomeController());
    Get.lazyPut(() => AdminRequestController());
    Get.lazyPut(() => SettingsController());
  }
}
