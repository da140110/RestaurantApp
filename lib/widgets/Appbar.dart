import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/complaint.dart';
import 'package:finesse/model/complaint_request.dart';
import 'package:finesse/util/text_styles.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CustomAppBar {

  static List<String> options = <String>[
    'Need Assistance',
    'Need Water',
    'Clean the Table',
    'Order Assistance',
  ];

  static Widget getAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1A1A1A),
        automaticallyImplyLeading: false, // Don't show the leading button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Image.asset(
                UIData.image_frinks,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(MENU_SCREEN);
              },
            ),
            SizedBox(
              width: 50.0,
            ),
            Text(
                "Welcome to ${currentCafe.caffename}, ${currentUser.clientName}!, you are sitting at Table no. ${currentUser.tableId}.",
              style: TextStyle(
                  fontFamily: UIData.font_nunito_sans,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
        actions: <Widget>[
          Container(
            height: 40,
            width: 40,
              child: new FloatingActionButton(
                  heroTag: "btn1",
                backgroundColor: Color(0xFF000000),
                  child: GestureDetector(
                    onTap: () => issueRaiseDialog(context),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Icon(
                          const IconData(0xe906, fontFamily: 'icomoon'),
                          color: Colors.white,
                          size: 25.0,
                        ),
//                  Container(
//                    width: 10.0,
//                    height: 10.0,
//                    margin: EdgeInsets.only(bottom: 20.0, left: 10.0),
//                    alignment: Alignment.center,
//                    child: Text(
//                      "1",
//                      style: TextStyle(
//                          fontSize: 8.0,
//                          fontFamily: UIData.font_nunito_sans,
//                          fontWeight: FontWeight.w700),
//                    ),
//                    decoration: BoxDecoration(
//                        color: Colors.red, shape: BoxShape.circle),
//                  )
                      ],
                    ),
                  )
              ),
          ),
          SizedBox(
            width: 12.0,
          ),
          Container(
            height: 40,
            width: 40,
            child: FloatingActionButton(
                heroTag: "btn2",
                backgroundColor: Color(0xFF000000),
                child: GestureDetector(
                    onTap: () {
                    Navigator.of(context).pushNamed(ORDER_SCREEN);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(
                          const IconData(0xe908, fontFamily: 'icomoon'),
                        color: Colors.white,
                        size: 25.0,
                      ),
//                  Container(
//                    width: 10.0,
//                    height: 10.0,
//                    margin: EdgeInsets.only(bottom: 20.0, left: 10.0),
//                    alignment: Alignment.center,
//                    child: Text(
//                      "1",
//                      style: TextStyle(
//                          fontSize: 8.0,
//                          fontFamily: UIData.font_nunito_sans,
//                          fontWeight: FontWeight.w700),
//                    ),
//                    decoration: BoxDecoration(
//                        color: Colors.red, shape: BoxShape.circle),
//                  )
                    ],
                  ),
                )
            ),
          ),
          SizedBox(
            width: 12.0,
          ),
          Container(
            height: 40,
            margin: EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0)),
              highlightColor: Colors.white,
              highlightElevation: 4.0,
              child: Text(
                UIData.label_exit,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: UIData.font_nunito_sans,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0),
              ),
              color: Color(0xFFF85912),
              elevation: 4.0,
              onPressed: () {
                Navigator.of(context).pushNamed(ORDER_SCREEN);
              },
            ),
          ),
        ],
      ),
    );
  }

  //----------------------------- Start of Issue Raise Dialouge---------------------------------------------------

  static void issueRaiseDialog(BuildContext context) {
    bool done = true;
    Size size = MediaQuery.of(context).size;
    Dialog issueRaiseDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
         side: BorderSide(color: Colors.black,
             width: 2.0,
             style: BorderStyle.solid),
      ), //this right here
      child: SingleChildScrollView(
        child: Container(
          width: size.width / 3,
          // width: size.width / 2,
          padding: EdgeInsets.only(
            left: 24.0,
          ),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Colors.black87,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Icon(
                      const IconData(0xe907, fontFamily: 'icomoon'),
                      color: Colors.white,
                      size: 14,
                    ), //Image.asset(name),
                    shape: CircleBorder(),
                    color: Colors.black,
                    splashColor: Colors.white,
                    disabledColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      UIData.title_issue_dialoge,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: UIData.font_nunito_sans,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 8.0,
                  top: 8.0,
                ),
                child: Text(
                  UIData.subtitle_issue_dialoge,
                  maxLines: 3,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: UIData.font_nunito_sans,
                      fontStyle: FontStyle.italic,
                      fontSize: 15),
                ),
              ),
              new MyDialogContent(countries: options),
              // Padding(padding: EdgeInsets.only(top: 50.0)),
              SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: 120,
                    child: FlatButton(
                        color: Colors.black,
                        padding: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        onPressed: () {
                          if(done){
                            done = false;
                          reportIssueButtonPressed(context);
                          }
                        },
                        child: Text(
                          UIData.label_done,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: UIData.font_nunito_sans,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 48,
              )
            ],
          ),
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => issueRaiseDialog);
  }

  //----------------------------- end of Issue Raise Dialouge ---------------------------------------------------

  // send comment to api

  static void reportIssueButtonPressed(BuildContext context){

    // 06/03/2019 19:59:45
    Complaint complaint = Complaint();
    complaint.issue = SELECTED_OPTION;
    complaint.currentStatus = "OPEN";
    complaint.complaintTime =  new DateFormat('dd/MM/yyyy hh:mm:ss')
      .format(DateTime.parse(DateTime.now().toString()));

    List<Complaint> complainList = [];  
    complainList.add(complaint);

    ComplaintRequest complaintRequest = ComplaintRequest();
    complaintRequest.caffeId = currentCafe.caffeId;
    complaintRequest.currentDate = new DateFormat('dd/MM/yyyy')
      .format(DateTime.parse(DateTime.now().toString()));

    complaintRequest.tableidtimestamp = currentUser.tableIdTimestamp;
    complaintRequest.tableid = currentUser.tableId;
    complaintRequest.complaintList = complainList;


    api.raiseIssue(complaintRequest).then((reqResponse){

      if(reqResponse.complaintResponse.compareTo("success")==0){
            issueRaiseDialogConfirmation(context);
            
      } 

    });

    // api.raiseIssue(complaintRequest);


  }



  //----------------------------- Start of Issue Raise Dialouge Confirmation ---------------------------------------------------

  static void issueRaiseDialogConfirmation(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Dialog issueRaiseDialogConfirm = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        side: BorderSide(color: Colors.black),
      ), //this right here
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Color.fromRGBO(0, 0, 0, .85),
          ),
          padding: EdgeInsets.only(
            left: 24.0,
          ),
          width: size.width / 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Icon(
                      const IconData(0xe907, fontFamily: 'icomoon'),
                      color: Colors.white,
                      size: 14,
                    ), //Image.asset(name),
                    shape: CircleBorder(),
                    color: Colors.black,
                    splashColor: Colors.white,
                    disabledColor: Colors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    UIData.title_issue_dialoge,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: UIData.font_nunito_sans,
                        fontSize: 19,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      UIData.subtitle_issue_dialoge,
                      maxLines: 3,
                      // overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: UIData.font_nunito_sans,
                          fontStyle: FontStyle.italic,
                          fontSize: 10),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    SELECTED_OPTION,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: UIData.font_nunito_sans,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Text(
                      UIData.msg_issue_raised,
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: UIData.font_nunito_sans,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        issueRaiseDialog(context);
                      },
                      child: Text(
                        UIData.title_raise_another,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: UIData.font_nunito_sans,
                            fontWeight: FontWeight.w700),
                      )),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
            ],
          ),
        ),
      ),
    );
    Navigator.of(context).pop();
    showDialog(
        context: context,
        builder: (BuildContext context) => issueRaiseDialogConfirm);
  }

  // ----------------------------- end of Issue Raise Dialouge Confirmation ---------------------------------------------------
}

// ------------------------- show issue list in dialog---------------------

class MyDialogContent extends StatefulWidget {
  MyDialogContent({
    Key key,
    this.countries,
  }) : super(key: key);

  final List<String> countries;

  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  int _selectedIndex = 99;

  TextEditingController additionalcommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    additionalcommentController.addListener(_setAdditionalComment);
  }

  @override
  void dispose(){
    super.dispose();
    additionalcommentController.removeListener(_setAdditionalComment);

  }

  

    _setAdditionalComment() {
    ADDITIONAL_COMMENT = additionalcommentController.text;
    SELECTED_OPTION = ADDITIONAL_COMMENT;
   
    setState(() {
       _selectedIndex = 99;
    });
    // //debugPrint("name is ---------" + name);
  }

  _getContent() {
    if (widget.countries.length == 0) {
      return new Container();
    }

    return Column(
      children: <Widget>[
        new Column(
            children: new List<RadioListTile<int>>.generate(
                widget.countries.length, (int index) {
          return new RadioListTile<int>(
            activeColor: Colors.green,
            value: index,
            groupValue: _selectedIndex,
            title: new Text(
              widget.countries[index],
              style: TextStyle(
                  color: Colors.white, fontFamily: UIData.font_nunito_sans),
            ),
            onChanged: (int value) {
              setState(() {
                _selectedIndex = value;
                SELECTED_OPTION = widget.countries[index];
              });
            },
          );
        })),
        commentRow(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  Widget commentRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: additionalcommentController,
            style: TextStyles.COMMENT_TEXT_STYLE,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              // labelText: UIData.label_name,
              hintText: UIData.title_additional_comments,
              hintStyle: TextStyles.COMMENT_TEXT_STYLE,
              // labelStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
              filled: true,
              fillColor: Colors.grey,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
                borderSide: BorderSide(
                    color: Colors.grey, width: 2.0, style: BorderStyle.solid),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
                borderSide: BorderSide(
                    color: Colors.grey, width: 4.0, style: BorderStyle.solid),
              ),
            ),
            cursorColor: Colors.black,
          ),
          flex: 15,
        ),
        SizedBox(
          width: 25,
        ),
//        Expanded(
//          child: FlatButton(
//            child: Icon(
//              const IconData(0xe902, fontFamily: 'icomoon'),
//              color: Colors.white,
//              size: 20,
//            ), //Image.asset(name),
//////            shape: CircleBorder(),
////            color: Colors.black,
////            splashColor: Colors.white,
////            disabledColor: Colors.black,
////            onPressed: () {
////              // Navigator.of(context).pop();
////            },
//          ),
////          flex: 1,
//        )
      ],
    );
  }
}
