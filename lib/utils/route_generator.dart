import 'package:get/get.dart';
import 'package:pro_cash_food/utils/app_strings.dart';
import 'package:pro_cash_food/utils/screen_bindings.dart';
import 'package:pro_cash_food/views/screens/AdminScreens/AdminHome/admin_home_screen.dart';
import 'package:pro_cash_food/views/screens/AdminScreens/AdminRequests/admin_requests_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/AddItems/register_new_items_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/AddMembers/add_members_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/EditHome/edit_home_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Home/home_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/LowStockAlert/SafetyStock/safety_alert_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/LowStockAlert/SafetyStock/safety_stock_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/LowStockAlert/SafetyStockSettings/safety_stock_settings_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Stocks/adjust_stock_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Stocks/move_stock_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Stocks/stock_in_screen.dart';
import 'package:pro_cash_food/views/screens/HomeScreens/Stocks/stock_out_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/authentication/login_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/authentication/sign_up_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/authentication/start_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/createteam/create_team_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/onboarding/onboarding_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/agreement/agreement_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/selectattribute/select_attribute_screen.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/EditItems/edit_items_screen.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/ItemDetails/item_details_screen.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Items/items_screen.dart';
import 'package:pro_cash_food/views/screens/ItemsScreens/Transactions/transactions_screen.dart';
import 'package:pro_cash_food/views/screens/NavBar/custom_navbar.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/add_item.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/add_location.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/add_member_invite.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/add_new_role.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/add_supplier_customer.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/currency_screen.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/display_format.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/edit_supplier_customer.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/items.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/locations.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/manage_role.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/members.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/my_teams.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/settings_screen.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/supplier_customer_list.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/timezone_screen.dart';
import 'package:pro_cash_food/views/screens/Settings%20Screens/user_profiling.dart';
import 'package:pro_cash_food/views/screens/TransactionScreens/TransactionFilters/transaction_filters_screen.dart';
import 'package:pro_cash_food/views/screens/TransactionScreens/Transactions/transactions_history_screen.dart';
import 'package:pro_cash_food/views/screens/TransferScreens/transfer_screen.dart';
import 'package:pro_cash_food/views/screens/splash_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/selectmode/select_mode_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/teamprofile/team_profile_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/user%20profiling/profile_screen.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/user%20profiling/profile_screen1.dart';
import 'package:pro_cash_food/views/screens/InitiationScreens/user%20profiling/waiting_screen.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: kSplashScreenRoute,
          page: () => const SplashScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kOnBoardingRoute,
          page: () => const OnBoardingScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kStartRoute,
          page: () => const StartScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kLogInRoute,
          page: () =>  LoginScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSignUpRoute,
          page: () => SignUpScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kProfileRoute,
          page: () => const ProfileScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kProfile1Route,
          page: () => ProfileScreen1(),
          binding: ScreenBindings()),
      GetPage(
          name: kWatingRoute,
          page: () => const WaitingScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kCreateTeamRoute,
          page: () => const CreateTeamScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kTeamProfileRoute,
          page: () => const TeamProfileScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kSelectModeRoute,
          page: () => const SelectMode(),
          binding: ScreenBindings()),
      GetPage(
          name: kSelectAttributeRoute,
          page: () => const SelectAttribute(),
          binding: ScreenBindings()),
      GetPage(
          name: kAgreementRoute,
          page: () => const AgreementScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kHomeRoute,
          page: () => const HomeScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kStockOutRoute,
          page: () => const StockOutScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kStockInRoute,
          page: () => const StockInScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kMoveStockRoute,
          page: () => const MoveStockScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kAdjustStockRoute,
          page: () => const AdjustStockScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kSafetyStockRoute,
          page: () => const SafetyStockScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kSafetyAlertScreenRoute,
          page: () => const SafetyAlertScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kSafetyStockSettingsRoute,
          page: () => const SafetyStockSettingsScreen(),
          binding: ScreenBindings()),

      GetPage(
          name: kAddMembersRoute,
          page: () => const AddMembersScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kRegisterNewItemsRoute,
          page: () => const RegisterNewItemsScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kEditHomeRoute,
          page: () => const EditHomeScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kNavBarRoute,
          page: () => const CustomNavBar(),
          binding: ScreenBindings()),
      GetPage(
          name: kItemsRoute,
          page: () => ItemsScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kEditItemsRoute,
          page: () => const EditItemsScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kItemDetailsRoute,
          page: () => const ItemDetailsScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kTransactionsRoute,
          page: () => const TransactionsScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kTransferRoute,
          page: () => const TransferScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kTransactionHistoryRoute,
          page: () => const TransactionHistoryScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: kTransactionFilterRoute,
          page: () => const TransactionFilterScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kAdminHomeRoute,
          page: () => const AdminHomeScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kAdminRequestRoute,
          page: () => const AdminRequestScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsRoute,
          page: () => const SettingsScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsCurrencyRoute,
          page: () => const CurrencyScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsTimezoneRoute,
          page: () => const TimezoneScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsMembersRoute,
          page: () => const MembersScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsMemberInviteRoute,
          page: () => const MembersInviteScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsManageRolesRoute,
          page: () => const ManageRolesScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsAddNewRoleRoute,
          page: () => const AddNewRoleScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsMyTeamsRoute,
          page: () => const MyTeamsScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsDisplayFormatRoute,
          page: () => const DisplayFormatScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsItemsRoute,
          page: () => const SettingsItemsScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsAddItemsRoute,
          page: () => const AddItemScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsCustomerSupplierListRoute,
          page: () => const SupplierCustomerScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsCustomerSupplierEditRoute,
          page: () => const EditSupplierCustomerScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsCustomerSupplierAddRoute,
          page: () => const AddSupplierCustomerScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsLocationRoute,
          page: () => const LocationScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsLocationAddRoute,
          page: () => const AddLocationScreen(),
          binding: ScreenBindings()),
          GetPage(
          name: kSettingsUserProfilingRoute,
          page: () => const UserProfilingScreen(),
          binding: ScreenBindings()),
          
    ];
  }
}
