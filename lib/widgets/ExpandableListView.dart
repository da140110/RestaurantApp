import 'package:finesse/api/FinesseApi.dart';
import 'package:finesse/constant/Constant.dart';
import 'package:finesse/logic/bloc/comment_bloc.dart';
import 'package:finesse/model/comment.dart';
import 'package:finesse/model/increase_like_request.dart';
import 'package:finesse/model/status.dart';
import 'package:finesse/util/uidata.dart';
import 'package:flutter/material.dart';

class ExpandableListView extends StatefulWidget {
  final Status status;
  final TextEditingController wallTagController;

  const ExpandableListView({Key key, this.status,  this.wallTagController}) : super(key: key);

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState(status: this.status,wallTagController: this.wallTagController);
}

class _ExpandableListViewState extends State<ExpandableListView> {
  bool expandFlag = false;

  CommentBloc commentBloc = CommentBloc();

  //  TopFoodHashTagBloc topFoodHashTagBloc = TopFoodHashTagBloc();

  String SHOW_COMMENTS = "show comments";
  String HIDE_COMMENT = "hide";

  int topCommentLikeCount = 0;

  // String toogle_comment_controll;

    final Status status;
    final TextEditingController wallTagController;

  _ExpandableListViewState({this.status,this.wallTagController});

  @override
  void initState(){
    // commentBloc.getComments(status.hashtag);
    super.initState();
    topCommentLikeCount = status.likeCount;

  }

    Widget commentListView(List<StatusComment> commentList){
          return ListView.builder(
          // shrinkWrap: false,
      itemBuilder: (BuildContext context, int index) {
        // return new Container(
        //             decoration: new BoxDecoration(
        //                 border: new Border.all(width: 1.0, color: Colors.grey),
        //                 color: Colors.black),
        //             child: new ListTile(
        //               title: new Text(
        //                 commentList[index].foodComment,
        //                 style: new TextStyle(
        //                     fontWeight: FontWeight.bold, color: Colors.white),
        //               ),
        //               // leading: new Icon(
        //               //   Icons.local_pizza,
        //               //   color: Colors.white,
        //               // ),
        //             ),
        //           );
                return  Container(
                          decoration: new BoxDecoration(
            // border: new Border.all(width: 1.0, color: Colors.grey)
              border: new Border(top: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey))
            ),
                  child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new InkWell(
                  // show comment button ..........
                  onTap: () {
                    setState(() {
                      expandFlag = !expandFlag;
                    });
                  },
                  child: new Container(
                    //width: 50.0,
                    //height: 50.0,
                    padding: const EdgeInsets.fromLTRB(
                        8.0,
                        4.0,
                        4.0,
                        4.0
                        ), //I used some padding without fixed width and height
                    decoration: new BoxDecoration(
                      // color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: new Text(
                         commentList[index].foodComment,//"Show comments",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize:
                                12.0)), // You can add a Icon instead of text also, like below.
                    //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                  ), //
              ),
              // ----------- like button 
              new FlatButton(
                  onPressed: (){
                    // like button pressed
                    _actionLikeButton(commentList[index].commentid);
                  },
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: 20,
//                        shape: new CircleBorder(),
//                        color: Colors.black,
                      decoration: new BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        const IconData(0xe905, fontFamily: 'icomoon') ,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    new Text(
                        commentList[index].like.toString(),
                        style:
                        new TextStyle(color: Colors.white)),
                  ],
                ),
              )
            ],
          ),
                );
      },
      itemCount: commentList.length,
          );
  }

  void _actionLikeButton(String commentid){

    LikeRequest likeRequest = LikeRequest();

    likeRequest.caffeID = caffeID;
    likeRequest.commentId = commentid;

    api.inCreaseLikeRequest(likeRequest).then((likeResponse) {
      //debugPrint("like increased " + likeResponse.status);

      if(likeResponse.status.compareTo(likeSuccessfulStatus)==0){
          commentBloc.getComments(status.hashtag);
          if(commentid.compareTo(status.topCommentId)==0){

             
        setState(() {
          //debugPrint("set state called ");
           topCommentLikeCount++;
        });

          }


      }

    });
  }


  Widget commentRow() {
    return StreamBuilder<List<StatusComment>>(
        stream: commentBloc.commentss,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? commentListView(snapshot.data)//hashTagGrid(snapshot.data)
              : Center(child: CircularProgressIndicator());
        });
  }



  @override
  Widget build(BuildContext context) {
    //debugPrint("commentBloc.getComments(status.hashtag)");
commentBloc.getComments(status.hashtag);
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 1.0),
      child: new Column(
        children: <Widget>[
          commentListItem(),
          new ExpandableContainer(
              expanded: expandFlag,
              ///--------------------------expandable list of  comments on a tag ----------------
              child: commentRow(),
              // new ListView.builder(
              //   itemBuilder: (BuildContext context, int index) {
              //     return new Container(
              //       decoration: new BoxDecoration(
              //           border: new Border.all(width: 1.0, color: Colors.grey),
              //           color: Colors.black),
              //       child: new ListTile(
              //         title: new Text(
              //           "Cool $index",
              //           style: new TextStyle(
              //               fontWeight: FontWeight.bold, color: Colors.white),
              //         ),
              //         leading: new Icon(
              //           Icons.local_pizza,
              //           color: Colors.white,
              //         ),
              //       ),
              //     );
              //   },
              //   itemCount: 5,
              // )
              
              )
              // ------------------------------end of list view -----------------------------------
        ],
      ),
    );
  }

  Widget commentListItem() {
    return new Container(
      // color: Colors.blue,
      padding: new EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //--------------------- hash tag
              Text(
                status.hashtag,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: UIData.font_nunito_sans,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              // --- upvote button-----------
              Container(
                height: 20.0,
                child: FlatButton(
                  onPressed: () {
                    UPVOTED_HASHTAG = status.hashtag;
                    wallTagController.text = UPVOTED_HASHTAG;
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        "upvote",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: UIData.font_nunito_sans,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 1,
                      ),
                      Container(
                        height: 17,
                        width: 17,
//                        shape: new CircleBorder(),
//                        color: Colors.black,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8.5),
                        ),
                        child: Icon(
                          const IconData(0xe901, fontFamily: 'icomoon') ,
                          color: Colors.white,
                          size: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //------ top comment--------------
          Row(
            children: <Widget>[
              Text(
                status.topComment == null ? " ":status.topComment,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: UIData.font_nunito_sans,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new InkWell(
                // show comment button ..........
                onTap: () {
                  setState(() {
                    expandFlag = !expandFlag;
                  });
                },
                child: new Container(
                  //width: 50.0,
                  //height: 50.0,
                  padding: const EdgeInsets.all(
                      4.0), //I used some padding without fixed width and height
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: new Text(
                       expandFlag ? HIDE_COMMENT: SHOW_COMMENTS,//"Show comments",
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize:
                              12.0)), // You can add a Icon instead of text also, like below.
                  //child: new Icon(Icons.arrow_forward, size: 50.0, color: Colors.black38)),
                ), //
              ),
              // ----------- like button 
              new FlatButton(
                onPressed: (){
                  // like button pressed
                  _actionLikeButton(status.topCommentId);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: 20,
//                        shape: new CircleBorder(),
//                        color: Colors.black,
                      decoration: new BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        const IconData(0xe905, fontFamily: 'icomoon') ,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    new Text(
                      topCommentLikeCount.toString(),
                        style:
                            new TextStyle(color: Colors.white, fontSize: 12.0)),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 100.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return new AnimatedContainer(
      duration: new Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: new Container(
        child: child,
        decoration: new BoxDecoration(
            // border: new Border.all(width: 1.0, color: Colors.grey)
              border: new Border(top: BorderSide(width: 1.0, color: Colors.grey),
              bottom: BorderSide(width: 1.0, color: Colors.grey))
            ),
      ),
    );
  }
}
