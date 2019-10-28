import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/cafe_info.dart';
import 'package:finesse/model/login_info.dart';
import 'package:finesse/model/client_info.dart';
import 'package:finesse/model/client_info_response.dart';
import 'package:finesse/model/login_info_response.dart';
import 'package:finesse/model/comment.dart';
import 'package:finesse/model/complaint_request.dart';
import 'package:finesse/model/feedback_request.dart';
import 'package:finesse/model/food_item.dart';
import 'package:finesse/model/food_menu_req.dart';
import 'package:finesse/model/increase_like_request.dart';
import 'package:finesse/model/make_order_model.dart';
import 'package:finesse/model/menu_category.dart';
import 'package:finesse/model/order_detail.dart';
import 'package:finesse/model/payment_request.dart';
import 'package:finesse/model/status.dart';
import 'package:finesse/model/top_hash_tag_req.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/client_info.dart';

class FinesseApi {
  // static const String CONSUMER_KEY =
  //     "";
  // static const String CONSUMER_SECRET =
  //     "";
  // static const String SECRET =
  //     "?consumer_key=" + CONSUMER_KEY + "&consumer_secret=" + CONSUMER_SECRET;

  static const String BASE_URL = 'http://18.219.58.75:3000/';

  static const String BASE_URL_LOGIN = "api/getUser";

  static const String BASE_URL_REGISTER = "api/insertClientInfo";

  static const String BASE_URL_CAFE_INFO_BY_ID = "api/getcafedetails";

  static const String BASE_URL_CATEGORY = "api/getfoodcategory";

  static const String BASE_URL_FOOD_MENU_BY_CATEGORY = "api/getfoodmenu";

  static const String BASE_URL_TOP_HASH_TAG = "api/topFoodHashtag";

  static const String BASE_URL_MAKE_ORDER = "api/makeOrder";

  static const String BASE_URL_GET_CLIENT_ORDER = "api/getOrderclient";

  static const String BASE_URL_MAKE_PAYMENT = "api/makePayment";

  static const String BASE_URL_MAKE_COMPLAINT = "api/makeComplaint";

  static const String BASE_URL_COMMENT_BY_HASHTAG = "api/getcomment";

  static const String BASE_URL_INCREASE_LIKE = "api/increaseLike";

  static const String BASE_URL_MAKE_COMMENT = "api/makeComment";

  static const String BASE_URL_MAKE_FEEDBACK = "api/makeFeedback";

  static String nowDate = new DateFormat('dd/MM/yyyy')
      .format(DateTime.parse(DateTime.now().toString()));

  // "v2/products?filter[category]=";

  // final _httpClient = new HttpClient();

  FinesseApi();

  Future<LoginInfoResponse> loginRequest(LoginInfo user) async {
    String url = BASE_URL + BASE_URL_LOGIN;
    ////debugPrint("user reg request" + user.toJson().toString());
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(user.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);

    LoginInfoResponse regReply =
        LoginInfoResponse.fromJson(jsonObj); //ClientInfo.fromJSON(jsonObj);

    return regReply;
  }

  Future<ClientInfoResponse> registerRequest(ClientInfo user) async {
    String url = BASE_URL + BASE_URL_REGISTER;
    ////debugPrint("user reg request" + user.toJson().toString());
    var response = await http
        .post(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            // HttpHeaders.authorizationHeader : ''
          },
          body: json.encode(user.toJson()),
        )
        .timeout(new Duration(seconds: 5))
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);

    ClientInfoResponse regReply =
        ClientInfoResponse.fromJson(jsonObj); //ClientInfo.fromJSON(jsonObj);

    return regReply;
  }

// get cafe informations

  Future<CafeInfo> getCafeInfoById() async {
    String url = BASE_URL + BASE_URL_CAFE_INFO_BY_ID;
    ////debugPrint("requesting getCafeInfoById--- \n" + url);
    CafeInfo cafeInfo = currentCafe;
//    cafeInfo.caffeId = cafeId;
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(cafeInfo.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);

    CafeInfo cafeInfoReply = CafeInfo.fromJSON(jsonObj);

    return cafeInfoReply;
  }

  Future<List<FoodCategory>> getfoodcategory() async {
    CafeInfo cafeInfo = currentCafe;
    // offset = 160;
    String url = BASE_URL + BASE_URL_CATEGORY;
    ////debugPrint("requesting getfoodcategory --- \n" + url);
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(cafeInfo.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    // return json.decode(response.body); x-wp-total: 163
    // var totalPage = response.headers['x-wp-totalpages'].toString();

    // ////debugPrint("total pages "+ totalPage.toString());

    var jsonObj = json.decode(response.body);

    List<FoodCategory> categories = [];

    try {
      jsonObj.forEach((newJson) {
        FoodCategory category = FoodCategory.fromJSON(newJson);
        categories.add(category);
      });
    } catch (e) {
      ////debugPrint(e.toString());
    }

    return categories;
  }

// get orders from api
  Future<List<Order>> getCleintOrder() async {
    MakeOrder clientOrderRequest = MakeOrder(); //currentCafe;
    clientOrderRequest.caffeID = currentCafe.caffeId;
    clientOrderRequest.tableidtimestamp = currentUser.tableIdTimestamp;
    // offset = 160;
    String url = BASE_URL + BASE_URL_GET_CLIENT_ORDER;
    debugPrint("requesting getCleintOrder --- \n" +
        url +
        "\n " +
        clientOrderRequest.toClietnOrderJson().toString());
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(clientOrderRequest.toClietnOrderJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);
    ////debugPrint(jsonObj.toString());
    List<Order> orders = [];

    try {
      jsonObj.forEach((newJson) {
        List<Order> orderList = (newJson["orders"] as List)
            .map((neworderJson) => Order.fromJSON(neworderJson))
            .toList()
            .cast<Order>();
        orders.addAll(orderList);
      });
    } catch (e) {
      ////debugPrint(e.toString());
    }

    // debugPrint("total client orders  " + orders.length.toString());

    return orders;
  }

// make order

  Future<MakeOrder> makeOrderRequest() async {
    String url = BASE_URL + BASE_URL_MAKE_ORDER;

    List<Order> current_order_list = [];

    currentOrderList.forEach((order) {
      if (order.order_identifier == CURRENT_ORDER_IDENTIFIER)
        current_order_list.add(order);
    });

    MakeOrder placeOrderRequest = MakeOrder(); //currentCafe;
    placeOrderRequest.caffeID = currentCafe.caffeId;
    placeOrderRequest.tableidtimestamp = currentUser.tableIdTimestamp;
    placeOrderRequest.tableid = currentUser.tableId;
    placeOrderRequest.items = current_order_list; //currentOrderList;
    debugPrint("makeOrderRequest sent json ---------- " +
        json.encode(placeOrderRequest.toJson()));
    // return placeOrderRequest;
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(placeOrderRequest.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);

    MakeOrder placeOrderReply = MakeOrder.fromJSON(jsonObj);

    return placeOrderReply;
  }

  // make payment

  Future<Payment> makePayment(Payment paymentReq) async {
    String url = BASE_URL + BASE_URL_MAKE_PAYMENT;

    paymentReq.paymentTimeStamp = new DateFormat('dd/MM/yyyy hh:mm:ss')
        .format(DateTime.parse(DateTime.now().toString()));

    ////debugPrint("makePayment sent json ---------- " +
    // json.encode(paymentReq.toJson()));
    // return placeOrderRequest;
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(paymentReq.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);
    ////debugPrint("make payment request ------ " + jsonObj.toString());

    Payment paymentResponse = Payment.fromJSON(jsonObj);

    return paymentResponse;
  }

  // end of make payment

  // raise issue

  Future<ComplaintRequest> raiseIssue(ComplaintRequest complaintReq) async {
    String url = BASE_URL + BASE_URL_MAKE_COMPLAINT;

    // complaintReq.tableidtimestamp = new DateFormat('dd/MM/yyyy hh:mm:ss')
    //   .format(DateTime.parse(DateTime.now().toString()));

    // debugPrint("complaintReq sent json ---------- " +
    //     json.encode(complaintReq.toJson()));
    // return placeOrderRequest;
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(complaintReq.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);
    ////debugPrint("complaintReq response ------ " + jsonObj.toString());

    ComplaintRequest complainResponse = ComplaintRequest.fromJSON(jsonObj);

    return complainResponse;
  }

// getfoodMenuBycategory
  Future<List<FoodItem>> getfoodMenuBycategory(String categoryTitle) async {
    FoodMenuRequest foodMenuRequest = FoodMenuRequest(); //currentCafe;
    foodMenuRequest.caffeID = currentCafe.caffeId;
    foodMenuRequest.foodcategory = categoryTitle;
    // offset = 160;
    String url = BASE_URL + BASE_URL_FOOD_MENU_BY_CATEGORY;
    ////debugPrint("requesting getfoodMenuBycategory --- \n" +
    // url +
    // "\n " +
    // foodMenuRequest.toJson().toString());
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(foodMenuRequest.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);
    ////debugPrint(jsonObj.toString());
    List<FoodItem> foodMenus = [];

    try {
      jsonObj.forEach((newJson) {
        var fi = FoodItem.fromJSON(newJson);
        ////debugPrint("food item from json " + fi.runtimeType.toString());

        FoodItem foodMenu = FoodItem.fromJSON(newJson);
        foodMenus.add(foodMenu);
      });
    } catch (e) {
      ////debugPrint(e.toString());
    }

    ////debugPrint("total food menus " + foodMenus.length.toString());

    return foodMenus;
  }

  Future<List<Status>> gethashTags() async {
    HashTagRequest hashTagRequest = HashTagRequest(); //currentCafe;
    hashTagRequest.caffeID = caffeID;
    hashTagRequest.currentdate = nowDate;
    // offset = 160;
    String url = BASE_URL + BASE_URL_TOP_HASH_TAG;
    ////debugPrint("requesting  gethashTags --- \n" + url + "\n post body--- " +hashTagRequest.toJson().toString());
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(hashTagRequest.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);
    // ////debugPrint("----- hash tag resp " + jsonObj.toString());
    List<Status> statusList = [];

    try {
      var statusJsonObj = jsonObj["status"];
      statusJsonObj.forEach((newJson) {
        Status status = Status.fromJSON(newJson);
        statusList.add(status);
      });
    } catch (e) {
      ////debugPrint(e.toString());
    }

    return statusList;
  }

  Future<List<StatusComment>> getComments(String foodHashtag) async {
    StatusComment commentRequest = StatusComment(); //currentCafe;
    commentRequest.caffeId = currentCafe.caffeId;
    commentRequest.foodHashtag = foodHashtag;
    // offset = 160;
    String url = BASE_URL + BASE_URL_COMMENT_BY_HASHTAG;
    ////debugPrint("requesting getComments --- \n" +
    // url +
    // "\n " +
    // commentRequest.toJson().toString());
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(commentRequest.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);
    ////debugPrint(jsonObj.toString());
    List<StatusComment> comments = [];

    try {
      jsonObj.forEach((newJson) {
        StatusComment comment = StatusComment.fromJSON(newJson);
        comments.add(comment);
      });
    } catch (e) {
      ////debugPrint(e.toString());
    }

    ////debugPrint("total comments on $foodHashtag" + comments.length.toString());

    return comments;
  }

  // increase like

  Future<LikeRequest> inCreaseLikeRequest(LikeRequest likeReq) async {
    String url = BASE_URL + BASE_URL_INCREASE_LIKE;
    ////debugPrint("inCreaseLikeRequest---" + likeReq.toJson().toString());
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(likeReq.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);

    LikeRequest reqReply =
        LikeRequest.fromJSON(jsonObj); //ClientInfo.fromJSON(jsonObj);

    return reqReply;
  }

  // make comment

  Future<StatusComment> makeCommentRequest(StatusComment commentReq) async {
    String url = BASE_URL + BASE_URL_MAKE_COMMENT;
    debugPrint(
        "make comment request----" + commentReq.toJsonMakeComment().toString());
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(commentReq.toJsonMakeComment()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);

    StatusComment reqReply =
        StatusComment.fromJSONreq(jsonObj); //ClientInfo.fromJSON(jsonObj);

    return reqReply;
  }

  // make feedback

  Future<FeedbackRequest> makefeedbackRequest(
      FeedbackRequest feedbackReq) async {
    String url = BASE_URL + BASE_URL_MAKE_FEEDBACK;
    ////debugPrint("make comment request----" + feedbackReq.toJson().toString());
    var response = await http
        .post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(feedbackReq.toJson()),
    )
        .catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );

    var jsonObj = json.decode(response.body);

    FeedbackRequest reqReply = FeedbackRequest.fromJSONresponse(
        jsonObj); //ClientInfo.fromJSON(jsonObj);

    return reqReply;
  }

/*
 Im settling on Flutter because the productivity of the tooling and the speed of development is far greater than any other i’ve seen
  */

/*
  Future<List<Product>> getProductByCategory(Category category,int offset) async {
    String url =
        BASE_URL_WC + BASE_URL_BOOKS_BY_CATEGORY + category.id.toString() + "?per_page=10" +"&offset=$offset" + "&consumer_key=" + CONSUMER_KEY + "&consumer_secret=" + CONSUMER_SECRET;;
    // ////debugPrint("requesting by category--- \n" + url);
    var response = await http
        .get(
      url,
    )
        .catchError(
      (error) {
        return false;
      },
    );

    // return json.decode(response.body);

    // var totalPage = response.headers['x-wp-totalpages'].toString();

    // ////debugPrint("total pages of categories "+ totalPage.toString());

    // ////debugPrint("total items "+ response.headers['x-wp-total']);

    var jsonObj = json.decode(response.body);

    List<Product> products = [];

    jsonObj.forEach((newJson) {
      Product product = Product.fromJSON(newJson);
      products.add(product);
    });

    return products;
  }

Future<RegReply> registerRequest(RegReply user) async {
  String url = BASE_URL_WP + BASE_URL_REGISTER;

    var response = await http
        .post(
      url,
      headers:{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: json.encode(user.toJson()),
    ).catchError(
      (error) {
        ////debugPrint(error.toString());
        return false;
      },
    );


   var jsonObj = json.decode(response.body);

   RegReply regReply = RegReply.fromJSON(jsonObj); 

  return regReply;

}
*/

}

FinesseApi api = FinesseApi();
