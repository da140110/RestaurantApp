import 'dart:async';
import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/model/feedback.dart';
import 'package:finesse/model/feedback_request.dart';
import 'package:finesse/util/text_styles.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  FeedbackScreenState createState() => new FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen>
    with SingleTickerProviderStateMixin {
  Size screenSize;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String additionalComments;
  String Star_on = UIData.image_star_on;
  String Star_off = UIData.image_star_off;

  String currentStar11 = UIData.image_star_off;
  String currentStar12 = UIData.image_star_off;
  String currentStar13 = UIData.image_star_off;
  String currentStar14 = UIData.image_star_off;
  String currentStar15 = UIData.image_star_off;
  
  int feedbackStarRow1Count = 0;

  String currentStar21 = UIData.image_star_off;
  String currentStar22 = UIData.image_star_off;
  String currentStar23 = UIData.image_star_off;
  String currentStar24 = UIData.image_star_off;
  String currentStar25 = UIData.image_star_off;

    int feedbackStarRow2Count = 0;

  String currentStar31 = UIData.image_star_off;
  String currentStar32 = UIData.image_star_off;
  String currentStar33 = UIData.image_star_off;
  String currentStar34 = UIData.image_star_off;
  String currentStar35 = UIData.image_star_off;

    int feedbackStarRow3Count = 0;

  String currentStar41 = UIData.image_star_off;
  String currentStar42 = UIData.image_star_off;
  String currentStar43 = UIData.image_star_off;
  String currentStar44 = UIData.image_star_off;
  String currentStar45 = UIData.image_star_off;

    int feedbackStarRow4Count = 0;

  String currentStar51 = UIData.image_star_off;
  String currentStar52 = UIData.image_star_off;
  String currentStar53 = UIData.image_star_off;
  String currentStar54 = UIData.image_star_off;
  String currentStar55 = UIData.image_star_off;

    int feedbackStarRow5Count = 0;

  final double starRowHeightScale = 0.03125;
  final double leftWidthScale = .2872; //.557;
  final double bodyWidthScale = .7128;
  final double leftPaddingScale = 0.078125;
  final double topPaddingScale = 0.166;
  final double verticalGapBetweenfields = 12.0;

  TextEditingController additionalCommentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    additionalCommentsController.addListener(_setAdditionalComment);
  }

  _doneButtonPressed() {

    List<FeedbackInfo> feedbackInfos = [];

    FeedbackInfo feedbackinfo = FeedbackInfo();
    feedbackinfo.question = UIData.label_feedback_one;
    feedbackinfo.answer = feedbackStarRow1Count.toString();
    feedbackInfos.add(feedbackinfo);

    feedbackinfo = FeedbackInfo();
    feedbackinfo.question = UIData.label_feedback_two;
    feedbackinfo.answer = feedbackStarRow2Count.toString();
    feedbackInfos.add(feedbackinfo);

        feedbackinfo = FeedbackInfo();
    feedbackinfo.question = UIData.label_feedback_three;
    feedbackinfo.answer = feedbackStarRow3Count.toString();
    feedbackInfos.add(feedbackinfo);


        feedbackinfo = FeedbackInfo();
    feedbackinfo.question = UIData.label_feedback_four;
    feedbackinfo.answer = feedbackStarRow4Count.toString();
    feedbackInfos.add(feedbackinfo);


        feedbackinfo = FeedbackInfo();
    feedbackinfo.question = UIData.label_feedback_five;
    feedbackinfo.answer = feedbackStarRow5Count.toString();
    feedbackInfos.add(feedbackinfo);



    FeedbackRequest  feedbackRequest = FeedbackRequest();
    feedbackRequest.caffeID = caffeID;
    feedbackRequest.tableidtimestamp = currentUser.tableIdTimestamp;
    feedbackRequest.feedback_comment = additionalComments;
    feedbackRequest.feedbackList = feedbackInfos;

        api.makefeedbackRequest(feedbackRequest).then((feedbackResponse) {
      //debugPrint("feedback placed " + feedbackResponse.feedbackResponse);

      if(feedbackResponse.feedbackResponse.compareTo("success")==0){
        currentOrderList.clear();
        totalPayable = 0.0;
        Navigator.of(context).pushNamed(THANK_YOU_SCREEN);

      }

    });

   
  }

  void showSnackBar() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        "Please rate Overall Experience and FRINKS Digital Menu",
        style: TextStyle(
            fontFamily: UIData.font_nunito_sans,
            fontSize: 31.0,
            fontWeight: FontWeight.w300),
      ),
    ));
  }

  _setAdditionalComment() {
    additionalComments = additionalCommentsController.text;
    // //debugPrint("name is ---------" + name);
  }

  Future<bool> _onBackPressed() async{
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    var size = MediaQuery.of(context).size;
    screenSize = size;
    //debugPrint(" height -- " + size.height.toString());
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
//        appBar: CustomAppBar.getAppBar(context),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    width: size.width * leftWidthScale,
                    height: size.height,
                    child: Opacity(
                      opacity: 1,
                      child: new Image.asset(
                        UIData.image_left_background,
                        fit: BoxFit.cover,
//                        color: Colors.black54,
//                        colorBlendMode: BlendMode.darken,
                      ),
                    )),
                Container(
                    width: size.width * bodyWidthScale,
                    padding: EdgeInsets.only(
                      top: (size.height * topPaddingScale) / 4,
                      left: (size.width * leftPaddingScale)/2,
                      right: (size.width * leftPaddingScale) / 2,
                    ),
                    child: bodyContent()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget commentRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: additionalCommentsController,
            style: TextStyles.COMMENT_TEXT_STYLE,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: UIData.title_additional_comments,
              hintStyle: TextStyles.COMMENT_TEXT_STYLE,
              filled: true,
              fillColor: Color.fromRGBO(39, 38, 38, .158),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
                borderSide: BorderSide(
                    color: Colors.black45,
                    width: 1.0,
                    style: BorderStyle.solid),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18.0),
                ),
                borderSide: BorderSide(
                    color: Colors.black45,
                    width: 1.0,
                    style: BorderStyle.solid),
              ),
            ),
            cursorColor: Colors.black,
          ),
          flex: 7,
        ),
      ],
    );
  }

  Widget feedbackStarRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            UIData.label_feedback_one,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: UIData.font_nunito_sans,
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700),
          ),
          flex: 4,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow1Count = 1;
                      if (currentStar11.compareTo(Star_off) == 0) {
                        currentStar11 = Star_on;
                        feedbackStarRow1Count = 1;
                      } else if (currentStar11.compareTo(Star_on) == 0) {
                        currentStar11 = Star_off;
                        feedbackStarRow1Count = 0;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow1Count>=1? Star_on:currentStar11,
                    // feedbackStarRow1Count>=1? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow1Count = 2;
                      if (currentStar12.compareTo(Star_off) == 0) {
                        currentStar12 = Star_on;
                        feedbackStarRow1Count = 2;
                      } else if (currentStar12.compareTo(Star_on) == 0) {
                        currentStar12 = Star_off;
                        feedbackStarRow1Count = 2;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow1Count>=2? Star_on:Star_off,
                    // currentStar12,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow1Count = 3;
                      if (currentStar13.compareTo(Star_off) == 0) {
                        currentStar13 = Star_on;
                        
                      } else if (currentStar13.compareTo(Star_on) == 0) {
                        currentStar13 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow1Count>=3? Star_on:Star_off,
                    // currentStar13,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow1Count = 4;
                      if (currentStar14.compareTo(Star_off) == 0) {
                        currentStar14 = Star_on;
                      } else if (currentStar14.compareTo(Star_on) == 0) {
                        currentStar14 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow1Count>=4? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow1Count = 5;
                      if (currentStar15.compareTo(Star_off) == 0) {
                        currentStar15 = Star_on;
                      } else if (currentStar15.compareTo(Star_on) == 0) {
                        currentStar15 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow1Count>=5? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
            ],
          ),
          flex: 5,
        )
      ],
    );
  }

  Widget feedbackStarRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            UIData.label_feedback_two,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: UIData.font_nunito_sans,
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700),
          ),
          flex: 4,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      feedbackStarRow2Count = 1;
                      if (currentStar21.compareTo(Star_off) == 0) {
                        currentStar21 = Star_on;
                        feedbackStarRow2Count = 1;
                      } else if (currentStar21.compareTo(Star_on) == 0) {
                        currentStar21 = Star_off;
                        feedbackStarRow2Count = 0;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow2Count>=1? Star_on:currentStar21,
                    
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow2Count = 2;
                      if (currentStar22.compareTo(Star_off) == 0) {
                        currentStar22 = Star_on;
                      } else if (currentStar22.compareTo(Star_on) == 0) {
                        currentStar22 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow2Count>=2? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow2Count = 3;
                      if (currentStar23.compareTo(Star_off) == 0) {
                        currentStar23 = Star_on;
                      } else if (currentStar23.compareTo(Star_on) == 0) {
                        currentStar23 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow2Count>=3? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow2Count = 4;
                      if (currentStar24.compareTo(Star_off) == 0) {
                        currentStar24 = Star_on;
                      } else if (currentStar24.compareTo(Star_on) == 0) {
                        currentStar24 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow2Count>=4? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow2Count = 5;
                      if (currentStar25.compareTo(Star_off) == 0) {
                        currentStar25 = Star_on;
                      } else if (currentStar25.compareTo(Star_on) == 0) {
                        currentStar25 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow2Count>=5? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
            ],
          ),
          flex: 5,
        )
      ],
    );
  }

  Widget feedbackStarRow3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            UIData.label_feedback_three,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: UIData.font_nunito_sans,
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700),
          ),
          flex: 4,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow3Count = 1;
                      if (currentStar31.compareTo(Star_off) == 0) {
                        currentStar31 = Star_on;
                        feedbackStarRow3Count = 1;
                      } else if (currentStar31.compareTo(Star_on) == 0) {
                        currentStar31 = Star_off;
                        feedbackStarRow3Count = 0;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow3Count>=1? Star_on:currentStar31,
                    // currentStar31,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow3Count = 2;
                      if (currentStar32.compareTo(Star_off) == 0) {
                        currentStar32 = Star_on;
                      } else if (currentStar32.compareTo(Star_on) == 0) {
                        currentStar32 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow3Count>=2? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow3Count = 3;
                      if (currentStar33.compareTo(Star_off) == 0) {
                        currentStar33 = Star_on;
                      } else if (currentStar33.compareTo(Star_on) == 0) {
                        currentStar33 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow3Count>=3? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow3Count = 4;
                      if (currentStar34.compareTo(Star_off) == 0) {
                        currentStar34 = Star_on;
                      } else if (currentStar34.compareTo(Star_on) == 0) {
                        currentStar34 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow3Count>=4? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow3Count = 5;
                      if (currentStar35.compareTo(Star_off) == 0) {
                        currentStar35 = Star_on;
                      } else if (currentStar35.compareTo(Star_on) == 0) {
                        currentStar35 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow3Count>=5? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
            ],
          ),
          flex: 5,
        )
      ],
    );
  }

  Widget feedbackStarRow4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            UIData.label_feedback_four,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: UIData.font_nunito_sans,
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700),
          ),
          flex: 4,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow4Count = 1;
                      if (currentStar41.compareTo(Star_off) == 0) {
                        currentStar41 = Star_on;
                        feedbackStarRow4Count = 1;
                      } else if (currentStar41.compareTo(Star_on) == 0) {
                        currentStar41 = Star_off;
                        feedbackStarRow4Count = 0;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow4Count>=1? Star_on:currentStar41,
                    // currentStar41,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow4Count = 2;
                      if (currentStar42.compareTo(Star_off) == 0) {
                        currentStar42 = Star_on;
                      } else if (currentStar42.compareTo(Star_on) == 0) {
                        currentStar42 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow4Count>=2? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow4Count = 3;
                      if (currentStar43.compareTo(Star_off) == 0) {
                        currentStar43 = Star_on;
                      } else if (currentStar43.compareTo(Star_on) == 0) {
                        currentStar43 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow4Count>=3? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow4Count = 4;
                      if (currentStar44.compareTo(Star_off) == 0) {
                        currentStar44 = Star_on;
                      } else if (currentStar44.compareTo(Star_on) == 0) {
                        currentStar44 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow4Count>=4? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow4Count = 5;
                      if (currentStar45.compareTo(Star_off) == 0) {
                        currentStar45 = Star_on;
                      } else if (currentStar45.compareTo(Star_on) == 0) {
                        currentStar45 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow4Count>=5? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
            ],
          ),
          flex: 5,
        )
      ],
    );
  }

  Widget feedbackStarRow5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            UIData.label_feedback_five,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: UIData.font_nunito_sans,
                fontSize: 18,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w700),
          ),
          flex: 4,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow5Count = 1;
                      if (currentStar51.compareTo(Star_off) == 0) {
                        currentStar51 = Star_on;
                        feedbackStarRow5Count = 1;
                      } else if (currentStar51.compareTo(Star_on) == 0) {
                        currentStar51 = Star_off;
                        feedbackStarRow5Count = 0;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow5Count>=1? Star_on:currentStar51,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow5Count = 2;
                      if (currentStar52.compareTo(Star_off) == 0) {
                        currentStar52 = Star_on;
                      } else if (currentStar52.compareTo(Star_on) == 0) {
                        currentStar52 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow5Count>=2? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow5Count = 3;
                      if (currentStar53.compareTo(Star_off) == 0) {
                        currentStar53 = Star_on;
                      } else if (currentStar53.compareTo(Star_on) == 0) {
                        currentStar53 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow5Count>=3? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow5Count = 4;
                      if (currentStar54.compareTo(Star_off) == 0) {
                        currentStar54 = Star_on;
                      } else if (currentStar54.compareTo(Star_on) == 0) {
                        currentStar54 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow5Count>=4? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      feedbackStarRow5Count = 5;
                      if (currentStar55.compareTo(Star_off) == 0) {
                        currentStar55 = Star_on;
                      } else if (currentStar55.compareTo(Star_on) == 0) {
                        currentStar55 = Star_off;
                      }
                    });
                  },
                  child: Image.asset(
                    feedbackStarRow5Count>=5? Star_on:Star_off,
                    // scale: 16.0,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
            ],
          ),
          flex: 5,
        )
      ],
    );
  }

  Widget bodyContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  UIData.title_feedback,
                  style: TextStyle(
                      fontFamily: UIData.font_nunito_sans,
                      fontSize: 29.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 30),
                height: 40,
                width: 70,
                child: FloatingActionButton(
                  heroTag: 'btn7',
                  backgroundColor: Color(0xFF000000),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Icon(
                          const IconData(0xe909, fontFamily: 'icomoon'),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ), //Image.asset(name),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: <Widget>[
              Text(
                UIData.subtitle_feedback,
                style: TextStyle(
                  fontFamily: UIData.font_nunito_sans,
                  fontSize: 17.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 64.0, 10.0),
            alignment: Alignment.center,

            // color: Colors.white,
            height: screenSize.height * .0403,
            child: feedbackStarRow1(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 64.0, 10.0),
            alignment: Alignment.center,

            // color: Colors.white,
            height: screenSize.height * .0403,
            child: feedbackStarRow2(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 64.0, 10.0),
            alignment: Alignment.center,

            // color: Colors.white,
            height: screenSize.height * .0403,
            child: feedbackStarRow3(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 64.0, 10.0),
            alignment: Alignment.center,

            // color: Colors.white,
            height: screenSize.height * .0403,
            child: feedbackStarRow4(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 64.0, 10.0),
            alignment: Alignment.center,

            // color: Colors.white,
            height: screenSize.height * .0403,
            child: feedbackStarRow5(),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            alignment: Alignment.center,
            // color: Colors.white,
            child: commentRow(),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(48.0, 48.0, 0.0, 48.0),
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
              onPressed: (){
                if(feedbackStarRow1Count == 0 || feedbackStarRow2Count == 0) {
                  showSnackBar();
                } else{
                  _doneButtonPressed();
                }
                },
            ),
          ),
        ],
      ),
    );
  }

}
