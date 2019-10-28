import 'dart:async';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/util/text_styles.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finesse/logic/bloc/cafe_info_bloc.dart';
import 'package:finesse/model/cafe_info.dart';
import 'package:screen/screen.dart';


class TableIDScreen extends StatefulWidget {
  @override
  TableIDScreenState createState() => new TableIDScreenState();
}

class TableIDScreenState extends State<TableIDScreen>
    with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  CafeInfoBloc cafeInfoBloc = CafeInfoBloc();

  String tableID;

  TextEditingController tableIDController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Screen.setBrightness(0.2);
    tableIDController.addListener(_settableID);
    cafeInfoBloc.getCafeInfoFromRemote();
  }

  _settableID() {
    tableID = tableIDController.text;
    currentUser.tableId = tableID;
  }


  Widget feedCafeInfo() {
    return StreamBuilder(
        stream: cafeInfoBloc.cafeInfo,
        builder: (context, snapshot) {
          CafeInfo cafeInfo = snapshot.data;

          if(snapshot.hasData)
          {
            currentCafe = cafeInfo;
          }
          return snapshot.hasData
          ?Container(
              margin: EdgeInsets.fromLTRB(300.0, 50.0, 300.0, 20.0),
              child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      currentCafe.caffename,
                      style: TextStyle(
                          fontFamily: UIData.font_nunito_sans,
                          fontSize: 29.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${currentCafe.caffeAddress} | ${currentCafe.type}',
                      style: TextStyle(
                        fontFamily: UIData.font_nunito_sans,
                        fontSize: 17.0,
                        color: Color(0xFF8B8B8B),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            )
          )
                : Center(child: CircularProgressIndicator());

        });
  }



  Future<bool> _onBackPressed() async{
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: <Widget>[
                feedCafeInfo(),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(300.0, 0.0, 300.0, 0.0),
                  child: TextField(
                    controller: tableIDController,
                    style: TextStyles.TEXT_FIELD_INPUT_STYLE,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Table ID",
                      hintStyle: TextStyles.TEXT_FIELD_LABLE_STYLE,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(300.0, 20.0, 300.0, 48.0),
                  alignment: Alignment.bottomRight,
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(48.0, 15.0, 48.0, 15.0),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    highlightColor: Colors.white,
                    highlightElevation: 4.0,
                    child: Text(
                      UIData.label_done,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: UIData.font_nunito_sans,
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0),
                    ),
                    color: Colors.black,
                    elevation: 8.0,
                    onPressed: () {
                      Navigator.of(context).pushNamed(SPLASH_SCREEN);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}











