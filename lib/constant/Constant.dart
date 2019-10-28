import 'package:finesse/model/addon.dart';
import 'package:finesse/model/cafe_info.dart';
import 'package:finesse/model/client_info.dart';
import 'package:finesse/model/login_info.dart';
import 'package:finesse/model/menu_category.dart';
import 'package:finesse/model/order_detail.dart';
import 'package:finesse/model/addon_order.dart';

String LOGIN_SCREEN = 'LOGIN_SCREEN';
String TABLEID_SCREEN = 'TABLEID_SCREEN';
String SPLASH_SCREEN = 'SPLASH_SCREEN';
String HOME_SCREEN = 'HOME_SCREEN';
String BILLING_SCREEN = 'BILLING_SCREEN';
String MENU_SCREEN = 'MAIN_SCREEN';
String ORDER_SCREEN = "ORDER_SCREEN";
String ON_YOUR_TABLE_SCREEN = "ON_TABLE_SCREEN";
String PAYMENT_SCREEN = "PAYMENT_SCREEN";
String FEEDBACK_SCREEN = 'FEEDBACK_SCREEN';
String THANK_YOU_SCREEN = 'THANK_YOU_SCREEN';

String SELECTED_OPTION = "No option selected";
String ADDITIONAL_COMMENT = "No comment";

String SELECTED_CUSTOM_OPTION = "No option selected";

String itemAddOnName = " ";
double itemAddOnPrice = 0;

String likeSuccessfulStatus = "like count increased successfully";

List<String> ORDER_STATUS = <String>[
  'Served !',
  'Ordered, yet to be placed in Kitchen',
  'Cooking right now for you',
];

String caffeID = currentCafe.caffeId;

String UPVOTED_HASHTAG = "#";
AddonOrder AddOn = new AddonOrder();
LoginInfo loginUser = new LoginInfo();
ClientInfo currentUser = new ClientInfo();
CafeInfo currentCafe = new CafeInfo();
FoodCategory currentCategory = new FoodCategory();
List<Order> currentOrderList = [];
List<AddonOrder> addOn = [];
int orderIdentifierNumber = 1;

String CURRENT_ORDER_IDENTIFIER = "";
String LAST_ORDER_IDENTIFIER = "";

bool ngoAmountStateChanged = false;

double totalPayable = 0.0;

bool isOrderInitiated = true;

//client_name, client_phone and tableidtimestamp will be saved in cache
